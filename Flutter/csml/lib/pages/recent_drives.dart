import 'package:csml/pages/detail_drive.dart';
import 'package:csml/utils/colors.dart';
import 'package:csml/utils/drive_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecentDrives extends StatelessWidget {
  const RecentDrives({super.key});

  @override
  Widget build(BuildContext context) {
    // Liste mit mehreren DriveCard-Widgets
    final List<DriveCard> driveCards = [
      DriveCard(
        location: 'Heidenheim - Aalen',
        distance: '26 km',
        time: '00:31 h',
        fsValue: '326',
        ubValue: '783',
        vpValue: '598',
      ),
      DriveCard(
        location: 'Aalen - Unterelchingen',
        distance: '62.5 km',
        time: '00:44 h',
        fsValue: '326',
        ubValue: '783',
        vpValue: '598',
      ),
      DriveCard(
        location: 'Unterelchingen - Nerenstetten',
        distance: '29.9 km',
        time: '00:29 h',
        fsValue: '326',
        ubValue: '783',
        vpValue: '598',
      ),
      DriveCard(
        location: 'Nerenstetten - Ulm',
        distance: '62.5 km',
        time: '00:44 h',
        fsValue: '326',
        ubValue: '783',
        vpValue: '598',
      ),
      DriveCard(
        location: 'Ulm - Stuttgart',
        distance: '92 km',
        time: '01:10 h',
        fsValue: '450',
        ubValue: '900',
        vpValue: '700',
      ),
      DriveCard(
        location: 'Stuttgart - Nürnberg',
        distance: '160 km',
        time: '02:15 h',
        fsValue: '500',
        ubValue: '1000',
        vpValue: '850',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Vergangene Fahrten          ',
            style: TextStyle(color: Colors.white), // Schriftfarbe des Titels
          ),
        ),
        backgroundColor: mycolorBackground,
        iconTheme: const IconThemeData(color: const Color.fromRGBO(239, 35, 60, 1)),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: driveCards.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DriveDetailScreen(index: index),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: driveCards[index],
            ),
          );
        }
      ),
    );
  }
}