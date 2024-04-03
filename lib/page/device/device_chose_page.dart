import 'package:dmc/model/enum/device_type.dart';
import 'package:dmc/model/enum/view_type.dart';
import 'package:dmc/page/device/device_chose_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// 选择设备页面
class DeviceChosePage extends GetView<DeviceChosePageController> {
  const DeviceChosePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DeviceChosePageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("选择设备类型"),
      ),
      body: controller.obx(
        (state) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text("设备类型:"),
            Row(
              children: [
                buildItem(DeviceType.phone),
                buildItem(DeviceType.tablet),
                buildItem(DeviceType.pc),
                buildItem(DeviceType.tv)
              ],
            ),
            const Text("交互类型(不建议修改):"),
            Row(
              children: [
                buildViewItem(ViewType.phone),
                buildViewItem(ViewType.plus),
                buildViewItem(ViewType.tv),
              ],
            )
          ],
        ),
      ),
    );
  }

  buildItem(DeviceType type) {
    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.accept ||
              event.logicalKey == LogicalKeyboardKey.select ||
              event.logicalKey == LogicalKeyboardKey.enter) {
            controller.deviceType.value = type;
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Builder(
        builder: (context) {
          FocusNode node = Focus.of(context);
          return Obx(
            () => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: controller.deviceType.value == type
                        ? Colors.pink
                        : Colors.grey,
                  ),
                  boxShadow: node.hasFocus
                      ? [
                          const BoxShadow(
                            color: Colors.pink,
                            blurRadius: 5,
                            blurStyle: BlurStyle.outer,
                          )
                        ]
                      : null),
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              child: Text(
                type.toString(),
              ),
            ),
          );
        },
      ),
    );
  }

  buildViewItem(ViewType type) {
    String viewName;
    switch (type) {
      case ViewType.phone:
        viewName = "触屏操作";
        break;
      case ViewType.plus:
        viewName = "鼠标操作";
        break;
      case ViewType.tv:
        viewName = "遥控器操作";
        break;
      default:
        viewName = "未知";
    }
    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.accept ||
              event.logicalKey == LogicalKeyboardKey.select ||
              event.logicalKey == LogicalKeyboardKey.enter) {
            controller.viewType.value = type;
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Builder(
        builder: (context) {
          FocusNode node = Focus.of(context);
          return Obx(
            () => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: controller.viewType.value == type
                        ? Colors.pink
                        : Colors.grey,
                  ),
                  boxShadow: node.hasFocus
                      ? [
                          const BoxShadow(
                            color: Colors.pink,
                            blurRadius: 5,
                            blurStyle: BlurStyle.outer,
                          )
                        ]
                      : null),
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              child: Text(viewName),
            ),
          );
        },
      ),
    );
  }
}
