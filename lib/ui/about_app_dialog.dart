import 'package:flutter/material.dart';

class AboutAppDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AboutDialog(
      applicationName: "Stopwatch",
      applicationVersion: "0.1",
      applicationIcon: Image.asset(
        "assets/icons/app_icon.png",
        fit: BoxFit.contain,
        width: 48,
        color: Colors.white,
      ),
    );
  }
}
