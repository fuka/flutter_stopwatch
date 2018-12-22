import 'dart:async';

class StopwatchLogic {
  StopwatchCallback stopwatchCallback;

  StopwatchLogic(this.stopwatchCallback) {
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(Duration(milliseconds: 30), _callback);
  }

  Stopwatch _stopwatch;
  Timer _timer;

  void dispose() {
    _stopwatch?.stop();
    _stopwatch = null;

    _timer?.cancel();
    _timer = null;
  }

  void toggle() {
    bool isPlaying;

    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      isPlaying = false;
    } else {
      _stopwatch.start();
      isPlaying = true;
    }

    stopwatchCallback.stateChanged(isPlaying);
  }

  void reset() {
    _stopwatch.stop();
    _stopwatch.reset();

    stopwatchCallback.stateChanged(false);
  }

  void _callback(Timer timer) {
    if (_stopwatch.isRunning) {
      int milliseconds = _stopwatch.elapsedMilliseconds;
      final int hundreds = (milliseconds / 10).truncate();
      final int sec = (hundreds / 100).truncate();
      final int min = (sec / 60).truncate();

      int upperMin = min ~/ 10;
      int lowerMin;
      int upperSec;
      int lowerSec;

      if (upperMin > 9) {
        upperMin = 9;
        lowerMin = 9;
        upperSec = 9;
        lowerSec = 9;
      } else {
        lowerMin = min % 10;
        upperSec = (sec - (min * 60)) ~/ 10;
        lowerSec = sec % 10;
      }

      stopwatchCallback.valueChanged(upperMin, lowerMin, upperSec, lowerSec);
    }
  }
}

abstract class StopwatchCallback {
  void valueChanged(int upperMin, int lowerMin, int upperSec, int lowerSec);

  void stateChanged(bool isPlaying);
}
