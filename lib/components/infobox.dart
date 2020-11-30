import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  InfoBox({@required this.color, @required this.child});
  final Color color;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: Colors.white,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }
}