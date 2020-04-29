@echo off
rem Wrapper for cl2js on Windows
rem Copyright (c) 2020 Michael Chen
rem Licensed under MIT


set script_dir=%~dp0
set root_dir=%script_dir%..

"%root_dir%\libexec\cl2js.exe" -- %*