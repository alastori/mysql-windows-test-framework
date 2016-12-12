@REM MySQL datadir Cleanup
@ECHO OFF

REM Provide the datadir as argument

IF [%1] == [] GOTO :ERROR_NO_ARG
IF NOT EXIST %1 GOTO :ERROR_NO_DATADIR

DEL /S /F /Q %1
FOR /f %%f IN ('DIR /ad /b %1') DO RD /s /q %1\%%f
RD %1
TIMEOUT 3
IF EXIST %1 GOTO :ERROR_NO_SUCCESS
ECHO %1 cleaned up!
GOTO :EOF

:ERROR_NO_ARG
ECHO Please provide a valid MySQL datadir as argument.
EXIT /B 1

:ERROR_NO_DATADIR
ECHO Datadir %1 not found. Nothing to do.
EXIT /B 2

:ERROR_NO_SUCCESS
ECHO Could not remove %1. Is any file in use by another proccess?
EXIT /B 3

:EOF