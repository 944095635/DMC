import 'package:dmc/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

/// 卡片按钮
class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    this.selected,
    required this.title,
    required this.icon,
    required this.color,
    required this.onSelected,
  });

  final bool? selected;
  final String icon;
  final String title;
  final Color color;
  final Function()? onSelected;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.accept ||
              event.logicalKey == LogicalKeyboardKey.select ||
              event.logicalKey == LogicalKeyboardKey.enter) {
            onSelected?.call();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Builder(
        builder: (context) {
          FocusNode node = Focus.of(context);
          return GestureDetector(
            onTap: () {
              node.requestFocus();
              onSelected?.call();
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: selected == true
                    ? const Color.fromARGB(255, 229, 248, 255)
                    : const Color(0xFFF5F6F7),
                //border: Border.all(
                //  color: selected == true ? Colors.white : Colors.white,
                //),
                boxShadow: node.hasFocus
                    ? const [
                        BoxShadow(
                          color: Color.fromARGB(255, 85, 210, 255),
                          blurRadius: 4,
                        ),
                      ]
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        color: color,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        icon,
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        title,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
