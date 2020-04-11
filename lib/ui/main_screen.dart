import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/model/stopwatch_model.dart';
import 'package:stopwatch/ui/help_dialog.dart';
import 'package:stopwatch/ui/indicator.dart';
import 'package:stopwatch/ui/number_display.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stopwatch"),
        actions: <Widget>[
          _buildPopupMenuButton(context),
        ],
      ),
      body: _StopWatchArea(),
    );
  }

  Widget _buildPopupMenuButton(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(value: "ABOUT", child: const Text("About")),
        const PopupMenuItem<String>(value: "HELP", child: const Text('Help'))
      ],
      onSelected: (String value) {
        _select(context, value);
      },
    );
  }

  void _select(BuildContext context, String value) {
    switch (value) {
      case "ABOUT":
        showDialog(context: context, builder: (BuildContext context) => AboutDialog());
        break;
      case "HELP":
        showDialog(context: context, builder: (BuildContext context) => HelpDialog());
        break;
    }
  }
}

class _StopWatchArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stopWatchModel = Provider.of<StopwatchModel>(context, listen: false);

    return GestureDetector(
      onLongPress: () {
        stopWatchModel.reset();
      },
      onTap: () {
        stopWatchModel.toggle();
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          _buildWatchContainer(context),
          Indicator(),
        ],
      ),
    );
  }

  Widget _buildWatchContainer(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildMinutesContainer(context),
          _buildSecondsContainer(context),
        ],
      ),
    );
  }

  Widget _buildMinutesContainer(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Selector<StopwatchModel, int>(
          selector: (context, model) => model.upperMin,
          builder: (context, value, child) => NumberDisplay(number: value),
        ),
        Selector<StopwatchModel, int>(
          selector: (context, model) => model.lowerMin,
          builder: (context, value, child) => NumberDisplay(number: value),
        ),
      ],
    );
  }

  Widget _buildSecondsContainer(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Selector<StopwatchModel, int>(
          selector: (context, model) => model.upperSec,
          builder: (context, value, child) => NumberDisplay(number: value),
        ),
        Selector<StopwatchModel, int>(
          selector: (context, model) => model.lowerSec,
          builder: (context, value, child) => NumberDisplay(number: value),
        ),
      ],
    );
  }
}
