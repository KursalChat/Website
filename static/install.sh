#!/usr/bin/env bash
set -euo pipefail

# ──────────────────────────────────────────────
#  Kursal installer
#  Usage: curl -fsSL https://kursal.chat | bash
# ──────────────────────────────────────────────

if [[ ${OS:-} = Windows_NT ]]; then
  if [[ $platform != MINGW64* ]]; then
    powershell -c "irm https://kursal.chat | iex"
    exit $?
  fi
fi

KURSAL_BASE_URL="https://app.kursal.chat"
KURSAL_BIN_DIR="$HOME/.local/bin"

printf "\x1b[2J\x1b[H" # clear screen

r="\033[0m"
bold="\033[1m"
dim="\033[2m"
italic="\033[3m"
blue="\033[34m"
green="\033[32m"
cyan="\033[36m"
yellow="\033[33m"
red="\033[31m"

print_ok()   { printf "  ${green}✓${r}  %s\n" "$1"; }
print_warn() { printf "  ${yellow}⚠${r}  %s\n" "$1"; }
print_err()  { printf "\n  ${red}✗  %s${r}\n" "$1" >&2; }
print_dim()  { printf "  ${dim}%s${r}\n" "$1"; }

printf "\n"
printf "  ${bold} _  __                               _ ${r}\n"
printf "  ${bold}| |/ /  _   _   _ __   ___    __ _  | |${r}\n"
printf "  ${bold}| ' /  | | | | | '__| / __|  / _\` | | |${r}\n"
printf "  ${bold}| . \\  | |_| | | |    \\__ \\ | (_| | | |${r}\n"
printf "  ${bold}|_|\\_\\  \\__,_| |_|    |___/  \\__,_| |_|${r}\n"
printf "\n"
printf "  ${italic}     Big Brother ${blue}was${r}${italic} watching you.     ${r}\n"
printf "\n"



OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
  Darwin) PLATFORM="macos" ;;
  Linux)  PLATFORM="linux" ;;
  *)
    print_err "Unsupported OS: $OS"
    print_dim "On Windows, run: irm https://kursal.chat | iex"
    exit 1
    ;;
esac

case "$ARCH" in
  x86_64|amd64)  ARCH_TAG="x64" ;;
  aarch64|arm64) ARCH_TAG="arm" ;;
  *)
    print_err "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

print_dim "▸ Detected $OS / $ARCH"


if [ "$PLATFORM" = "macos" ]; then
  [ "$ARCH_TAG" = "arm" ] && FILENAME="Kursal.dmg" || FILENAME="Kursal_x64.dmg"
  INSTALL_METHOD="dmg"
else
  if   command -v dpkg >/dev/null 2>&1; then FILENAME="Kursal_${ARCH_TAG}.deb"; INSTALL_METHOD="deb"
  elif command -v rpm  >/dev/null 2>&1; then FILENAME="Kursal_${ARCH_TAG}.rpm"; INSTALL_METHOD="rpm"
  else                                  FILENAME="Kursal_${ARCH_TAG}.AppImage"; INSTALL_METHOD="appimage"
  fi
fi

DOWNLOAD_URL="$KURSAL_BASE_URL/$FILENAME"


TMP_DIR="$(mktemp -d)"
TMP_FILE="$TMP_DIR/$FILENAME"
trap 'rm -rf "$TMP_DIR"' EXIT

print_dim "▸ Downloading $FILENAME"

curl -fSL --progress-bar "$DOWNLOAD_URL" -o "$TMP_FILE" || {
  print_err "Download failed — check your connection or visit https://kursal.chat/download"
  exit 1
}

print_ok "Download complete"

_sudo() { command -v sudo >/dev/null 2>&1 && sudo "$@" || "$@"; }

case "$INSTALL_METHOD" in

  dmg)
    MOUNT_POINT="$(mktemp -d)"
    hdiutil attach -quiet -nobrowse -mountpoint "$MOUNT_POINT" "$TMP_FILE"

    APP_SRC="$(find "$MOUNT_POINT" -maxdepth 1 -name '*.app' | head -1)"
    if [ -z "$APP_SRC" ]; then
      hdiutil detach -quiet "$MOUNT_POINT" || true
      print_err "Could not find .app bundle inside the DMG"
      exit 1
    fi

    DEST="/Applications/Kursal.app"
    [ -d "$DEST" ] && rm -rf "$DEST"
    cp -R "$APP_SRC" "$DEST"
    hdiutil detach -quiet "$MOUNT_POINT" || true

    xattr -d com.apple.quarantine "$DEST" 2>/dev/null || true

    print_ok "Installed to $DEST"
    ;;

  deb)
    _sudo dpkg -i "$TMP_FILE" >/dev/null
    print_ok "Installed via dpkg"
    ;;

  rpm)
    _sudo rpm -U --quiet "$TMP_FILE"
    print_ok "Installed via rpm"
    ;;

  appimage)
    mkdir -p "$KURSAL_BIN_DIR"
    DEST="$KURSAL_BIN_DIR/kursal"
    cp "$TMP_FILE" "$DEST"
    chmod +x "$DEST"
    print_ok "Installed to $DEST"

    if ! echo ":$PATH:" | grep -q ":$KURSAL_BIN_DIR:"; then
      printf "\n"
      print_warn "$KURSAL_BIN_DIR is not in your PATH"
      print_dim "Add this to your shell config (~/.bashrc, etc.):"
      printf "\n    ${bold}export PATH=\"\$HOME/.local/bin:\$PATH\"${r}\n"
    fi
    ;;

esac


printf "\n"
printf "  ${bold}${green}Kursal installed successfully!${r}\n"
printf "\n"

if [ "$PLATFORM" = "macos" ]; then
  print_dim "Launch it from Applications, or:"
  printf "    ${bold}open /Applications/Kursal.app${r}\n"
else
  print_dim "Run it with:"
  printf "    ${bold}kursal${r}\n"
fi

printf "\n  ${dim}Having issues? https://kursal.chat/issues${r}\n\n"