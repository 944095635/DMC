import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dmc/model/enum/view_type.dart';
import 'package:dmc/page/phone/player_page.dart' as phone;
import 'package:dmc/page/tv/player_page.dart' as tv;
import 'package:dmc/utils/device.dart';
import 'package:dmc/model/enum/device_type.dart';
import 'package:dmc/style/theme.dart';
import 'package:dmc/utils/tv_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  bool fadeOut = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FadeInUp(
          child: FadeOutUp(
            animate: fadeOut,
            child: Text(
              "DMC PRO",
              style: TextStyle(
                fontFamily: slantFontFamily,
                fontSize: 80,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void init() async {
    //判断当前的设备是什么类型
    if (Platform.isWindows) {
      Device.viewType = ViewType.plus;
      Device.deviceType = DeviceType.pc;
    } else if (Platform.isAndroid) {
      //安卓要区分 手机 / 平板 /电视
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      // double sizeInches = androidInfo.displayMetrics.sizeInches;
      // double widthInches = androidInfo.displayMetrics.widthInches;
      if (androidInfo.displayMetrics.xDpi == 72 ||
          androidInfo.displayMetrics.yDpi == 72) {
        Device.viewType = ViewType.phone;
        Device.deviceType = DeviceType.phone; //模拟器
      } else if (androidInfo.displayMetrics.sizeInches < 7) {
        Device.viewType = ViewType.phone;
        Device.deviceType = DeviceType.phone; //设备小于7寸 手机
      } else if (androidInfo.displayMetrics.sizeInches < 16) {
        Device.viewType = ViewType.plus;
        Device.deviceType = DeviceType.tablet; //设备小于16寸 平板
      } else {
        Device.viewType = ViewType.tv;
        Device.deviceType = DeviceType.tv; //设备 电视 TV
      }
    }

    //设置屏幕方向
    await Device.setPreferredOrientations();

    //初始化 电视台列表
    await TvHelper.init();

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      fadeOut = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    //根据设备类型跳转不同的起始页面
    switch (Device.viewType) {
      case ViewType.phone:
        Get.off(() => const phone.PlayerPage(), transition: Transition.fadeIn);
        break;
      case ViewType.plus:
        Get.off(() => const tv.PlayerPage(), transition: Transition.fadeIn);
        break;
      case ViewType.tv:
        Get.off(() => const tv.PlayerPage(), transition: Transition.fadeIn);
        break;
      default:
    }
  }
}
