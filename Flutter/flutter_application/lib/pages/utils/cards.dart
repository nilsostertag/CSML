import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final Color color;
  //final String icon;

  const HomeCard({super.key, 
    required this.title,
    required this.color,
    //required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 450,
              color: const Color(0x00390099),
          )
    );
  }
}