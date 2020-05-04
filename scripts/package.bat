@echo off

set script_dir=%~dp0

call "%script_dir%build.bat" %*

set rootdir=%script_dir%..\

cd "%rootdir%" || (
    echo Failed to change directory to %rootdir% >&2
    exit /B 1
)

md "%rootdir%temp" || (
    echo Failed to make %rootdir%temp directory >&2
    exit /B 1
)

md "%rootdir%temp\bin" || (
    echo Failed to make %rootdir%temp\bin >&2
    exit /B 1
)

md "%rootdir%temp\libexec" || (
    echo Failed to make %rootdir%temp\libexec >&2
    exit /B 1
)

move "%rootdir%cl2js.exe" "%rootdir%temp\libexec" || (
    echo Failed to move cl2js.exe to %rootdir%temp\libexec >&2
    exit /B 1
)

copy "%rootdir%scripts\cl2js.bat" "%rootdir%temp\bin" || (
    echo Failed to copy cl2js.bat to %rootdir%temp\bin >&2
    exit /B 1
)

move "%rootdir%temp" "%rootdir%cl2js" || (
    echo Failed to rename %rootdir%temp to %rootdir%cl2js >&2
    exit /B 1
)

rem Clean old state.
set pscmd=

rem Check whether PowerShell Core is available.
pswh -Help 1>nul 2>&1 && (
    set pscmd=pswh
)

rem Check whether PowerShell is available
rem  when PowerShell Core is not available.
if "%pscmd%" == "" (
    powershell -Help 1>nul 2>&1 && (
        set pscmd=powershell
    ) || (
        echo No PowerShell on the system >&2
        exit /B 1
    )
)

%pscmd% -Command "Get-Command -Name Compress-Archive -ErrorAction SilentlyContinue" 2>nul 1>&2
if not "%ERRORLEVEL%" == "0" (
    echo Compress-Archive is not supported on the system >&2
    echo Keep %rootdir%cl2js as-is >&2   
)

%pscmd% -Command "Compress-Archive -Path %rootdir%cl2js -DestinationPath %rootdir%cl2js.zip"
exit /B %ERRORLEVEL%
