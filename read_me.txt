Read me for V 2.8 dcs_weather from shadowze - 2023/DEC/31 09:50
- Added new as a commandline parameter , will use same month but pick an evening with a full moon
- Added ability to use the cloud presets that DCS 2.7+ now has


NOTE: Please do NOT distribute this, I will keep this on github
URL: 


If you use this on your server I ask that at the bottom of your mission
briefing you are hosting please give havoc-company.com credit for helping put
realtime weather in your mission - thanks


Ok so you want realtime weather and or time on your DCS World server ?

there are some thing you need to do to get that working
Please read through this first before rushing off and trying anything

Overview - How this works
Edit the batch file to point to where your mission file is.
You run the batch file (as admin), it will go to the web grab real time weather
for the airport you have selected (uses 2 servers incase 1st has a problem),
it then opens the DCS World mission file and writes this info into the mission file
and if selected change the time to the current time of the host PC, it then uses
7Z to re-add this modifed mission file back into the .miz file
it launches DCS World 


Things you need to do

1. Install python 3 on the hosting pc (tested with 3.8 32bit ok) 
   - make sure you tick the add python to path option when installing
   - After installing python open a dos window as admin and install requests using
   pip install requests

2. Install 7z (I used 64 bit)

3. Get an API key to grab real time weather from the internet from www.checkwx.com and avwx.rest
   - register an account and then login and go to www.checkwx.com/apikey and  avwx.rest 
   - fill in the details (remember to say non commercial use)
   - might take up to 24 hours for him to activate it for you but you can check by going to 
   - https://www.checkwx.com/user/api     once you have it copy paste it somewhere safe
   - dont give your key out to anyone else you only get a certain amount of free reads per month
   - Our server restarts 4 times per day every 6 hours, so we said we would only use about 200 per month
   - when filling in the form

4. put the accompying 2 files into a folder on the host PC

5. Open the batch file in any editor and change the paths and names to match your needs
    DCS_PATH  ,  PRIMARY_AIRPORT , BACKUP_AIRPORT , zip ,  MISSION_PATH  , MISSION_NAME 
    PYTHON_SCRIPT
    - all these will need to be changed to match YOUR installation / configuration
	- ICAO string for airports is what you use eg KLAS 

6. Open the dcs_weather.py script in an editor (notepad++) scroll down to the below line
   s_api_key_checkwx = 'NOT_SET_YET' 
   - change the NOT_YET_SET to what API key you got from checkwx earlier, save the file
   s_api_key_avwx = 'NOT_SET_YET'
   - change the NOT_YET_SET to what API key you got from avwx.rest earlier, save the file


You are ready to go run that batch file as admin and it should change your mission and start DCS World
I have left some debug output stuff on so when it runs you should see what values it has before
and after it adjusts things


	  
	  
	  

Notes about dcs_weather.py when passing parameters in (more info in the top of the script itself)

   dcs_weather.py D:\DCS_Missions\Weapons_Training_v2.11.2.miz UGSB UGSS real
   ^ use real time for the mission (time derived from PC clock)

   dcs_weather.py D:\DCS_Missions\Weapons_Training_v2.11.2.miz UGSB UGSS 
   ^ use 2 airports and do not change time in mission

   dcs_weather.py D:\DCS_Missions\Weapons_Training_v2.11.2.miz KLAS UGSS 6
   ^ use 2 airports and use time/date preset 6 (autumn evening)

   dcs_weather.py D:\DCS_Missions\Weapons_Training_v2.11.2.miz KLAS rand
   ^ use 2 airports and pick a random date/time for the mission

   dcs_weather.py D:\DCS_Missions\Weapons_Training_v2.11.2.miz KLAS UGSS new
   ^ use 2 airports and use the current month BUT pick the night with a FULL MOON

https://www.world-airport-codes.com/ get ICAO code for airport you want to use
https://www.world-airport-codes.com/alphabetical/country-name/g.html#georgia   
   
   
Preset table if you want not to use real time = ? is which number to pass to script
first 4 are early morning, other 4 are evenings

YYYY , MM , DD , hh , mm

['2017', '03', '06', '7', '30'] = 0
['2017', '06', '06', '5', '50'] = 1
['2017', '09', '06', '7', '45'] = 2
['2017', '12', '06', '8', '30'] = 3
['2017', '03', '06', '16', '0'] = 4
['2017', '06', '06', '17', '0'] = 5
['2017', '09', '06', '16', '0'] = 6
['2017', '12', '06', '15', '0'] = 7

For people who like evening and then a bit of night flying the following presets we added, these days have a FULL MOON

# presets for 2021 onwards use new parameter, these dates are when the moon is full, server at index zero will be Jan 25th @ 13:00hrs start
    # this gives 4.5 hours of daylight before going dark for an hour before server restart
    l_dates_new = [['25', '13'], ['24', '14'], ['25', '14'], ['24', '15'], ['23', '15'], ['22', '16'],
                   ['21', '16'], ['19', '15'], ['18', '15'], ['17', '14'], ['16', '14'], ['15', '13']]


PROBLEMS / BUGS:
Contact HC_Official on ED forums
If you find any bugs  please let us know

Best Regards

      Shadowze


