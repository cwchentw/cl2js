@echo off

set cwd=%CD%

set script_path=%~dp0
set rootdir=%script_path%..\

cd %rootdir%

del /S /Q cl2js.exe quicklisp.lisp
rmdir /S /Q quicklisp

cd %cwd%