@REM MySQL shutdown
@ECHO OFF

REM Set the following variables before invoke this script (run setenv.bat):
REM TEST_DIR Directory where this test is located
REM MYSQL_HOME MySQL basedir
REM MYSQL_DEFAULTS_FILE my.ini to be used by mysqld.exe and mysql.exe
REM MYSQL_PORT Port where mysqld will listen
REM MYSQL_USER MySQL user to be used by mysqladmin

IF [%TEST_DIR%] == [] GOTO :ERROR_NO_VAR_SET
IF [%MYSQL_HOME%] == [] GOTO :ERROR_NO_VAR_SET
IF [%MYSQL_DEFAULTS_FILE%] == [] GOTO :ERROR_NO_VAR_SET
IF [%MYSQL_PORT%] == [] GOTO :ERROR_NO_VAR_SET
IF [%MYSQL_USER%] == [] GOTO :ERROR_NO_VAR_SET

ECHO Shuting down MySQL...
%MYSQL_HOME%\bin\mysqladmin.exe --defaults-file=%MYSQL_DEFAULTS_FILE% --port=%MYSQL_PORT% --protocol=tcp -u%MYSQL_USER% shutdown
CALL %TEST_DIR%\support-files\mysql-isdown.bat 5 5
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_MYSQL_STILL_RUNNING
ECHO MySQL stopped.
GOTO :EOF

:ERROR_NO_VAR_SET
ECHO Environment variables are not set. Please run setenv.bat to set environment variables.
EXIT /B 1

:ERROR_MYSQL_STILL_RUNNING
ECHO Could not stop MySQL.
EXIT /B 2

:EOF
