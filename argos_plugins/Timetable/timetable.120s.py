#!/usr/bin/env python3

import requests
import os
import json
from pathlib import Path

root_path = Path(os.path.dirname(__file__))
config_path =  root_path / 'timetable.config.json'
switch_countdown_path =  root_path / 'timetable.switch_countdown.py'

with config_path.open() as config_file:
    config = json.load(config_file)

    station_id = config.get('station_id', 0)
    show_countdown = config.get('show_countdown', False)

params = {
    'table[departure][distance]':               '5',
    'table[departure][linesFilter]':            '',	
    'table[departure][marquee]':	            '1',
    'table[departure][optimizedForStation]':    '0',
    'table[departure][platformVisibility]':	    '1',
    'table[departure][refreshInterval]':	    '60',
    'table[departure][rowCount]':               '6',
    'table[departure][stationId]':              str(station_id),
    'table[departure][transport]':	            '0,1,2,3,4,15,6',
    'table[departure][useAllLines]':	        '1',
    'table[sortBy]':                            '0'
}



response = requests.post('https://haltestellenmonitor.vrr.de/backend/app.php/api/stations/table', data=params)

data = response.json()

#print(data['stationName'])

is_first = True
for departure in data['departureData']:
    name = departure['name']
    direction = departure['direction']
    hh = departure['hour']
    mm = departure['minute']
    
    countdown = departure['countdown'] 
    time = f'{countdown} min' if show_countdown and countdown else f'{hh}:{mm}'
       
    delay = departure['delay'] or 0
    if is_first:
        print(f"{name} - {direction} - <b>{countdown} min</b>" )     
        print('---')   
    print(f"<b>{time}</b> \t {name} \t {direction}" )
    is_first = False

show_countdown_label = 'Show time' if show_countdown else 'Show countdown'
print(f'{show_countdown_label} | bash="python3 {switch_countdown_path}" terminal=false')


print('---')
print("Timetable | href=http://efa.vrr.de/vrrstd/XSLT_TRIP_REQUEST2?language=de&itdLPxx_transpCompany=vrr")
print('Google Maps | href=https://www.google.de/maps/@51.5133973,7.4917136,15.25z')
