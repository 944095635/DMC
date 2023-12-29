import 'package:dmc/page/common/tv_play_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 手机端 - 电视直播页面控制器
class PlayerPageController extends GetxController
    with TvPlayMixin, StateMixin, GetSingleTickerProviderStateMixin {
  /// Tab选项卡
  late TabController tabController;

  @override
  void changeStatus(RxStatus rxStatus) {
    change(null, status: rxStatus);
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
