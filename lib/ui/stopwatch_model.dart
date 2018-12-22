import 'package:scoped_model/scoped_model.dart';

class StopwatchModel extends Model {
  int upperMin;
  int lowerMin;
  int upperSec;
  int lowerSec;

  StopwatchModel() {
    upperMin = 0;
    lowerMin = 0;
    upperSec = 0;
    lowerSec = 0;
  }

  void changeValue(int upperMin, int lowerMin, int upperSec, int lowerSec) {
    this.upperMin = upperMin;
    this.lowerMin = lowerMin;
    this.upperSec = upperSec;
    this.lowerSec = lowerSec;

    notifyListeners();
  }
}
