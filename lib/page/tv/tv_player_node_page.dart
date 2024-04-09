import 'package:dmc/page/tv/tv_player_node_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// 电视节点选择
class TvPlayerNodePage extends GetView<TvPlayerNodePageController> {
  const TvPlayerNodePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TvPlayerNodePageController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: const EdgeInsets.only(top: 60, right: 60, bottom: 60),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1F20),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 48,
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      child: const SizedBox(
                        width: 48,
                        height: 48,
                        child: Icon(
                          Icons.arrow_back,
                          color: Color(0xFFC4C7C5),
                        ),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "节点",
                      style: TextStyle(
                        color: Color(0xFFC4C7C5),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              color: Color(0xFF444746),
              height: 1,
            ),
            Expanded(
              child: controller.obx(
                (state) => ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    return buildMenuItem(index);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 菜单
  Widget buildMenuItem(int index) {
    int id = index++;
    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.accept ||
              event.logicalKey == LogicalKeyboardKey.select ||
              event.logicalKey == LogicalKeyboardKey.enter) {
            controller.changeNode(index);
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Builder(
        builder: (context) {
          FocusNode node = Focus.of(context);
          return Center(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: node.hasFocus ? const Color(0xFFE3E3E3) : null,
                borderRadius: BorderRadius.circular(node.hasFocus ? 10 : 8),
              ),
              width: node.hasFocus ? 300 : 268,
              height: node.hasFocus ? 50 : 48,
              child: Text(
                "节点$id",
                style: TextStyle(
                  color: node.hasFocus
                      ? const Color(0xFF303030)
                      : const Color(0xFFE3E3E3),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
