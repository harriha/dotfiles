#
# Creates symlinks for Sublime Text 2 packages directories.
#
# Needs to be run as admin!
#
# Usage:
#   - Make sure you have the Sublime Text 2 package directories you want to use somewhere
#   - Run this script
#     - Give the root dir of the settings when prompted
#   - Done!
#

Param (
    [Parameter(Mandatory=$true,HelpMessage='Root dir of ST2 packages?')]
    [string]
    [ValidateScript({Test-Path $_})] 
    $rootDir
)

# Test if given path is a symlink. Stolen from http://stackoverflow.com/a/818054/173100
function Test-ReparsePoint([string]$path) {
  $file = Get-Item $path -Force -ea 0
  return [bool]($file.Attributes -band [IO.FileAttributes]::ReparsePoint)
}


cd "$env:APPDATA\Sublime Text 2"

$dirs = @("Installed Packages", "Packages", "Pristine Packages")

$dirs | foreach {

    # Don't remove if it's a symlink. Prevents catastrophes if run multiple times.
    if(!(Test-ReparsePoint($_))) {
        Remove-Item -Recurse -Force $_ -ErrorAction SilentlyContinue

        cmd /c mklink /D $_ "$rootDir\$_"
    }
    else {
        Write-Warning "The dir $_ is already a symlink, did NOT remove or create it."
    }
}

Read-Host "Done. Press a key to continue..."