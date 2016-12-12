@REM MySQL run SQL file and measure time for benchmarking
@ECHO OFF

REM Usage mysql-run-benchmark.bat <sql file>

REM Set the following variables before invoke this script (run setenv.bat):
REM MYSQL_HOME MySQL basedir
REM MYSQL_DEFAULTS_FILE my.ini to be used by mysqld.exe and mysql.exe
REM MYSQL_PORT Port where mysqld will listen

SET SQL_FILE=%1
IF [%SQL_FILE%] == [] GOTO :ERROR_NO_ARG

IF [%MYSQL_HOME%] == [] GOTO :ERROR_NO_VAR_SET
IF [%MYSQL_DEFAULTS_FILE%] == [] GOTO :ERROR_NO_VAR_SET
IF [%MYSQL_PORT%] == [] GOTO :ERROR_NO_VAR_SET

IF %TEST_DEBUG% EQU 1 ECHO INFO: Benchmarking %SQL_FILE%...
IF NOT EXIST %SQL_FILE% GOTO :ERROR_MYSQL_SQL_NOT_FOUND
REM CALL %TEST_DIR%\support-files\mysql-run-statement.bat "SET @t1:=SYSDATE(6); SOURCE %SQL_FILE%; SET @t2:=SYSDATE(6); TEE %TEST_OUTPUT_FILE%; SELECT TIMEDIFF(@t2,@t1) AS 'time exec'; NOTEE;"
%MYSQL_HOME%\bin\mysql.exe --defaults-file=%MYSQL_DEFAULTS_FILE% --port=%MYSQL_PORT% --protocol=tcp -u%MYSQL_USER% -e"SET @t1:=SYSDATE(6); SOURCE %SQL_FILE:\=/%; SET @t2:=SYSDATE(6); TEE %TEST_OUTPUT_FILE:\=/%; SELECT TIMEDIFF(@t2,@t1) AS 'time exec'; NOTEE;" -B -N
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_MYSQL_SQL_RUN
IF %TEST_DEBUG% EQU 1 ECHO INFO: Benchmark done!
GOTO :EOF

:ERROR_NO_VAR_SET
ECHO Environment variables are not set. Please run setenv.bat to set environment variables.
EXIT /B 1

:ERROR_NO_ARG
ECHO No SQL file specified. Please provide a valid SQL file as argument.
ECHO "Usage mysql-run-benchmark.bat <sql file>"
EXIT /B 2

:ERROR_MYSQL_SQL_NOT_FOUND
ECHO Can't find file %SQL_FILE%
EXIT /B 3

:ERROR_MYSQL_SQL_RUN
ECHO Error while executing %SQL_FILE%
EXIT /B 4

:EOF
