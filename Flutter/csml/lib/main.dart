import 'package:csml/pages/analytics.dart';
import 'package:csml/pages/my_car.dart';
import 'package:csml/pages/recent_drives.dart';
import 'package:csml/pages/recorder.dart';
import 'package:csml/pages/settings.dart';
import 'package:csml/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarSenseML',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: mycolorBackground, // Hintergrundfarbe der Seite
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black), // Schriftfarbe für den Text
        ),
      ),
      home: HomePage(),
      routes: {
        '/analytics': (context) => Analytics(),
        '/my_car': (context) => MyCar(),
        '/recent_drives': (context) => RecentDrives(),
        '/recorder': (context) => Recorder(),
        '/settings': (context) => Settings()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('CarSenseML',
          style: TextStyle(color: Colors.white), // Schriftfarbe des Titels)
          ),
        ),
        backgroundColor: mycolorBackground, // Hintergrundfarbe der AppBar
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                _buildButton('Mein Fahrzeug', mycolorPurple, '/my_car', context),
                const SizedBox(height: 10), // Abstand zwischen Buttons
                _buildButton('Fahrstilanalyse', mycolorPink, '/analytics', context),
                const SizedBox(height: 10), // Abstand zwischen Buttons
                _buildButton('Vergangene Fahrten', mycolorOrange, '/recent_drives', context),
                const SizedBox(height: 10), // Abstand zwischen Buttons
                _buildButton('Einstellungen', mycolorYellow, '/settings', context),
              ],
            ),
          ),
          SizedBox(height: 10), // Abstand zwischen dem letzten Button und dem kleinen Button
          Container(
            height: 50, // Höhe des kleinen Buttons
            width: double.infinity, // Breite des kleinen Buttons auf volle Breite des Bildschirms
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/recorder');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mycolorRed, // Hintergrundfarbe des kleinen Buttons
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Eckige Ecken
                ),
              ),
              child: Text(
                'Fahrt aufnehmen',
                style: TextStyle(color: Colors.white,
                fontSize: 20.0
                ), // Schriftfarbe des kleinen Buttons
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color, String route, BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity, // Breite des Buttons auf volle Breite des Bildschirms
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color, // Hintergrundfarbe des Buttons
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // Eckige Ecken
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, // Schriftfarbe der großen Buttons
            fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}