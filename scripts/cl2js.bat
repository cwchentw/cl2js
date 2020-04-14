@echo off

rem Constant
set SBCL="sbcl"
set CCL="ccl"
set ABCL="abcl"

rem Get the root path of current batch script.
set rootdir=%~dp0

rem Set specific Common Lisp implementation.
set lisp=%1

if %SBCL% == "%lisp%" shift && goto runlisp
if %CCL% == "%lisp%" shift && goto runlisp
if %ABCL% == "%lisp%" shift && goto runlisp

rem Fallback to SBCL if %lisp% is not set.
set lisp=%SBCL:"=%

:runlisp
rem Collect remaining argument(s).
set args=
:collect_args
set arg=%1
if "" neq "%arg%" (
    set args=%args% %arg%
    shift
    goto collect_args
)

rem Run cl2js.lisp with SBCL.
if %SBCL% == "%lisp%" (
    rem Fix sbclrun later.
    sbcl --noinform --load %rootdir%cl2js.lisp %args%
    rem exit /B 0
)

rem Run cl2js.lisp with Clozure CL.
if %CCL% == "%lisp%" (
    cclrun %rootdir%cl2js.lisp -- %args%
    rem exit /B 0
)

rem Run cl2js.lisp with Armed Bear CL.
if %ABCL% == "%lisp%" (
    abclrun %rootdir%cl2js.lisp -- %args%
    rem exit /B 0
)