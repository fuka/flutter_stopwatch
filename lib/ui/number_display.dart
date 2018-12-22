import 'package:flutter/material.dart';

class NumberDisplay extends StatelessWidget {
  final int number;

  NumberDisplay({Key key, @required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(number.toString(), style: digitTextStyle),
      ),
    );
  }
}

const TextStyle digitTextStyle = const TextStyle(
  color: Colors.white,
  textBaseline: TextBaseline.alphabetic,
  fontSize: 224,
  fontFamily: "7bar",
);
