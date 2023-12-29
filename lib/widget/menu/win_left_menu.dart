import 'package:flutter/material.dart';

/// PC和平板 左侧菜单
class WinLeftMenu extends StatelessWidget {
  const WinLeftMenu(
    this.text, {
    super.key,
    required this.selected,
    this.fontSize,
    this.onPressed,
  });

  final String text;

  final bool selected;

  final Function()? onPressed;

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: AnimatedPhysicalModel(
        shape: BoxShape.rectangle,
        elevation: selected ? 3 : 0,
        borderRadius: BorderRadius.circular(6),
        color: selected ? Theme.of(context).colorScheme.background : Colors.transparent,
        shadowColor: selected
            ? const Color.fromARGB(145, 138, 146, 166)
            : Colors.transparent,
        duration: const Duration(milliseconds: 300),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: selected
                  ? Theme.of(context).colorScheme.onPrimary
                  : const Color(0xFF707070),
            ),
          ),
        ),
      ),
    );
  }
}
