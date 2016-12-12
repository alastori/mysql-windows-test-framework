@REM MySQL Windows Test - Prepare
@ECHO OFF

REM =============================
REM MySQL 5.6 Sandbox preparation
REM =============================
:PREPARE_56
CALL setenv-mysql56.bat
ECHO Initializing MySQL 5.6...
CALL %TEST_DIR%\support-files\mysql56-initialize.bat
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_56
ECHO Starting MySQL 5.6...
CALL %TEST_DIR%\support-files\mysql56-start.bat
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_56
ECHO Loading test data in MySQL 5.6...
CALL %TEST_DIR%\support-files\mysql-run-sql.bat %TEST_DIR%\create-user.sql
CALL %TEST_DIR%\support-files\mysql-run-sql.bat %TEST_DIR%\dump.sql
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_56
ECHO Stopping MySQL 5.6...
CALL %TEST_DIR%\support-files\mysql-stop.bat
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_56
ECHO MySQL 5.6 prepared!


REM =============================
REM MySQL 5.7 Sandbox preparation
REM =============================
:PREPARE_57
CALL setenv-mysql57.bat
ECHO Initializing MySQL 5.7...
CALL %TEST_DIR%\support-files\mysql57-initialize.bat
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_57
ECHO Starting MySQL 5.7...
CALL %TEST_DIR%\support-files\mysql57-start.bat
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_57
ECHO Loading test data in MySQL 5.7...
CALL %TEST_DIR%\support-files\mysql-run-sql.bat %TEST_DIR%\create-user.sql
CALL %TEST_DIR%\support-files\mysql-run-sql.bat %TEST_DIR%\dump.sql
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_57
ECHO Stopping MySQL 5.7...
CALL %TEST_DIR%\support-files\mysql-stop.bat
IF %ERRORLEVEL% NEQ 0 GOTO :ERROR_57
ECHO MySQL 5.7 prepared!

GOTO :EOF

:ERROR_56
ECHO Failed to prepare MySQL 5.6!
EXIT /B 1

:ERROR_57
ECHO Failed to prepare MySQL 5.7!
EXIT /B 2

:EOF
