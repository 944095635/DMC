/*玻璃容器*/
import 'dart:ui';
import 'package:dmc/extension/size_extension.dart';
import 'package:dmc/style/theme_colors.dart';
import 'package:flutter/material.dart';

//获取半透明的Appbar
PreferredSizeWidget buildAppBar({
  double appHeight = 80,
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
  PreferredSize? bottom,
}) {
  if (actions != null) {
    actions.add(8.horizontalSpace);
  }
  return PreferredSize(
    preferredSize: Size(0, appHeight),
    child: buildFilterWidget(
      child: AppBar(
        title: title,
        titleSpacing: leading == null ? 20 : 0,
        toolbarHeight: appHeight,
        leading: leading,
        leadingWidth: 80,
        actions: actions,
        bottom: bottom,
        //bottom: getTitle(context, "Chats"),
      ),
    ),
  );
}

Widget buildFilterWidget({
  Color? color = ThemeColor.glassColor,
  Widget? child,
  double? radius,
  double sigmaX = 12,
  double sigmaY = 12,
  double? width,
  double? height,
  EdgeInsets? padding,
}) {
  return ClipRRect(
    borderRadius:
        radius != null ? BorderRadius.circular(radius) : BorderRadius.zero,
    //背景模糊化
    child: BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: sigmaX,
        sigmaY: sigmaY,
      ),
      child: Container(
        color: color,
        width: width,
        height: height,
        padding: padding,
        child: child,
      ),
    ),
  );
}
