@REM Check if MySQL isn't running
@ECHO OFF

REM Usage: mysql-isdown.bat <nr retires if up> <wait>

REM Set the following variables before invoke this script (run setenv.bat):
REM MYSQL_HOME MySQL basedir
REM MYSQL_DEFAULTS_FILE my.ini to be used by mysqld.exe and mysql.exe
REM MYSQL_PORT Port where mysqld will listen
REM MYSQL_USER MySQL user to be used by mysqladmin

IF [%MYSQL_HOME%] == [] GOTO :ERROR_NO_VAR_SET
IF [%MYSQL_DEFAULTS_FILE%] == [] GOTO :ERROR_NO_VAR_SET
IF [%MYSQL_PORT%] == [] GOTO :ERROR_NO_VAR_SET
IF [%MYSQL_USER%] == [] GOTO :ERROR_NO_VAR_SET

SET MYSQL_CHECK_STOP_RETRIES=%1
SET MYSQL_CHECK_STOP_WAIT=%2
IF [%MYSQL_CHECK_STOP_RETRIES%] == [] SET MYSQL_CHECK_STOP_RETRIES=0
IF [%MYSQL_CHECK_STOP_WAIT%] == [] SET MYSQL_CHECK_STOP_WAIT=0

:TRY_MYSQL_DOWN
%MYSQL_HOME%\bin\mysqladmin.exe --defaults-file=%MYSQL_DEFAULTS_FILE% --port=%MYSQL_PORT% --protocol=tcp -u%MYSQL_USER% version 2> nul
IF %ERRORLEVEL% EQU 0 GOTO :MYSQL_RETRY
IF %TEST_DEBUG% EQU 1 ECHO NOTE: MySQL is NOT accessible through port %MYSQL_PORT% for user %MYSQL_USER%
EXIT /B 0

:MYSQL_RETRY
IF %MYSQL_CHECK_STOP_RETRIES% EQU 0 GOTO :ERROR_MYSQL_STILL_ACESSIBLE
IF %MYSQL_CHECK_STOP_WAIT% GTR 0 TIMEOUT %MYSQL_CHECK_STOP_WAIT%
SET /A MYSQL_CHECK_STOP_RETRIES=MYSQL_CHECK_STOP_RETRIES-1
GOTO :TRY_MYSQL_DOWN

:ERROR_NO_VAR_SET
ECHO Environment variables are not set. Please run setenv.bat to set environment variables.
EXIT /B 1

:ERROR_MYSQL_STILL_ACESSIBLE
ECHO MySQL is STILL accessible through port %MYSQL_PORT% for user %MYSQL_USER%
EXIT /B 100

:EOF
