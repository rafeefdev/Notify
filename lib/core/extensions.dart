import 'package:flutter/material.dart';

extension AppTheme on BuildContext {
  ThemeData get themeData => Theme.of(this);
  TextTheme get textTheme => themeData.textTheme;
}