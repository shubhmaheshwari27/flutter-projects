import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ColorChanger(),
    );
  }
}

class ColorChanger extends StatefulWidget {
  @override
  _ColorChangerState createState() => _ColorChangerState();
}

class _ColorChangerState extends State<ColorChanger> {
  Color backgroundColor = Colors.orange;
  List<Color> cycleColors = [Colors.red, Colors.yellow, Colors.blue];
  int colorIndex = 0;
  bool isFirstClick = true;

  void changeColor() {
    setState(() {
      if (isFirstClick) {
        backgroundColor = cycleColors[0]; // Change to red on first click
        isFirstClick = false;
      } else {
        colorIndex = (colorIndex + 1) % cycleColors.length;
        backgroundColor = cycleColors[colorIndex];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: ElevatedButton(
          onPressed: changeColor,
          child: Text('Change Color'),
        ),
      ),
    );
  }
}