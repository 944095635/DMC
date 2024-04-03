import 'package:dmc/model/tv/tv.dart';
import 'package:dmc/provider/tv_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

/// Tv播放页的共用逻辑
mixin TvPlayMixin on GetxController {
  // 播放器
  late final player = Player();

  // 播放控制器
  late final mediaKitController = VideoController(player);

  /// 当前播放的电视台
  Rxn<Tv> currentTv = Rxn();

  /// 更改视图状态
  void changeStatus(RxStatus rxStatus);

  @override
  void onInit() {
    super.onInit();
    debugPrint("Player 创建..");
  }

  @override
  void onClose() {
    debugPrint("Player 销毁..");
    player.dispose();
    super.onClose();
  }

  /// 播放TV节目
  void play(Tv tv) {
    currentTv.value = tv;
    String url = tv.source[tv.sourceId];
    player.open(Media(url));
  }

  /// 修改播放节点
  void changeSource(int i) {
    currentTv.value!.sourceId = i;
    currentTv.refresh();
    play(currentTv.value!);
    TvProvider.save();
  }

  void like() {
    currentTv.value!.star = !currentTv.value!.star;
    currentTv.refresh();
    TvProvider.tvs.refresh();
    TvProvider.save();
  }

  /// 暂停TV节目
  void pause() {
    player.pause();
  }
}
