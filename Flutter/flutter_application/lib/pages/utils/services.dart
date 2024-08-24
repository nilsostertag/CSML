import 'package:geolocator/geolocator.dart';

Future<Position> getLocation() async {
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  return position;
}

Stream<Position> getLiveLocation() {
  // Überprüft die Standortberechtigungen und fordert sie an, falls notwendig
  Future<void> _checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Standortberechtigung abgelehnt');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Standortberechtigung permanent abgelehnt');
    }
  }

  // Überprüft, ob der Standortdienst aktiviert ist
  Future<void> _checkService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Standortdienst ist deaktiviert');
    }
  }

  // Die Hauptfunktion, die den Livestream der Position zurückgibt
  Stream<Position> _getPositionStream() async* {
    await _checkService();
    await _checkPermissions();
    
    // Liefert den Positionsstream
    yield* Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.best, // Genauigkeit einstellen
        distanceFilter: 10, // Minimale Distanz zwischen Updates (in Metern)
      ),
    );
  }

  return _getPositionStream();
}