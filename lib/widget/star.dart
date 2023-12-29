import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 收藏按钮
class StarWidget extends StatelessWidget {
  const StarWidget(
    this.star, {
    super.key,
    required this.onTap,
  });
  final bool star;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SvgPicture.asset(
        star ? "assets/image/star_fill.svg" : "assets/image/star.svg",
        width: 32,
        height: 32,
        colorFilter: const ColorFilter.mode(
          Colors.black,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
