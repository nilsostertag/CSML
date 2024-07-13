import numpy as np
import pandas as pd
import utils.comms as cm

def get_from_influx(url: str = 'pi4projects.local', port: str = '1880', request: str = None, only_return_payload: bool = True):
    response, payload = cm.request(url, port, request)
    if only_return_payload == False:
        return response, payload
    return payload

def normalize_column(column, ref):
    pass

if __name__ == '__main__':
    dataset = get_from_influx(request = 'raw_data', only_return_payload = True)
