import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphContainer extends StatelessWidget {
  final List<FlSpot> dataPoints;
  final Color color;
  final String route;
  final BuildContext context;
  final String title;

  GraphContainer({
    required this.dataPoints,
    required this.color,
    required this.route,
    required this.context,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(0.0), // Runder Rand für Container
          ),
          child: Stack(
            children: [
              // Liniendiagramm mit Abstand zum Rand
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 50.0, 20.0, 10.0), // Abstand links und rechts
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false), // Rasterlinien ausblenden
                    titlesData: FlTitlesData(
                      bottomTitles: SideTitles(showTitles: false),
                      leftTitles: SideTitles(showTitles: false),
                      topTitles: SideTitles(showTitles: false),
                      rightTitles: SideTitles(showTitles: false),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.transparent), // Keine sichtbare Randlinie
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: dataPoints,
                        isCurved: false, // Setze dies auf false für eckige Linien
                        colors: [Colors.white],
                        barWidth: 1, // Breite der Linie
                        isStrokeCapRound: false, // Verwende keine runden Enden
                        dotData: FlDotData(show: false), // Punkte auf der Linie anzeigen
                        belowBarData: BarAreaData(show: false), // Bereich unter der Linie ausblenden
                      ),
                    ],
                  ),
                ),
              ),
              // Button oben rechts
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.all(0), // Abstand vom Rand des Containers
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: () {
                      if(route != '') {
                        Navigator.pushNamed(context, route);
                      }
                    },
                  ),
                ),
              ),
              // Titel oben links
              Positioned(
                top: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Abstand vom Rand des Containers
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

