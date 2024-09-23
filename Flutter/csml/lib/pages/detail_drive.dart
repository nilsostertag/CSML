import 'package:csml/utils/colors.dart';
import 'package:flutter/material.dart';

class DriveDetailScreen extends StatelessWidget {
  final int index;

  DriveDetailScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: 
            Text('Fahrt im Detail         ', 
              style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
        backgroundColor: mycolorBackground,
        iconTheme: const IconThemeData(color: const Color.fromRGBO(239, 35, 60, 1)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fahrt vom 21.08.2024',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 16),
            Table(
              border: TableBorder.all(color: mycolorBackground),
              children: [
                TableRow(children: [
                  Container(
                    color: mycolorGrey, // Farbe der ersten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Start', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  Container(
                    color: mycolorGrey, // Farbe der zweiten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('12:21:32', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300)),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    color: mycolorGrey, // Farbe der ersten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Ende', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  Container(
                    color: mycolorGrey, // Farbe der zweiten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('12:50:19', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300)),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    color: mycolorGrey, // Farbe der ersten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Von', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  Container(
                    color: mycolorGrey, // Farbe der zweiten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Unterelchingen', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300)),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    color: mycolorGrey, // Farbe der ersten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Nach', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  Container(
                    color: mycolorGrey, // Farbe der zweiten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Nerenstetten', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300)),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    color: mycolorGrey, // Farbe der ersten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Fahrtdauer', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  Container(
                    color: mycolorGrey, // Farbe der zweiten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('00:29 h', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300)),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    color: mycolorGrey, // Farbe der ersten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Fahrtstrecke', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  Container(
                    color: mycolorGrey, // Farbe der zweiten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('29.9 km', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300)),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    color: mycolorGrey, // Farbe der ersten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Max. Geschw.', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  Container(
                    color: mycolorGrey, // Farbe der zweiten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('161 km/h', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300)),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    color: mycolorGrey, // Farbe der ersten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Geschwindigkeit ⌀', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  Container(
                    color: mycolorGrey, // Farbe der zweiten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('59.91 km/h', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300)),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    color: mycolorGrey, // Farbe der ersten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Erlaubte Geschw. ⌀', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  Container(
                    color: mycolorGrey, // Farbe der zweiten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('62.31 km/h', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300)),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    color: mycolorGrey, // Farbe der ersten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Beschleunigungen', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  Container(
                    color: mycolorGrey, // Farbe der zweiten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('41', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300)),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    color: mycolorGrey, // Farbe der ersten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Stark Gebremst', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  Container(
                    color: mycolorGrey, // Farbe der zweiten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('43', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300)),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    color: mycolorGrey, // Farbe der ersten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Gaspedal ⌀', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  Container(
                    color: mycolorGrey, // Farbe der zweiten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('24.15 %', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300)),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    color: mycolorGrey, // Farbe der ersten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Motorlast ⌀', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  Container(
                    color: mycolorGrey, // Farbe der zweiten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('34.29 %', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300)),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    color: mycolorGrey, // Farbe der ersten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Umdrehungen ⌀', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  Container(
                    color: mycolorGrey, // Farbe der zweiten Zelle in dieser Zeile
                    padding: const EdgeInsets.all(8.0),
                    child: Text('1878.59 rpm', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300)),
                  ),
                ]),
              ],
            ),
          ]
        ),
        ),
      ),
    );
  }
}