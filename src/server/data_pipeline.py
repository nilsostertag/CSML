import requests
import json

import numpy as np
import pandas as pd

from utils import osm

ip = 'device_ip'

def get_data(uuid: str, drive_id: str) -> pd.DataFrame:
    data_string = requests.get(f'http://{ip}:1880/get?uuid={uuid}&drive_id={drive_id}').content.decode('utf-8')
    data_string = json.loads(data_string)
    data_json = pd.json_normalize(data_string)
    return data_json

def rename_columns(dataset):
    dataset = dataset.drop(columns=['result', 'table', '_start', '_stop', '_time', '_field', 'drive_id', 'fuel_consumption_rt', '_measurement'])
    dataset = dataset.rename(columns={'_value': 'datetime', 'longtitude': 'longitude'})
    dataset = dataset[~dataset.apply(lambda row: row.astype(str).str.contains('None')).any(axis=1)]
    return dataset

def convert_values(dataset):
    for index, value in dataset['engine_load'].items():
        #print(value)
        processed_value = int(value, base=16)
        converted_engine_load = (processed_value / 2.55)

        if converted_engine_load is not None:
            dataset.at[index, 'engine_load'] = int(converted_engine_load)
    
    for index, value in dataset['engine_rpm'].items():
        #print(value)
        processed_value_a = int(value[:2], base=16)
        processed_value_b = int(value[2:], base=16)

        converted_engine_rpm = (256*processed_value_a + processed_value_b) / 4

        if converted_engine_rpm is not None:
            dataset.at[index, 'engine_rpm'] = int(converted_engine_rpm)
    
    for index, value in dataset['throttle_pos'].items():
        #print(value)
        processed_value = int(value, base=16)
        converted_throttle_pos = (processed_value / 2.55)

        if converted_throttle_pos is not None:
            dataset.at[index, 'throttle_pos'] = int(converted_throttle_pos)
    
    for index, value in dataset['vehicle_speed'].items():
        processed_value = int(value, base=16)

        if processed_value is not None:
            dataset.at[index, 'vehicle_speed'] = int(processed_value)

    return dataset
    
def sort_by_datetime(dataset):
    dataset['datetime'] = pd.to_datetime(dataset['datetime'])
    dataset = dataset.sort_values(by='datetime', ascending=True)
    return dataset

def add_calculations(dataset):
    new_columns = ['allowed_speed', 'delta_engine_rpm', 'delta_engine_load', 'delta_vehicle_speed', 'delta_throttle_pos']

    # Initialisiere die neuen Spalten mit 0
    for column in new_columns:
        dataset[column] = 0

    new_columns.append('datetime')

    target_columns = [column for column in dataset.columns if column not in new_columns]
    target_columns.append('allowed_speed')
    
    speed_list = [10, 30, 50, 70, 100, 130]

    # Iteriere über das DataFrame
    previous_row = None
    for index, current_row in dataset.iterrows():
        for column in target_columns:
            if column in dataset.columns and column not in ['latitude', 'longitude']:
                # print(column)
                if column == 'allowed_speed':
                    position = {'lat': current_row['latitude'], 'long': current_row['longitude']}
                    speed_limit = osm.location_services.get_speed_limit_OSM_API(osm, position)
                    if speed_limit == -1 and current_row['vehicle_speed'] <= 140:
                        speed_limit = min(speed_list, key=lambda x: abs(x-current_row['vehicle_speed']))
                    elif speed_limit == -1 and current_row['vehicle_speed'] > 140:
                        speed_limit = current_row['vehicle_speed']
                    dataset.at[index, column] = speed_limit
                try:
                    if previous_row is None:
                        dataset.at[index, f'delta_{column}'] = 0
                    else:
                        dataset.at[index, f'delta_{column}'] = int(current_row[column]) - int(previous_row[column])
                except KeyError as e:
                    continue
                except Exception as e:
                    continue

        # Setze die aktuelle Zeile als vorherige Zeile für den nächsten Durchlauf
        previous_row = current_row
    
    return dataset
        