#!/usr/bin/env python3

import requests
import os
import json
from pathlib import Path

root_path = Path(os.path.dirname(__file__))
config_path =  root_path / 'timetable.config.json'

with config_path.open() as config_file:
    config = json.load(config_file)

    station_id = config.get('station_id', 0)
    show_countdown = config.get('show_countdown', False)

config['show_countdown'] = not show_countdown

with config_path.open('w') as config_file:
    config = json.dump(config, config_file)
