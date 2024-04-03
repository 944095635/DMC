import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dmc/model/enum/device_type.dart';
import 'package:dmc/model/enum/view_type.dart';
import 'package:dmc/utils/device_utils.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

/// 设备选择控制器
class DeviceChosePageController extends GetxController with StateMixin {
  late Rx<ViewType> viewType;
  late Rx<DeviceType> deviceType;

  @override
  void onInit() {
    super.onInit();
    viewType = Rx(ViewType.unknow);
    deviceType = Rx(DeviceType.unknow);
    initData();
  }

  void initData() async {
    //判断当前的设备是什么类型
    if (Platform.isWindows) {
      DeviceUtils.viewType = ViewType.plus;
      DeviceUtils.deviceType = DeviceType.pc;
    } else if (Platform.isAndroid) {
      //安卓要区分 手机 / 平板 /电视
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      //bool isTV =
      //    androidInfo.systemFeatures.contains('android.software.leanback');

      // double sizeInches = androidInfo.displayMetrics.sizeInches;
      // double widthInches = androidInfo.displayMetrics.widthInches;
      if (androidInfo.displayMetrics.xDpi == 72 ||
          androidInfo.displayMetrics.yDpi == 72) {
        DeviceUtils.viewType = ViewType.phone;
        DeviceUtils.deviceType = DeviceType.phone; //模拟器
      } else if (androidInfo.displayMetrics.sizeInches < 7 &&
          !androidInfo.device.contains("emulator")) {
        DeviceUtils.viewType = ViewType.phone;
        DeviceUtils.deviceType = DeviceType.phone; //设备小于7寸 手机
      } else if (androidInfo.displayMetrics.sizeInches < 16 &&
          !androidInfo.device.contains("emulator")) {
        DeviceUtils.viewType = ViewType.plus;
        DeviceUtils.deviceType = DeviceType.tablet; //设备小于16寸 平板
      } else {
        DeviceUtils.viewType = ViewType.tv;
        DeviceUtils.deviceType = DeviceType.tv; //设备 电视 TV
      }
    }

    //赋值给当前页面
    viewType.value = DeviceUtils.viewType;
    deviceType.value = DeviceUtils.deviceType;
    change(null, status: RxStatus.success());
  }

  /// 保存
  void save() async {
    SmartDialog.showLoading(msg: "保存中..");
    SmartDialog.dismiss();
    await DeviceUtils.saveDeviceConfig(deviceType.value, viewType.value);
    SmartDialog.showToast("保存成功");
    Get.back();
  }
}
