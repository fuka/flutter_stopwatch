import 'package:flutter/material.dart';

class Indicator extends StatefulWidget {
  Indicator({Key key}) : super(key: key);

  @override
  State<Indicator> createState() => IndicatorState();
}

class IndicatorState extends State<Indicator> with SingleTickerProviderStateMixin<Indicator> {
  bool _isPlaying;
  AnimationController _animationController;

  @override
  void initState() {
    _isPlaying = false;
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animationController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _animationController.value,
      child: Icon(
        _isPlaying ? Icons.play_circle_filled : Icons.pause_circle_filled,
        color: Colors.white,
        size: 128,
      ),
    );
  }

  void changeState(bool isPlaying) {
    if (_isPlaying != isPlaying) {
      setState(() {
        _isPlaying = isPlaying;
      });

      _playAnimation();
    }
  }

  Future<void> _playAnimation() async {
    try {
      await _animationController.forward().orCancel;
      await _animationController.reverse().orCancel;
    } on TickerCanceled {}
  }
}
