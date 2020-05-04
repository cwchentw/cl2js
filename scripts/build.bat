@echo off

set cwd=%CD%

set script_path=%~dp0
set rootdir=%script_path%..\

cd %rootdir%

rem Constant
set SBCL="sbcl"
set CCL="ccl"

set lisp=%1

if %SBCL% == "%lisp%" goto check_sbcl
if %CCL% == "%lisp%" goto check_ccl

rem Fallback to SBCL
goto check_sbcl

rem Check whether SBCL is available.
:check_sbcl
sbcl --version 2>nul 1>&2 || (
      echo No SBCL on the system >&2
      exit /B 1
)
goto download_quicklisp

:check_ccl
rem Set the command of Clozure CL according to hardware archtecture.
if "AMD64" == "%PROCESSOR_ARCHITECTURE%" (
      set compiler=wx86cl64.exe
) else (
      set compiler=wx86cl.exe
)

rem Check whether Clozure CL is available.
%compiler% --version 2>nul 1>&2 || (
      echo No Clozure CL on the system >&2
      exit /B 1
)
goto download_quicklisp

:download_quicklisp
if exist .\quicklisp.lisp goto compile

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

rem Download QuickLisp
%pscmd% -Command "Invoke-WebRequest -Uri https://beta.quicklisp.org/quicklisp.lisp -OutFile quicklisp.lisp"

rem Check whether QuickLisp is available.
if not exist .\quicklisp.lisp (
      echo Failed to download quicklisp.lisp >&2
      exit /B 1
)

:compile
if %SBCL% == "%lisp%" goto compile_with_sbcl
if %CCL% == "%lisp%" goto compile_with_ccl

rem Fallback to SBCL
goto compile_with_sbcl

:compile_with_sbcl
sbcl --load quicklisp.lisp ^
     --eval "(quicklisp-quickstart:install :path \"quicklisp\")" ^
     --eval "(ql:quickload \"parenscript\")" ^
     --load cl2js.lisp ^
     --eval "(compile-program \"cl2js.exe\" #'main)"

cd %cwd%
exit /B 0

:compile_with_ccl
%compiler% --load quicklisp.lisp ^
           --eval "(quicklisp-quickstart:install :path \"quicklisp\")" ^
           --eval "(ql:quickload \"parenscript\")" ^
           --load cl2js.lisp ^
           --eval "(compile-program \"cl2js.exe\" #'main)"

cd %cwd%
exit /B 0