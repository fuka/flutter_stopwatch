import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchModel with ChangeNotifier {
  bool _isPlaying;
  int _upperMin;
  int _lowerMin;
  int _upperSec;
  int _lowerSec;

  Stopwatch _stopwatch;
  Timer _timer;

  bool get isPlaying => _isPlaying;

  int get upperMin => _upperMin;

  int get lowerMin => _lowerMin;

  int get upperSec => _upperSec;

  int get lowerSec => _lowerSec;

  StopwatchModel() {
    _isPlaying = false;
    _upperMin = 0;
    _lowerMin = 0;
    _upperSec = 0;
    _lowerSec = 0;

    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(milliseconds: 200), _callback);
  }

  void dispose() {
    super.dispose();

    _stopwatch?.stop();
    _stopwatch = null;

    _timer?.cancel();
    _timer = null;
  }

  void toggle() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _isPlaying = false;
    } else {
      _stopwatch.start();
      _isPlaying = true;
    }

    notifyListeners();
  }

  void reset() {
    debugPrint('reset');
    _stopwatch.stop();
    _stopwatch.reset();

    _isPlaying = false;
    _upperMin = 0;
    _lowerMin = 0;
    _upperSec = 0;
    _lowerSec = 0;

    notifyListeners();
  }

  void _callback(Timer timer) {
    if (_stopwatch.isRunning) {
      int milliseconds = _stopwatch.elapsedMilliseconds;
      final int hundreds = (milliseconds / 10).truncate();
      final int sec = (hundreds / 100).truncate();
      final int min = (sec / 60).truncate();

      _upperMin = min ~/ 10;

      if (_upperMin > 9) {
        _upperMin = 9;
        _lowerMin = 9;
        _upperSec = 9;
        _lowerSec = 9;
      } else {
        _lowerMin = min % 10;
        _upperSec = (sec - (min * 60)) ~/ 10;
        _lowerSec = sec % 10;
      }

      notifyListeners();
    }
  }
}
