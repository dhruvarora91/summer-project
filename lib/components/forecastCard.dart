import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/weather.dart';

class ForecastCard extends StatelessWidget {
  ForecastCard({
    @required this.date,
    @required this.iconCode,
    @required this.temperature,
    @required this.description,
  });
  final int date;

  final iconCode;
  final int temperature;
  final String description;

  var icon;

  @override
  Widget build(BuildContext context) {
    icon = getIconData(iconCode);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                DateFormat('E, ha').format(
                  DateTime.fromMillisecondsSinceEpoch(date * 1000),
                ),
              ),
              SizedBox(height: 10.0),
              Icon(
                icon,
                size: 30,
              ),
              SizedBox(height: 10.0),
              Text('$temperature°'),
              SizedBox(height: 10.0),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }
}
