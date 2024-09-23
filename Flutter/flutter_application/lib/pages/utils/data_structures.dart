import 'package:intl/intl.dart'; // Für die Formatierung des Timestamps

class Header {
  final String timestamp;
  final String uuid;
  final String driveId;

  Header({
    required this.timestamp,
    required this.uuid,
    required this.driveId,
  });

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp,
    'uuid': uuid,
    'drive_id': driveId,
  };
}

class Engine {
  final String load;
  final String rpm;
  final String coolantTemp;
  final String fuelConsumptionRt;

  Engine({
    required this.load,
    required this.rpm,
    required this.coolantTemp,
    required this.fuelConsumptionRt,
  });

  Map<String, dynamic> toJson() => {
    'load': load,
    'rpm': rpm,
    'coolant_temp': coolantTemp,
    'fuel_consumption_rt': fuelConsumptionRt,
  };
}

class Driver {
  final String throttlePos;

  Driver({required this.throttlePos});

  Map<String, dynamic> toJson() => {
    'throttle_pos': throttlePos,
  };
}

class Position {
  final String latitude;
  final String longitude;

  Position({required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
  };
}

class Payload {
  final Position position;
  final String vehicleSpeed;
  final Engine engine;
  final Driver driver;

  Payload({
    required this.position,
    required this.vehicleSpeed,
    required this.engine,
    required this.driver,
  });

  Map<String, dynamic> toJson() => {
    'position': position.toJson(),
    'vehicle_speed': vehicleSpeed,
    'engine': engine.toJson(),
    'driver': driver.toJson(),
  };
}

class DataStructure {
  final Header header;
  final Payload payload;

  DataStructure({required this.header, required this.payload});

  Map<String, dynamic> toJson() => {
    'header': header.toJson(),
    'payload': payload.toJson(),
  };
}

DataStructure createDataStructure(
    String uuid, 
    String driveId,
    String latitude,
    String longitude,
    String vehicleSpeed,
    String engineLoad,
    String engineRpm,
    String engineCoolantTemp,
    String engineFuelConsumptionRt,
    String throttlePos) {

  // Aktuellen Zeitstempel erzeugen
  String timestamp = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(DateTime.now());

  // Header und Payload erstellen
  Header header = Header(
    timestamp: timestamp,
    uuid: uuid,
    driveId: driveId,
  );

  Engine engine = Engine(
    load: engineLoad,
    rpm: engineRpm,
    coolantTemp: engineCoolantTemp,
    fuelConsumptionRt: engineFuelConsumptionRt,
  );

  Driver driver = Driver(
    throttlePos: throttlePos,
  );

  Position position = Position(
    latitude: latitude,
    longitude: longitude,
  );

  Payload payload = Payload(
    position: position,
    vehicleSpeed: vehicleSpeed,
    engine: engine,
    driver: driver,
  );

  // DataStructure erstellen
  return DataStructure(
    header: header,
    payload: payload,
  );
}
