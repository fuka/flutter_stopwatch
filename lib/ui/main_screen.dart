import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stopwatch/logic/stopwatch_logic.dart';
import 'package:stopwatch/ui/help_dialog.dart';
import 'package:stopwatch/ui/indicator.dart';
import 'package:stopwatch/ui/number_display.dart';
import 'package:stopwatch/ui/stopwatch_model.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stopwatch"),
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
            const PopupMenuItem<String>(value: "ABOUT", child: Text("About")),
            const PopupMenuItem<String>(value: "HELP", child: Text('Help'))
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

class _StopWatchArea extends StatefulWidget {
  _StopWatchArea({Key key}) : super(key: key);

  @override
  State<_StopWatchArea> createState() => _StopWatchAreaState();
}

class _StopWatchAreaState extends State<_StopWatchArea> implements StopwatchCallback {
  final indicatorKey = GlobalKey<IndicatorState>();

  StopwatchLogic _stopwatchLogic;
  StopwatchModel _stopwatchModel;

  @override
  void initState() {
    _stopwatchLogic = StopwatchLogic(this);
    _stopwatchModel = StopwatchModel();
    super.initState();
  }

  @override
  void dispose() {
    _stopwatchLogic?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<StopwatchModel>(
      model: _stopwatchModel,
      child: GestureDetector(
        onLongPress: () {
          _stopwatchLogic?.reset();
        },
        onTap: () {
          _stopwatchLogic?.toggle();
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            _buildWatchContainer(),
            Indicator(key: indicatorKey),
          ],
        ),
      ),
    );
  }

  Widget _buildWatchContainer() {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildMinutesContainer(),
          _buildSecondsContainer(),
        ],
      ),
    );
  }

  Widget _buildMinutesContainer() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ScopedModelDescendant<StopwatchModel>(builder: (context, child, model) => NumberDisplay(number: model.upperMin)),
        ScopedModelDescendant<StopwatchModel>(builder: (context, child, model) => NumberDisplay(number: model.lowerMin)),
      ],
    );
  }

  Widget _buildSecondsContainer() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ScopedModelDescendant<StopwatchModel>(builder: (context, child, model) => NumberDisplay(number: model.upperSec)),
        ScopedModelDescendant<StopwatchModel>(builder: (context, child, model) => NumberDisplay(number: model.lowerSec)),
      ],
    );
  }

  @override
  void valueChanged(int upperMin, int lowerMin, int upperSec, int lowerSec) {
    _stopwatchModel.changeValue(upperMin, lowerMin, upperSec, lowerSec);
  }

  @override
  void stateChanged(bool isPlaying) {
    indicatorKey.currentState.changeState(isPlaying);
  }
}
