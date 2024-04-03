import 'package:animate_do/animate_do.dart';
import 'package:dmc/model/enum/view_type.dart';
import 'package:dmc/page/device/device_chose_page.dart';
import 'package:dmc/page/phone/player_page.dart' as phone;
import 'package:dmc/page/tv/home_page.dart';
import 'package:dmc/provider/tv_provider.dart';
import 'package:dmc/utils/device_utils.dart';
import 'package:dmc/style/theme.dart';
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
    //读取保存的设备信息
    bool status = await DeviceUtils.loadDeviceConfig();
    if (!status) {
      //读取不到代表首次启动
      await Get.to(() => const DeviceChosePage());
    }

    //设置屏幕方向
    await DeviceUtils.setPreferredOrientations();

    //初始化 电视台列表
    await TvProvider.init();

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      fadeOut = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    //根据设备类型跳转不同的起始页面
    switch (DeviceUtils.viewType) {
      case ViewType.phone:
        Get.off(() => const phone.PlayerPage(), transition: Transition.fadeIn);
        break;
      case ViewType.plus:
        Get.off(() => const TvHomePage(), transition: Transition.fadeIn);
        break;
      case ViewType.tv:
        Get.offAll(() => const TvHomePage(), transition: Transition.fadeIn);
        break;
      default:
    }
  }
}
