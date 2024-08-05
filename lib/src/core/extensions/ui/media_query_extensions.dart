import 'package:flutter/material.dart';

extension MediaQueryExtesion on BuildContext {
  double get getHeight => MediaQuery.sizeOf(this).height;

  double get getWidth => MediaQuery.sizeOf(this).width;

  double get getTopPadding => MediaQuery.paddingOf(this).top;

  double get getBottomPadding => MediaQuery.paddingOf(this).bottom;
}
