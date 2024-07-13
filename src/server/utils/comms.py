# Script for REST-Based communication between Python and NodeRED backend
import json
import urllib.request
import pandas as pd

def request(url: str = 'pi4projects.local', port: str = '1880', request: str = None):
    buffer_url = f'{url}:{port}/{request}'
    response = request(buffer_url)
    df = pd.read_json(response)
    return response, df

def push_data(url: str = 'pi4projects.local', port: str = '1880', request: str = None, payload = None):
    arg = json.dumps(payload)
    buffer_url = f'{url}:{port}/{request}&arg={arg}'
    response = request(buffer_url)
    pass