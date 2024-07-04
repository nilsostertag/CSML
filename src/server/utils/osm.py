#import
import urllib.request
import json

EXAMPLE_CALL = 'https://nominatim.openstreetmap.org/reverse?lat=48.636472&lon=10.166313&format=json&maxspeed=*'

class location_services:
    def __init__(self):
        self.api = None

    def get_speedlimit(self, position: tuple) -> int:
        lat, long = position
        contents = urllib.request.urlopen(EXAMPLE_CALL).read()
        json_contents = json.loads(contents)
        print(json_contents['address']['city_district'])


if __name__ == '__main__':
    ls = location_services()
    ls.get_speedlimit(position=(1,2))