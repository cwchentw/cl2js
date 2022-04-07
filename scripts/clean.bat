@echo off

set cwd=%CD%

set script_path=%~dp0
set rootdir=%script_path%..\

cd %rootdir%

del /S /Q cl2js.exe cl2js.zip quicklisp.lisp cl-portable.lisp cl-yautils.lisp
rmdir /S /Q cl2js
rmdir /S /Q quicklisp

cd %cwd%