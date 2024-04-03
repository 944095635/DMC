import 'package:dmc/extension/size_extension.dart';
import 'package:dmc/model/enum/device_type.dart';
import 'package:dmc/model/enum/view_type.dart';
import 'package:dmc/page/device/device_chose_page_controller.dart';
import 'package:dmc/widget/card_button.dart';
import 'package:flutter/material.dart';
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
        actions: [
          TextButton(
            onPressed: controller.save,
            child: const Text("完成"),
          ),
          10.horizontalSpace,
        ],
      ),
      backgroundColor: const Color(0xFFFEFEFE),
      body: controller.obx(
        (state) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              "设备类型:",
              style: TextStyle(fontSize: 20),
            ),
            10.verticalSpace,
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.86,
              ),
              children: [
                Obx(
                  () => CardButton(
                    selected: controller.deviceType.value == DeviceType.phone,
                    color: const Color(0xFF235EFF),
                    title: DeviceType.phone.toString(),
                    icon: "assets/phone.svg",
                    onSelected: () {
                      controller.deviceType.value = DeviceType.phone;
                    },
                  ),
                ),
                Obx(
                  () => CardButton(
                    selected: controller.deviceType.value == DeviceType.tablet,
                    color: const Color.fromARGB(255, 241, 179, 233),
                    title: DeviceType.tablet.toString(),
                    icon: "assets/tablet.svg",
                    onSelected: () {
                      controller.deviceType.value = DeviceType.tablet;
                    },
                  ),
                ),
                Obx(
                  () => CardButton(
                    selected: controller.deviceType.value == DeviceType.pc,
                    color: const Color(0xFF8FCFEA),
                    title: DeviceType.pc.toString(),
                    icon: "assets/pc.svg",
                    onSelected: () {
                      controller.deviceType.value = DeviceType.pc;
                    },
                  ),
                ),
                Obx(
                  () => CardButton(
                    selected: controller.deviceType.value == DeviceType.tv,
                    color: const Color.fromARGB(144, 161, 30, 205),
                    title: DeviceType.tv.toString(),
                    icon: "assets/tv.svg",
                    onSelected: () {
                      controller.deviceType.value = DeviceType.tv;
                    },
                  ),
                ),
              ],
            ),
            30.verticalSpace,
            const Text(
              "交互类型(不建议修改):",
              style: TextStyle(fontSize: 20),
            ),
            10.verticalSpace,
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: [
                Obx(
                  () => CardButton(
                    selected: controller.viewType.value == ViewType.phone,
                    color: const Color(0xFF1ECD84),
                    title: "触屏",
                    icon: "assets/finger.svg",
                    onSelected: () {
                      controller.viewType.value = ViewType.phone;
                    },
                  ),
                ),
                Obx(
                  () => CardButton(
                    selected: controller.viewType.value == ViewType.plus,
                    color: const Color.fromARGB(255, 137, 161, 151),
                    title: "键鼠",
                    icon: "assets/keyboard.svg",
                    onSelected: () {
                      controller.viewType.value = ViewType.plus;
                    },
                  ),
                ),
                Obx(
                  () => CardButton(
                    selected: controller.viewType.value == ViewType.tv,
                    color: const Color.fromARGB(255, 247, 189, 132),
                    title: "遥控器",
                    icon: "assets/control.svg",
                    onSelected: () {
                      controller.viewType.value = ViewType.tv;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
