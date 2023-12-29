import 'package:dmc/model/tv/tv.dart';
import 'package:dmc/widget/card.dart';
import 'package:flutter/material.dart';

///构建电视卡片
buildTvCard(
  Tv item, {
  Function()? onTap,
}) {
  return buildCard(
    onTap: onTap,
    child: Center(
      child: item.image != null
          ? Image.asset(
              item.image!,
              fit: BoxFit.contain,
            )
          : Center(
              child: Text(item.name),
            ),
    ),
  );
}
