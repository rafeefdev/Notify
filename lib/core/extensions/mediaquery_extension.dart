import 'package:flutter/material.dart';

extension MediaqueryExtension on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);
  Size get screenSize => mq.size;
  Orientation get screenOrientation => mq.orientation;
}
