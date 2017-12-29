# This PS installs the pre-compiled EPS32 libraries from our Bintray repository

# check if path already exists
$ESP32LibPathExists = Test-Path $env:ESP32_LIBS_PATH -ErrorAction SilentlyContinue

If($ESP32LibPathExists -eq $False)
{
    Install-Module 7Zip4PowerShell -Force -Verbose

    Write-Host "Downloading ESP32 pre-compiled libs..."

    $url = "https://bintray.com/nfbot/internal-build-tools/download_file?file_path=libs-file-name.7z"
    $output = "$PSScriptRoot\gcc-arm.7z"
    
    # download 7zip with toolchain
    (New-Object Net.WebClient).DownloadFile($url, $output)

    Write-Host "Installing ESP32 pre-compiled libs..."
    
    # unzip toolchain
    Expand-7Zip -ArchiveFileName $output -TargetPath $env:APPVEYOR_BUILD_FOLDER$env:ESP32_LIBS_PATH
}
