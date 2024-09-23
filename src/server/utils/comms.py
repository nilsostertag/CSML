# Script for REST-Based communication between Python and NodeRED backend
import json
import pandas as pd
import requests

def get_data(uuid: str, drive_id: str) -> pd.DataFrame:
    ip = 'device_ip'
    data_string = requests.get(f'http://{ip}:1880/get?uuid={uuid}&drive_id={drive_id}').content.decode('utf-8')
    data_json = pd.json_normalize(data_string)
    return data_json