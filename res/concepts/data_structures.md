# Konzeptionierung von Datenstrukturen

### Data Aquisition: OBD II - Rohdaten

CSV-Header:
```cpp
timestamp (YYYY-MM-dd-hh:mm:ss), uuid, position (latitude/longtitude), travelled_distance (meters), absolute_throttle_position (%), steering_wheel_angle (degrees), steering_wheel_speed (rad/sec),  coolant_temperature (°C), brake_switch (true/false), vehigle_speed (km/h), engine_load (Nm), engine_rpm (rpm), real_time_fuel_consumption (mmc/sec), current_gear (0-6)
```

TODO: Tabellarische Übersicht mit Datenpunkt, Einheit, PID

### Bewertungsaspekte
- Umweltbewusstsein
- Verschleißprävention
- Fahrsicherheit