import 'package:flutter/material.dart';

class RectangleModel extends ChangeNotifier {
  double length = 0;
  double breadth = 0;
  double depth = 0;
  double? volume; // null until calculated

  void setMeasurements(double l, double b, double d) {
    length = l;
    breadth = b;
    depth = d;
    notifyListeners();
  }

  void reset() {
    length = 0;
    breadth = 0;
    depth = 0;
    volume = null;
    notifyListeners();
  }

  void computeVolume() {
    volume = length * breadth * depth;
    notifyListeners();
  }
}
