@echo off

rem Constant
set SBCL="sbcl"
set CCL="ccl"

set lisp=%1

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
exit /B 0

:compile_with_ccl
rem Set CCL according to hardware archtecture.
if "AMD64" == "%PROCESSOR_ARCHITECTURE%" (set ccl=wx86cl64.exe) else (set ccl=wx86cl.exe)

%ccl% --load quicklisp.lisp ^
      --eval "(quicklisp-quickstart:install :path \"quicklisp\")" ^
      --eval "(ql:quickload \"parenscript\")" ^
      --load cl2js.lisp ^
      --eval "(compile-program \"cl2js.exe\" #'main)"
exit /B 0