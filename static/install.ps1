# ──────────────────────────────────────────────
#  Kursal installer
#  Usage: irm https://kursal.chat | iex
# ──────────────────────────────────────────────

param()
$ErrorActionPreference = 'Stop'

$KURSAL_BASE_URL = "https://app.kursal.chat"

function ok($msg)   { Write-Host "  " -NoNewline; Write-Host "v" -NoNewline -ForegroundColor Green;  Write-Host "  $msg" }
function warn($msg) { Write-Host "  " -NoNewline; Write-Host "!" -NoNewline -ForegroundColor Yellow; Write-Host "  $msg" }
function err($msg)  { Write-Host "  " -NoNewline; Write-Host "x  $msg" -ForegroundColor Red; exit 1 }
function dim($msg)  { Write-Host "  $msg" -ForegroundColor DarkGray }

Clear-Host
Write-Host "   _  __                               _ "        -ForegroundColor White
Write-Host "  | |/ /  _   _   _ __   ___    __ _  | |"        -ForegroundColor White
Write-Host "  | ' /  | | | | | '__| / __|  / _' | | |"        -ForegroundColor White
Write-Host "  | . \  | |_| | | |    \__ \ | (_| | | |"        -ForegroundColor White
Write-Host "  |_|\_\  \__,_| |_|    |___/  \__,_| |_|"        -ForegroundColor White
Write-Host ""
Write-Host "       Big Brother " -NoNewline -ForegroundColor DarkGray
Write-Host "was"                 -NoNewline -ForegroundColor Blue
Write-Host " watching you.     " -ForegroundColor DarkGray
Write-Host ""

$arch = $env:PROCESSOR_ARCHITECTURE
switch ($arch) {
  "AMD64" { $ARCH_TAG = "x64" }
  "ARM64" { err "ARM64 is not yet supported on Windows — stay tuned!" }
  default { err "Unsupported architecture: $arch" }
}


$FILENAME = "Kursal_${ARCH_TAG}-setup.exe"
$DOWNLOAD_URL = "$KURSAL_BASE_URL/$FILENAME"


$TMP_DIR = Join-Path $env:TEMP ("kursal-" + [System.IO.Path]::GetRandomFileName())
New-Item -ItemType Directory -Path $TMP_DIR | Out-Null
$TMP_FILE = Join-Path $TMP_DIR $FILENAME

dim "> Downloading $FILENAME"

try {
  $prev = $ProgressPreference
  $ProgressPreference = 'SilentlyContinue'
  Invoke-WebRequest -Uri $DOWNLOAD_URL -OutFile $TMP_FILE -UseBasicParsing
  $ProgressPreference = $prev
} catch {
  err "Download failed — check your connection or visit https://app.kursal.chat"
}

ok "Download complete"
dim "> Running installer"

$proc = Start-Process -FilePath $TMP_FILE -ArgumentList "/S" -Wait -PassThru

if ($proc.ExitCode -ne 0) {
  err "Installer exited with code $($proc.ExitCode)"
}

Remove-Item -Recurse -Force $TMP_DIR -ErrorAction SilentlyContinue


Write-Host ""
Write-Host "  Kursal installed successfully!" -ForegroundColor Green
Write-Host ""
dim "You can now launch Kursal from the Start Menu."
Write-Host ""
Write-Host "  Having issues? https://kursal.chat/issues" -ForegroundColor DarkGray
Write-Host ""