import 'package:csml/utils/colors.dart';
import 'package:csml/utils/graph_container.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Fahrdatenanalyse          ',
            style: TextStyle(color: Colors.white), // Schriftfarbe des Titels
          ),
        ),
        backgroundColor: mycolorBackground, // Hintergrundfarbe der AppBar
        iconTheme: const IconThemeData(color: const Color.fromRGBO(239, 35, 60, 1)), // Farbe des Zurück-Pfeils
      ),
      body: Container(
        color: mycolorBackground, // Hintergrundfarbe der Seite
        child: Center(
          child: Column(
            children: [
          Expanded(
            child: Column(
              children: [
                GraphContainer(
                  dataPoints: [
                    FlSpot(0, 782),
                    FlSpot(1, 723),
                    FlSpot(2, 776),
                    FlSpot(3, 817),
                    FlSpot(4, 790),
                    FlSpot(5, 783),
                    FlSpot(6, 821),
                    FlSpot(7, 803),
                  ],
                  color: mycolorPurple,
                  //btnColor: Colors.white,
                  route: '/details_safety',
                  context: context,
                  title: 'Fahrsicherheit'
                ),
                SizedBox(height: 10),
                GraphContainer(
                  dataPoints: [
                    FlSpot(0, 679),
                    FlSpot(1, 651),
                    FlSpot(2, 665),
                    FlSpot(3, 688),
                    FlSpot(4, 709),
                    FlSpot(5, 721),
                    FlSpot(6, 729),
                    FlSpot(7, 743),
                  ],
                   color: mycolorPink,
                   //btnColor: Colors.white,
                   route: '/details_eco',
                   context: context,
                   title: 'Umweltbewusstsein'
                ),
                SizedBox(height: 10),
                GraphContainer(
                  dataPoints: [
                    FlSpot(0, 701),
                    FlSpot(1, 685),
                    FlSpot(2, 698),
                    FlSpot(3, 711),
                    FlSpot(4, 718),
                    FlSpot(5, 702),
                    FlSpot(6, 723),
                    FlSpot(7, 764),
                  ],
                   color: mycolorOrange,
                   //btnColor: Colors.white,
                   route: '/details_wear',
                   context: context,
                   title: 'Verschleißprävention'
                ),
              ],
            ),
          ),
          ],
          )
        ),
      ),
    );
  }
}