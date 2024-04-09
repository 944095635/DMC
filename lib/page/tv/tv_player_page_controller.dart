import 'package:dmc/model/tv/tv.dart';
import 'package:dmc/page/tv/tv_player_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class TvPlayerPageController extends GetxController {
  late Tv tv;

  AnimationController? menuController;

  // 播放器
  late final player = Player();

  // 播放控制器
  late final mediaKitController = VideoController(player);

  @override
  void onInit() {
    super.onInit();
    tv = Get.arguments;
  }

  @override
  void onClose() {
    super.onClose();
    player.dispose();
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  /// 播放TV节目
  void play(int sourceId) {
    String url = tv.source[sourceId];
    player.open(Media(url));
  }

  void showMenu() {
    //menuController?.forward();
    Get.dialog(const TvPlayerMenuPage());
  }
}
