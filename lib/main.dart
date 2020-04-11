import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/model/stopwatch_model.dart';
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
      home: ChangeNotifierProvider(
        create: (_) => StopwatchModel(),
        child: MainPage(),
      ),
    );
  }
}
