:: 
:: Must be run as administrator!
::

cd %~dp0

PowerShell.exe Set-ExecutionPolicy RemoteSigned

PowerShell.exe -File "%~dp0\SetupSublimeText2.ps1"