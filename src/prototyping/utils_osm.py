import urllib.request
import json

class location_services:
    def __init__(self):
        self.api = None

    def get_speed_limit_OSM_API(self, position: dict) -> int:
        lat, long = position['lat'], position['long']
        api_call = f'https://nominatim.openstreetmap.org/reverse?lat={lat}&lon={long}&format=json'
        contents = urllib.request.urlopen(api_call).read()
        api_response = json.loads(contents)
        
        osm_id = api_response['osm_id']
        api_call = f'https://overpass-api.de/api/interpreter?data=[out:json];way({osm_id});out;'
        print(api_call)
        contents = urllib.request.urlopen(api_call).read()
        api_response = json.loads(contents)
        try:
            return int(api_response['elements'][0]['tags']['maxspeed'])
        except:
            return -1
        