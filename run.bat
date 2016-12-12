REM MySQL Windows Test - Run
@ECHO OFF

REM ===================
REM MySQL 5.6 Run tests
REM ===================
CALL setenv-mysql56.bat
ECHO Running tests in MySQL 5.6...
ECHO Starting tests in MySQL 5.6 at %TIME% >> %TEST_OUTPUT_FILE%
CALL %TEST_DIR%\support-files\monitor-file.bat "MySQL Windows Test Results" %TEST_OUTPUT_FILE%
ECHO Starting MySQL 5.6...
CALL %TEST_DIR%\support-files\mysql56-start.bat
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_56
CALL %TEST_DIR%\support-files\sysstatus.bat >> %TEST_OUTPUT_FILE%
CALL %TEST_DIR%\support-files\mysql-run-statement.bat "SELECT @@hostname, @@version, NOW();" >> %TEST_OUTPUT_FILE%
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_56
ECHO Running queries in MySQL 5.6...
FOR /L %%x IN (1, 1, %TEST_ITERATIONS%) DO CALL %TEST_DIR%\support-files\mysql-run-benchmark.bat %TEST_DIR%\query.sql 1> nul
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_56
CALL %TEST_DIR%\support-files\mysql-stop.bat
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_56
ECHO Finished tests in MySQL 5.6 at %TIME% >> %TEST_OUTPUT_FILE%

REM ===================
REM MySQL 5.7 Run tests
REM ===================
CALL setenv-mysql57.bat
ECHO Running tests in MySQL 5.7...
ECHO Starting tests in MySQL 5.7 at %TIME% >> %TEST_OUTPUT_FILE%
CALL %TEST_DIR%\support-files\monitor-file.bat "MySQL Windows Test Results" %TEST_OUTPUT_FILE%
ECHO Starting MySQL 5.7...
CALL %TEST_DIR%\support-files\mysql57-start.bat
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_57
CALL %TEST_DIR%\support-files\sysstatus.bat >> %TEST_OUTPUT_FILE%
CALL %TEST_DIR%\support-files\mysql-run-statement.bat "SELECT  @@hostname, @@version, NOW();" >> %TEST_OUTPUT_FILE%
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_57
ECHO Running queries in MySQL 5.7...
FOR /L %%x IN (1, 1, %TEST_ITERATIONS%) DO CALL %TEST_DIR%\support-files\mysql-run-benchmark.bat %TEST_DIR%\query.sql 1> nul
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_57
CALL %TEST_DIR%\support-files\mysql-stop.bat
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_57
ECHO Finished tests in MySQL 5.7 at %TIME% >> %TEST_OUTPUT_FILE%

GOTO :EOF


:ERROR_56
ECHO Failed to run tests in MySQL 5.6!
EXIT /B 1

:ERROR_57
ECHO Failed to run tests in MySQL 5.7!
EXIT /B 2

:EOF
