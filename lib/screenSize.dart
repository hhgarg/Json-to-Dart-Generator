import 'package:flutter/material.dart';

bool get isPortrait => ScreenSize.orientation == Orientation.portrait;

class ScreenSize {
  static double w;
  static double h;
  static double _minDimension;
  static double _screenWidth;
  static double _screenHeight;
  static Orientation orientation;
  static MediaQueryData _mediaQueryData;
  static void recalculate(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    //? Calculate 1% of the screen width or heigth
    w = _screenWidth / 100;
    h = _screenHeight / 100;
    // Decide which dimension is smaller
    if (_screenWidth < _screenHeight) {
      orientation = Orientation.portrait;
      _minDimension = _screenWidth / 100.0;
    } else {
      orientation = Orientation.landscape;
      _minDimension = _screenHeight / 100.0;
    }
  }
}

extension DoubleToMinimumScreenBloc on num {
  // Get minimum screen bloc size
  double get sb => this * ScreenSize._minDimension;
  double get hb => this * ScreenSize.h;
  double get wb => this * ScreenSize.w;
}
