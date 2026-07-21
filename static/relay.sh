#!/usr/bin/env bash
set -euo pipefail

# ───────────────────────────────────────────────────────
#  Kursal relay installer
#  Usage: curl -fsSL https://kursal.chat/relay.sh | bash
# ───────────────────────────────────────────────────────

COMPOSE_URL="https://raw.githubusercontent.com/KursalChat/Kursal/main/docker/relay/compose.yml"
SYSTEMD_URL="https://raw.githubusercontent.com/KursalChat/Kursal/main/docker/relay/kursal-relay.service"
TARBALL_BASE="https://app.kursal.chat"
BIN_DEST="/usr/local/bin/kursal-relay"
BIN_IN_TARBALL="kursal-relay"

printf "\x1b[2J\x1b[H" # clear screen

r="\033[0m"
bold="\033[1m"
dim="\033[2m"
green="\033[32m"
yellow="\033[33m"
red="\033[31m"

print_ok()   { printf "  ${green}✓${r}  %s\n" "$1"; }
print_warn() { printf "  ${yellow}⚠${r}  %s\n" "$1"; }
print_err()  { printf "\n  ${red}✗  %s${r}\n" "$1" >&2; }
print_dim()  { printf "  ${dim}%s${r}\n" "$1"; }

_sudo() { command -v sudo >/dev/null 2>&1 && sudo "$@" || "$@"; }

printf "\n"
printf "  ${bold} _  __                               _ ${r}\n"
printf "  ${bold}| |/ /  _   _   _ __   ___    __ _  | |${r}\n"
printf "  ${bold}| ' /  | | | | | '__| / __|  / _  | | |${r}\n"
printf "  ${bold}| . \\  | |_| | | |    \\__ \\ | (_| | | |${r}\n"
printf "  ${bold}|_|\\_\\  \\__,_| |_|    |___/  \\__,_| |_|${r}\n"
printf "\n"
printf "  ${bold}         Kursal relay installer        ${r}\n"
printf "\n"

OS="$(uname -s)"
case "$OS" in
  Darwin) PLATFORM="macos" ;;
  Linux)  PLATFORM="linux" ;;
  *)
    print_err "Unsupported OS: $OS. This installer supports macOS and Linux only."
    exit 1
    ;;
esac

print_dim "▸ Detected $OS"

require_docker() {
  if ! command -v docker >/dev/null 2>&1; then
    print_warn "docker not detected on this system"
    if [ "$PLATFORM" = "macos" ]; then
      print_dim "We recommend OrbStack: https://orbstack.dev"
    else
      print_dim "Install it first: https://docs.docker.com/get-docker/"
    fi
    return 1
  fi
  return 0
}

run_docker_install() {
  DEST_DIR="$PWD/kursal-relay"
  mkdir -p "$DEST_DIR"
 
  print_dim "▸ Fetching compose.yml"
  curl -fsSL "$COMPOSE_URL" -o "$DEST_DIR/compose.yml" || {
    print_err "Failed to download compose.yml"
    exit 1
  }
 
  print_dim "▸ Starting relay container"
  ( cd "$DEST_DIR" && docker compose up -d )
 
  print_ok "Relay running in Docker"
  print_dim "Config: $DEST_DIR/relay.toml (created on first start)"
  print_dim "Edit announce_addr, then: cd $DEST_DIR && docker compose restart"
}

run_manual_install() {
  ARCH="$(uname -m)"
  case "$ARCH" in
    x86_64|amd64)  ARCH_TAG="x86_64" ;;
    aarch64|arm64) ARCH_TAG="aarch64" ;;
    *)
      print_err "Unsupported architecture: $ARCH"
      exit 1
      ;;
  esac

  FILENAME="kursal-relay-linux-$ARCH_TAG.tar.gz"
  DOWNLOAD_URL="$TARBALL_BASE/$FILENAME"

  print_dim "▸ Downloading $FILENAME"
  TMP_DIR="$(mktemp -d)"
  trap 'rm -rf "$TMP_DIR"' RETURN

  curl -fSL --progress-bar "$DOWNLOAD_URL" -o "$TMP_DIR/$FILENAME" || {
    print_err "Download failed. Check your connection."
    exit 1
  }

  print_dim "▸ Extracting binary"
  tar -xzf "$TMP_DIR/$FILENAME" -C "$TMP_DIR"

  if [ ! -f "$TMP_DIR/$BIN_IN_TARBALL" ]; then
    print_err "Could not find $BIN_IN_TARBALL inside the tarball"
    print_dim "Check the tarball layout and adjust BIN_IN_TARBALL in this script"
    exit 1
  fi

  _sudo mv "$TMP_DIR/$BIN_IN_TARBALL" "$BIN_DEST"
  _sudo chmod +x "$BIN_DEST"

  print_ok "Binary installed to $BIN_DEST"

  print_dim "▸ Fetching systemd unit"
  TMP_UNIT="$(mktemp)"
  curl -fsSL "$SYSTEMD_URL" -o "$TMP_UNIT" || {
    print_err "Failed to download systemd unit"
    exit 1
  }
  _sudo mv "$TMP_UNIT" /etc/systemd/system/kursal-relay.service

  _sudo systemctl daemon-reload
  _sudo systemctl enable --now kursal-relay

  print_ok "kursal-relay running via systemd"
  print_dim "Config: /var/lib/kursal-relay/relay.toml (created on first start)"
  print_dim "Edit announce_addr, then: systemctl restart kursal-relay"
  print_dim "Logs: journalctl -u kursal-relay -f"
}

if [ "$PLATFORM" = "macos" ]; then
  print_dim "▸ Docker is the only supported method on macOS"
  require_docker || exit 1

  read -rp "  Proceed with Docker install? [Y/n] " confirm < /dev/tty
  case "$confirm" in
    [nN]*)
      print_dim "Aborted"
      exit 0
      ;;
  esac

  run_docker_install
else
  printf "\n  Choose install method:\n"
  printf "    ${bold}1${r}) Docker\n"
  printf "    ${bold}2${r}) Manual (native binary + systemd)\n\n"
  read -rp "  > " choice < /dev/tty

  case "$choice" in
    1)
      require_docker || print_warn "Continuing anyway, docker compose will fail if it's missing"
      run_docker_install
      ;;
    2)
      run_manual_install
      ;;
    *)
      print_err "Invalid choice"
      exit 1
      ;;
  esac
fi

printf "\n  ${dim}Having issues? https://kursal.chat/issues${r}\n\n"