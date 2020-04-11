import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/model/stopwatch_model.dart';

class Indicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<StopwatchModel, bool>(
      selector: (context, model) => model.isPlaying,
      builder: (context, value, child) => _Indicator(isPlaying: value),
    );
  }
}

class _Indicator extends StatefulWidget {
  final bool isPlaying;

  _Indicator({Key key, @required this.isPlaying}) : super(key: key);

  @override
  State<_Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<_Indicator> with SingleTickerProviderStateMixin<_Indicator> {
  bool _isPlaying;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _isPlaying = widget.isPlaying;
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animationController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isPlaying != widget.isPlaying) {
      _isPlaying = widget.isPlaying;
      _animationController.forward().then((_) => _animationController.reverse());
    }

    return Opacity(
      opacity: _animationController.value,
      child: Icon(
        widget.isPlaying ? Icons.play_circle_filled : Icons.pause_circle_filled,
        color: Colors.white,
        size: 128,
      ),
    );
  }
}
