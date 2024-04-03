import 'package:dmc/model/tv/tv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// TV 电视的首页选项
class TvHomeItem extends StatelessWidget {
  const TvHomeItem({
    super.key,
    required this.tv,
    this.onSelected,
  });

  final Function()? onSelected;

  final Tv tv;

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
                color: node.hasFocus
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
                children: [
                  if (tv.image?.isNotEmpty == true) ...{
                    Expanded(
                      child: Image.asset(tv.image!),
                    ),
                  } else ...{
                    const Spacer(),
                  },
                  Text(
                    tv.name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
