import 'package:flutter/material.dart';

extension SizeExtension on num {
  ///[ScreenUtil.setHeight]
  SizedBox get verticalSpace => SizedBox(height: toDouble());
  SizedBox get horizontalSpace => SizedBox(width: toDouble());
}
