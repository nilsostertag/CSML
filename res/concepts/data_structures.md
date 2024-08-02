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
|coolant_temp|int|°C|01 05|1|
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
            "throttle_pos": 0.71
        }
    }
}
```

- Nachrichten werden via WireGuard VPN im Sekundentakt ans Raspberry Pi - Backend (Websocket) geschickt
- Backend unterscheidet zwischen unterschiedlichen Nachrichtentypen (Hier: Typ 1)
- Backend ordnet Daten der Nachricht in eine Eingangsdatenbank (InfluxDB) ein

#### Database-Header:
```cpp
timestamp (YYYY-MM-dd-hh:mm:ss), uuid, drive_id, latitude, longtitude, 
travel_distance (meters), throttle_pos (%), vehicle_speed (km/h), 
engine_load (Nm), engine_rpm (rpm), fuel_consumption_rt (mmc/sec)
```

- Backend startet nach jedem Zeitevent einen Timer (5-10 Min), der bei Eingang eins neuen Zeitevents gestoppt wird
- Läuft der Timer ab, wird die Fahrt als Beendet gewertet und die Auswertung der Daten beginnt
- Daten werden hierfür temporär in eine Vorverarbeitungs-Datenbank eingelagert und aus der Eingangsdatenbank gelöscht

## 2. Data Preprocessing
- Ergänzung des Datensatzes um wichtige Parameter
- Komplett-Übersicht:

|Rohdaten |Ergänzt |
|-|-|
|engine_rpm|delta_engine_rpm|
|engine_load|delta_engine_load|
|vehicle_speed|delta_vehicle_speed|
|throttle_pos|delta_throttle_pos|
|fuel_consumption_rt|delta_fuel_consumption_rt|
||allowed_speed (OSM/Overpass API)|
||diff_allowed_speed|

Delta beschreibt hierbei die Veränderung zum vorherigen Eintrag (1 Sek.)

## 3. Data Labeling
Welche Daten beeinflussen welche Bewertungsapekt wie stark?

- Fahrsicherheit

| Parameter | Effekt auf Bewertung (Je höher/niedriger) | Impact |
|-|-|-|
|engine_rpm|-/+|1|
|delta_engine_rpm|-/+|3|
|engine_load|-/+|1|
|delta_engine_load|-/-|1|
|vehicle_speed|-/+|1|
|delta_vehicle_speed|-/-|3|
|throttle_pos|-/0|2|
|delta_throttle_pos|-/0|2|
|fuel_consumption_rt|-/+|1|
|delta_fuel_consumption_rt|-/+|1|
|allowed_speed|0/0|0|
|diff_allowed_speed|-/+|3|

- Umweltbewusstsein

| Parameter | Effekt auf Bewertung (Je höher/niedriger) | Impact |
|-|-|-|
|engine_rpm|-/+|3|
|delta_engine_rpm|-/+|3|
|engine_load|-/+|3|
|delta_engine_load|-/+|3|
|vehicle_speed|0/0|1|
|delta_vehicle_speed|-/+|1|
|throttle_pos|-/0|2|
|delta_throttle_pos|-/0|2|
|fuel_consumption_rt|-/+|3|
|delta_fuel_consumption_rt|-/+|3|
|allowed_speed|0/0|0|
|diff_allowed_speed|0/0|0|

- Verschleißprävention

| Parameter | Effekt auf Bewertung (Je höher/niedriger) | Impact |
|-|-|-|
|engine_rpm|-/+|3|
|delta_engine_rpm|-/+|3|
|engine_load|-/+|2|
|delta_engine_load|-/-|3|
|vehicle_speed|0|1|
|delta_vehicle_speed|-/-|3|
|throttle_pos|-/0|2|
|delta_throttle_pos|-/0|2|
|fuel_consumption_rt|-/+|2|
|delta_fuel_consumption_rt|-/+|2|
|allowed_speed|0/0|0|
|diff_allowed_speed|0/0|0|



## 4. ML Model

(3 Output Nodes)\
3 Predictions
### Bewertungsaspekte
- Umweltbewusstsein
- Verschleißprävention
- Fahrsicherheit