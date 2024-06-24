# Konzeptionierung von Datenverarbeitungsprozessen

## 1. Data Aquisition: OBD II - Rohdaten

| Datenpunkt |Datentyp| Einheit | Mode / PID |Availability|
|-|-|-|-|-|
|timestamp   |string / datetime|datetime   |-|1|
|uuid        |string   |-    |-|1|
|latitude    |float|lat|-|1|
|longtitude  |float|long|-|1|
|travel_distance|float|km|-|?, may be unnecessary|
|throttle_pos|float|%|01 11/45|1|
|steering_wheel_angle|int/float|°|-|?|
|steering_wheel_speed|int/float|rad/sec|-|?|
|coolant_temp|int|°C|01 05|1|
|brake_switch|bool|I/O||?|
|vehicle_speed|int|km/h|01 0D|?|
|engine_load|float|%|01 04|1|
|engine_rpm|int|rpm|01 0C|1|
|fuel_consumption_rt|float|mmc/sec||?|
|current_gear|int|0-6||?|

PIDs supported 01 60

#### Nachrichtenstruktur
Beispiel:
```json
{
    "header": {
        "timestamp": "2024-06-18 13:46:22.853",
        "uudi": "f437137a-0d5b-46f7-b204-8ca4b94177aa",
        "type": 1,
    },
    "payload": {
        "position": {
            "latitude": 48.840550,
            "longtitude": 10.068598
        },
        "travel_distance": 2.73,
        "vehicle_speed": 50,
        "engine": {
            "load": 0.46,
            "rpm": 3129,
            "coolant_temp": 78,
            "fuel_consumption_rt": 20.3
        },
        "driver": {
            "throttle_pos": 0.71,
            "steering_wheel": {
                "angle": 23,
                "speed": 5
            },
            "brake": false,
            "current_gear": 3
        }
    }
}
```

- Nachrichten werden via WireGuard VPN im Sekundentakt ans Raspberry Pi - Backend (Websocket) geschickt
- Backend unterscheidet zwischen unterschiedlichen Nachrichtentypen (Hier: Typ 1)
- Backend ordnet Daten der Nachricht in eine Eingangsdatenbank (InfluxDB) ein

#### Database-Header:
```cpp
timestamp (YYYY-MM-dd-hh:mm:ss), uuid, position (latitude/longtitude), travel_distance (meters), throttle_pos (%), steering_wheel_angle (degrees), steering_wheel_speed (rad/sec),  coolant_temp (°C), brake_switch (true/false), vehicle_speed (km/h), engine_load (Nm), engine_rpm (rpm), fuel_consumption_rt (mmc/sec), current_gear (0-6)
```

- Backend startet nach jedem Zeitevent einen Timer (5-10 Min), der bei Eingang eins neuen Zeitevents gestoppt wird
- Läuft der Timer ab, wird die Fahrt als Beendet gewertet und die Auswertung der Daten beginnt
- Daten werden hierfür temporär in eine Vorverarbeitungs-Datenbank eingelagert und aus der Eingangsdatenbank gelöscht

## 2. Data Preprocessing

## 3. Data Labeling

## 4. ML Model

3 Output Nodes

### Bewertungsaspekte
- Umweltbewusstsein
- Verschleißprävention
- Fahrsicherheit