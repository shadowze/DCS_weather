: example launch file for DCS used with dcs_weather.py
: by shadowze
: you need python 3 (and requests module for python - pip install requests in dos to install) 
: and 7z installed on server hosting PC
: you will need to edit this file to change parameters to match your install
: contact HC_Official in ED forums for any queries
: 2022/12/11 V 2.8
: try NOT to use paths with spaces in them, it is a PITA


: edit this to point to you dcs dedicated server exe folder
SET DCS_PATH="D:\games\DCS_dedi_beta\bin\"

: edit below this to point to where your python exe is
SET PYTHON_EXE="C:\web\python\python3\python.exe"


: settings for dcs_weather.py - airports weather to query
SET PRIMARY_AIRPORT=EGAC 
SET BACKUP_AIRPORT=EGAA

: you want to use current realtime on server ?
SET TIME_CONTROL=real

: New way of handling later in the day stuff to give us nice evening then into darkness
SET FALL_BACK=new

: set this to where your 7z.exe is installed
SET zip="C:\Program Files (x86)\7-Zip\7z.exe"
SET zip="C:\Program Files\7-Zip\7z.exe"

: where you store your mission miz files
SET MISSION_PATH=D:\games\DCS_Missions\

: mission name minus the file extension
SET MISSION_NAME=Weapons_Freeflight.v1.02.56

SET MISSION="%MISSION_PATH%%MISSION_NAME%.miz"

: path and name of weather python script
SET PYTHON_SCRIPT="D:\games\dcs_weather.py"


SET TEST=%time:~0,1%
SET HOUR=%time:~0,2%
IF  "%TEST%" == " "  SET HOUR=%time:~1,1%

SET NO_NIGHT=YES


REM @echo  #####  ####### #     # #######   ###    #####
REM @echo #     # #     # ##    # #          #    #     #
REM @echo #       #     # # #   # #          #    #
REM @echo #       #     # #  #  # #####      #    #  ####
REM @echo #       #     # #   # # #          #    #     #
REM @echo #     # #     # #    ## #          #    #     #
REM @echo  #####  ####### #     # #         ###    #####

: This section here will stop your DCS world dedicated server
tasklist /fi "ImageName eq DCS.exe" /fo csv 2>NUL | find /I "DCS.exe">NUL
if "%ERRORLEVEL%" NEQ "0" GOTO :SKIP

: Ask nicely first
taskkill /IM DCS.exe
TIMEOUT /T 6

: then club it over back of head to be sure
taskkill /F /IM dcs.exe > nul 2>&1
TIMEOUT /T 8





:SKIP


: this was added so that if it is too late (dark a lot) then people would get some time were it is light for a bit
IF %NO_NIGHT% == NO GOTO :INJECT_WEATHER

IF %HOUR% GEQ 17 SET TIME_CONTROL=%FALL_BACK%
IF %HOUR% LSS 6 SET TIME_CONTROL=%FALL_BACK%

@echo %TIME_CONTROL%



:INJECT_WEATHER
cd /D %MISSION_PATH%

%zip% e -y %MISSION_NAME%.miz mission 
%zip% e -y %MISSION_NAME%.miz theatre 

%PYTHON_EXE% %PYTHON_SCRIPT% %MISSION% %PRIMARY_AIRPORT% %BACKUP_AIRPORT% %TIME_CONTROL%
@echo.
@echo Using METAR from %PRIMARY_AIRPORT% %BACKUP_AIRPORT%
@echo.
TIMEOUT /T 5

: rename .miz to .zip because 7z don't like miz file extension
ren %MISSION_NAME%.miz %MISSION_NAME%.zip

: add the updated mission to the zip file
%zip% a -tzip %MISSION_NAME%.zip mission -mx9 

: rename it back to miz
ren %MISSION_NAME%.zip %MISSION_NAME%.miz 



:START_DCS
cd /D %DCS_PATH%
: remember you can add extra parameters to the line below for different saved_games sub folders to use eg -w DCS.openbeta_pg
start /D%DCS_PATH% /B /ABOVENORMAL dcs.exe --norender --server 

: full line example uses folder DCS.openbeta_pg for all server stuff
: start /D%DCS_PATH% /B /ABOVENORMAL dcs.exe --norender --server -w DCS.openbeta_pg

timeout /T 10