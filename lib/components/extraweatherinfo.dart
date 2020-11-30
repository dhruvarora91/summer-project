import 'package:flutter/material.dart';

class WeatherMinorDetails extends StatelessWidget {
  WeatherMinorDetails({
    @required this.title,
    @required this.value,
  });
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value),
      ],
    );
  }
}
