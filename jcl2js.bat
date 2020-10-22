@echo off

rem Check whether Java is available.
java -version >nul 2>&1 || (
    echo "No Java on the system"
    exit /B 1
)

if exist .\quicklisp.lisp goto compile

rem Check whether PowerShell is available.
powershell -Help 2>nul 1>&2 || (
      echo No PowerShell on the system >&2
      exit /B 1
)

rem Download QuickLisp
powershell -Command "Invoke-WebRequest -Uri https://beta.quicklisp.org/quicklisp.lisp -OutFile quicklisp.lisp"

rem Check whether QuickLisp is available.
if not exist .\quicklisp.lisp (
      echo Failed to download quicklisp.lisp >&2
      exit /B 1
)

rem Download cl-yautils
%pscmd% -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/cwchentw/cl-yautils/master/cl-yautils.lisp -OutFile cl-yautils.lisp"

rem Check whether cl-yautils is available.
if not exist .\cl-yautils.lisp (
    echo Failed to download cl-yautils.lisp >&2
    exit /B 1
)

:compile
rem Get the root path of current batch script.
set root=%~dp0

if not exist "%root%quicklisp" goto install_parenscript

goto run_parenscript

:install_parenscript
set dest=%root%quicklisp

java -jar "%root%\abcl.jar" ^
     --eval "(require :abcl-contrib)" ^
     --load %root%quicklisp.lisp ^
     --eval "(quicklisp-quickstart:install :path ""%dest:\=/%"")" ^
     --eval "(ql:quickload \"parenscript\")" ^
     --eval "(quit)"
echo Restart %0
exit /B 0

:run_parenscript
java -jar "%root%/abcl.jar" ^
     --noinform ^
     --eval "(require :abcl-contrib)" ^
     --load "%root%quicklisp\setup.lisp" ^
     --load "%root%cl2js.lisp" -- %*
exit /B 0