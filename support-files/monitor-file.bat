@REM Open a new window and monitor a file using tail.exe
@ECHO OFF

REM Usage: monitor-file.bat <window title> <file to monitor>

REM Set the following variables before invoke this script (run setenv.bat):
REM TEST_DIR Directory where this test is located

IF [%TEST_DIR%] == [] GOTO :ERROR_NO_VAR_SET

SET TAIL_WINDOW_TITLE=%1
SET TAIL_FILE=%2
IF [%TAIL_WINDOW_TITLE%] == [] GOTO :ERROR_TAIL_ARG
IF [%TAIL_FILE%] == [] GOTO :ERROR_TAIL_ARG

REM Testing tail.exe
%TEST_DIR%\support-files\tail.exe --version 1> nul
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_TAIL_NOT_AVAILABLE 

REM Checking if file to monitor is valid
IF NOT EXIST %TAIL_FILE% GOTO :ERROR_TAIL_FILE_NOT_FOUND

REM Checking if already monitoring with the same window title
ECHO TASKLIST /v /fi "IMAGENAME eq tail.exe" | FINDSTR /c:%TAIL_WINDOW_TITLE% 2> nul
TASKLIST /v /fi "IMAGENAME eq tail.exe" | FINDSTR /c:%TAIL_WINDOW_TITLE% 2> nul
IF %ERRORLEVEL% EQU 0 GOTO :WARNING_ALREADY_MONITORING 

REM Opening file with tail.exe
START %TAIL_WINDOW_TITLE% %TEST_DIR%\support-files\tail.exe -f %TAIL_FILE%

GOTO :EOF

:ERROR_TAIL_ARG
ECHO "Usage: monitor-file.bat <window title> <file to monitor>"
EXIT /B 1

:ERROR_NO_VAR_SET
ECHO Environment variables are not set. Please run setenv.bat to set environment variables.
EXIT /B 2

:ERROR_TAIL_NOT_AVAILABLE
ECHO tail.exe not available in the system.
EXIT /B 3

:ERROR_TAIL_FILE_NOT_FOUND
ECHO ERROR: Unable to monitor %TAIL_FILE%. File not found.
EXIT /B 4

:WARNING_ALREADY_MONITORING
ECHO WARNING: File %TAIL_FILE% already open in window %TAIL_WINDOW_TITLE%
GOTO :EOF

:EOF
