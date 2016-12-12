@REM MySQL Windows Test - Cleanup
@ECHO OFF

REM =========================
REM MySQL 5.6 Sandbox cleanup
REM =========================
CALL setenv-mysql56.bat
CALL %TEST_DIR%\support-files\mysql-rm-datadir.bat %MYSQL_DATADIR%

REM =========================
REM MySQL 5.7 Sandbox cleanup
REM =========================
CALL setenv-mysql57.bat
CALL %TEST_DIR%\support-files\mysql-rm-datadir.bat %MYSQL_DATADIR%
