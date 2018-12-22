import 'package:flutter/material.dart';
import 'package:stopwatch/ui/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: ThemeData.dark(),
      home: MainPage(),
    );
  }
}
