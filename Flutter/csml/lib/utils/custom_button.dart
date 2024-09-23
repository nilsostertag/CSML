import 'package:flutter/material.dart';

Widget buildCustomButton(String text, Color color, String route, BuildContext context, String imagePath, double opacity) {
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
        child: Stack(
          children: [
            // Titel oben links im Button mit etwas Abstand
            Positioned(
              top: 8.0,
              left: 8.0,
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Icon/Png-Bild in der linken Hälfte mit einer bestimmten Transparenz
            Positioned(
              right: 0.0,
              top: 20.0, // Abstand vom oberen Rand
              child: Opacity(
                opacity: opacity, // Transparenz des Icons/PNG-Bildes
                child: Image.asset(
                  imagePath,
                  width: 50.0, // Breite des Icons/Bildes
                  height: 50.0, // Höhe des Icons/Bildes
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildButton(String text, Color color, String route, BuildContext context) {
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