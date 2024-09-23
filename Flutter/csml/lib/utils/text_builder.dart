import 'package:flutter/material.dart';

// Funktion zum Erstellen eines Containers mit Titel und Text
Widget buildTextContainer({
  required Color titleColor,
  required String title,
  required String text,
  required Color containerColor,
}) {
  return Container(
    color: containerColor, // Hintergrundfarbe des Containers
    padding: const EdgeInsets.all(8.0), // Padding innerhalb des Containers
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Text linksbündig ausrichten
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 25,
            color: titleColor, // Titel fett darstellen
          ),
        ),
        SizedBox(height: 4.0), // Abstand zwischen Titel und Text
        Text(
          text,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 18, // Etwas kleinere Schriftgröße für den Text
            color: Colors.white, // Schriftfarbe des Textes
            fontWeight: FontWeight.w300
          ),
        ),
      ],
    ),
  );
}