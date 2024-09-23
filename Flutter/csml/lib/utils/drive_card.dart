import 'package:csml/utils/colors.dart';
import 'package:flutter/material.dart';

class DriveCard extends StatelessWidget {
  final String location;
  final String distance;
  final String time;
  final String fsValue;
  final String ubValue;
  final String vpValue;

  DriveCard({
    required this.location,
    required this.distance,
    required this.time,
    required this.fsValue,
    required this.ubValue,
    required this.vpValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: mycolorGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            location,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                distance,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
              ),
              Text(
                time,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'FS',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    fsValue,
                    style: TextStyle(color: mycolorPurple, fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'UB',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    ubValue,
                    style: TextStyle(color: mycolorPink, fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'VP',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    vpValue,
                    style: TextStyle(color: mycolorOrange, fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}