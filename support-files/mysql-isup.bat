@REM Check if MySQL is running
@ECHO OFF

REM Usage: mysql-isup.bat <nr retires if down> <wait>

REM Set the following variables before invoke this script (run setenv.bat):
REM MYSQL_HOME MySQL basedir
REM MYSQL_DEFAULTS_FILE my.ini to be used by mysqld.exe and mysql.exe
REM MYSQL_PORT Port where mysqld will listen
REM MYSQL_USER MySQL user to be used by mysqladmin

IF [%MYSQL_HOME%] == [] GOTO :ERROR_NO_VAR_SET
IF [%MYSQL_DEFAULTS_FILE%] == [] GOTO :ERROR_NO_VAR_SET
IF [%MYSQL_PORT%] == [] GOTO :ERROR_NO_VAR_SET
IF [%MYSQL_USER%] == [] GOTO :ERROR_NO_VAR_SET

SET MYSQL_CHECK_START_RETRIES=%1
SET MYSQL_CHECK_START_WAIT=%2
IF [%MYSQL_CHECK_START_RETRIES%] == [] SET MYSQL_CHECK_START_RETRIES=0
IF [%MYSQL_CHECK_START_WAIT%] == [] SET MYSQL_CHECK_START_WAIT=0

:TRY_MYSQL_UP
%MYSQL_HOME%\bin\mysqladmin.exe --defaults-file=%MYSQL_DEFAULTS_FILE% --port=%MYSQL_PORT% --protocol=tcp -u%MYSQL_USER% version 1> nul
IF %ERRORLEVEL% NEQ 0 GOTO :MYSQL_RETRY
IF %TEST_DEBUG% EQU 1 ECHO NOTE: MySQL is accessible through port %MYSQL_PORT% for user %MYSQL_USER%
GOTO :EOF

:MYSQL_RETRY
IF %MYSQL_CHECK_START_RETRIES% EQU 0 GOTO :ERROR_MYSQL_NOT_ACESSIBLE
IF %MYSQL_CHECK_START_WAIT% GTR 0 TIMEOUT %MYSQL_CHECK_START_WAIT%
SET /A MYSQL_CHECK_START_RETRIES=MYSQL_CHECK_START_RETRIES-1
SET /A MYSQL_TENTATIVE=%1-MYSQL_CHECK_START_RETRIES
ECHO Retrying... Tentative %MYSQL_TENTATIVE%/%1
GOTO :TRY_MYSQL_UP

:ERROR_NO_VAR_SET
ECHO Environment variables are not set. Please run setenv.bat to set environment variables.
EXIT /B 1

:ERROR_MYSQL_NOT_ACESSIBLE
ECHO MySQL is NOT accessible through port %MYSQL_PORT% for user %MYSQL_USER%
ECHO Is mysqld.exe in the TASKLIST?
ECHO TASKLIST /fi "imagename eq mysqld.exe"
TASKLIST /fi "imagename eq mysqld.exe"
EXIT /B 1

:EOF
