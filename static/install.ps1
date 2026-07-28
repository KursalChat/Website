# ──────────────────────────────────────────────
#  Kursal installer
#  Usage: powershell -c "irm kursal.chat | iex"
# ──────────────────────────────────────────────

param()
$ErrorActionPreference = 'Stop'

$KURSAL_BASE_URL = "https://app.kursal.chat"
$KURSAL_REPO = "KursalChat/Kursal"

function Get-ExpectedSha256($name) {
  try {
    $release = Invoke-RestMethod -Uri "https://api.github.com/repos/$KURSAL_REPO/releases/latest" -UseBasicParsing
    $asset = $release.assets | Where-Object { $_.name -eq $name } | Select-Object -First 1
    if ($asset -and $asset.digest -match '^sha256:([0-9a-fA-F]{64})$') {
      return $Matches[1]
    }
  } catch {}
  return $null
}

function ok($msg)   { Write-Host "  " -NoNewline; Write-Host "v" -NoNewline -ForegroundColor Green;  Write-Host "  $msg" }
function warn($msg) { Write-Host "  " -NoNewline; Write-Host "!" -NoNewline -ForegroundColor Yellow; Write-Host "  $msg" }
function err($msg)  { Write-Host "  " -NoNewline; Write-Host "x  $msg" -ForegroundColor Red; exit 1 }
function dim($msg)  { Write-Host "  $msg" -ForegroundColor DarkGray }

Clear-Host
Write-Host "   _  __                               _ "        -ForegroundColor White
Write-Host "  | |/ /  _   _   _ __   ___    __ _  | |"        -ForegroundColor White
Write-Host "  | ' /  | | | | | '__| / __|  / _  | | |"        -ForegroundColor White
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
  "ARM64" { err "ARM64 is not yet supported on Windows. Open an issue if you want to see it." }
  default { err "Unsupported architecture: $arch" }
}


$FILENAME = "Kursal_${ARCH_TAG}-setup.exe"
$DOWNLOAD_URL = "$KURSAL_BASE_URL/$FILENAME"


$TMP_DIR = Join-Path $env:TEMP ("kursal-" + [System.IO.Path]::GetRandomFileName())
New-Item -ItemType Directory -Path $TMP_DIR | Out-Null
$TMP_FILE = Join-Path $TMP_DIR $FILENAME

function Remove-TmpDir {
  try {
    if ($TMP_DIR -and (Test-Path -LiteralPath $TMP_DIR)) {
      Remove-Item -LiteralPath $TMP_DIR -Recurse -Force -ErrorAction SilentlyContinue
    }
  } catch {}
}

dim "> Downloading $FILENAME"

try {
  $prev = $ProgressPreference
  $ProgressPreference = 'SilentlyContinue'
  Invoke-WebRequest -Uri $DOWNLOAD_URL -OutFile $TMP_FILE -UseBasicParsing
  $ProgressPreference = $prev
} catch {
  err "Download failed. Check your connection or visit https://app.kursal.chat"
}

ok "Download complete"

dim "> Verifying integrity"
$expected = Get-ExpectedSha256 $FILENAME
$actual = (Get-FileHash -Path $TMP_FILE -Algorithm SHA256).Hash.ToLower()

if (-not $expected) {
  warn "Could not fetch the expected checksum from GitHub"
  dim "Proceeding, but this download could not be verified."
} elseif ($expected -eq $actual) {
  ok "Checksum verified"
} else {
  Remove-TmpDir
  err "Checksum mismatch, refusing to install. The file may be corrupt or tampered with."
}

dim "> Running installer"

$proc = Start-Process -FilePath $TMP_FILE -ArgumentList "/S" -Wait -PassThru

if ($proc.ExitCode -ne 0) {
  err "Installer exited with code $($proc.ExitCode)"
}

Remove-TmpDir


Write-Host ""
Write-Host "  Kursal installed successfully!" -ForegroundColor Green
Write-Host ""
dim "You can now launch Kursal from the Start Menu."
Write-Host ""
Write-Host "  Having issues? https://kursal.chat/issues" -ForegroundColor DarkGray
Write-Host ""