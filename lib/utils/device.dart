import 'dart:convert';

import 'package:dmc/model/enum/device_type.dart';
import 'package:dmc/model/enum/view_type.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceUtils {
  /// 当前设备的类型
  static DeviceType deviceType = DeviceType.unknow;

  /// 当前设备的类型
  static ViewType viewType = ViewType.unknow;

  /// 是否是手机
  static bool get isPhone => deviceType == DeviceType.phone;

  /// 是否是电视机
  static bool get isTv => deviceType == DeviceType.tv;

  /// 是否是大视图（Pad + TV + PC）
  static bool get isPlus => deviceType != DeviceType.phone;

  static Future setPreferredOrientations() async {
    if (isPhone) {
      await SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
      );
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else if (isTv) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
      ]);
    }
  }

  /// 读取保存的设备信息
  static Future<bool> loadDeviceSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var deviceTypeJson = prefs.getString("DeviceType");
    var viewTypeJson = prefs.getString("ViewType");

    if (deviceTypeJson != null && viewTypeJson != null) {
      deviceType = json.decode(deviceTypeJson);
      viewType = json.decode(viewTypeJson);
      return true;
    }
    return false;
  }

  // SystemChrome.setEnabledSystemUIMode(
  //           SystemUiMode.immersiveSticky,
  //           overlays: [],
  //         ),
  //         SystemChrome.setPreferredOrientations(
  //           [
  //             DeviceOrientation.landscapeLeft,
  //             DeviceOrientation.landscapeRight,
  //           ],
  //         ),

  //if (Device.isPhone) {
  //  SystemChrome.setPreferredOrientations([
  //    DeviceOrientation.portraitUp,
  //    DeviceOrientation.portraitDown,
  //  ]);
  //}
  //if (Device.deviceType == DeviceType.tablet) {
  //  SystemChrome.setPreferredOrientations([
  //    DeviceOrientation.landscapeLeft,
  //    DeviceOrientation.landscapeRight,
  //  ]);
  //}
}
