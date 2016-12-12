@REM Show Windows system status
@ECHO OFF

@FOR /f "skip=1" %%c IN ('wmic cpu get loadpercentage ^| FINDSTR /r /v "^$"') DO @ECHO CPU=%%c%%
@FOR /f "skip=1" %%p IN ('wmic os get freephysicalmemory ^| FINDSTR /r /v "^$"') DO @ECHO Physical Memory=%%p
@FOR /f "skip=1" %%v IN ('wmic os get freephysicalmemory ^| FINDSTR /r /v "^$"') DO @ECHO Virtual Memory=%%v
