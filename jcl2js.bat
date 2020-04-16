@echo off

rem Check whether Java is available.
java -version >nul 2>&1 || (
    echo "No Java on the system"
    exit /B 1
)

rem Get the root path of current batch script.
set root=%~dp0

if not exist "%rootdir%quicklisp\" goto install_parenscript

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
     --load "%root%cl2js.lisp" %*
exit /B 0