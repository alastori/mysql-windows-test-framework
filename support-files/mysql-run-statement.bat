@REM MySQL run statement
@ECHO OFF

REM Usage mysql-run-statement.bat <MySQL statement> (Tip: use quotes)

REM Set the following variables before invoke this script (run setenv.bat):
REM MYSQL_HOME MySQL basedir
REM MYSQL_DEFAULTS_FILE my.ini to be used by mysqld.exe and mysql.exe
REM MYSQL_PORT Port where mysqld will listen

SET SQL_STATEMENT=%1
IF [%SQL_STATEMENT%] == [] GOTO :ERROR_NO_ARG

IF [%MYSQL_HOME%] == [] GOTO :ERROR_NO_VAR_SET
IF [%MYSQL_DEFAULTS_FILE%] == [] GOTO :ERROR_NO_VAR_SET
IF [%MYSQL_PORT%] == [] GOTO :ERROR_NO_VAR_SET

IF %TEST_DEBUG% EQU 1 ECHO INFO: Executing statement %SQL_STATEMENT%...
%MYSQL_HOME%\bin\mysql.exe --defaults-file=%MYSQL_DEFAULTS_FILE% --port=%MYSQL_PORT% --protocol=tcp -u%MYSQL_USER% -e%SQL_STATEMENT%
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_MYSQL_STATEMENT_RUN
IF %TEST_DEBUG% EQU 1 ECHO INFO: MySQL statement executed without errors.
GOTO :EOF

:ERROR_NO_VAR_SET
ECHO Environment variables are not set. Please run setenv.bat to set environment variables.
EXIT /B 1

:ERROR_NO_ARG
ECHO No SQL statement specified. Please provide a valid MySQL command as argument.
ECHO "Usage mysql-run-statement.bat <MySQL statement> (Tip: use quotes)"
EXIT /B 2

:ERROR_MYSQL_STATEMENT_RUN
ECHO Error while executing %SQL_STATEMENT%
EXIT /B 3

:EOF
