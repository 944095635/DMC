import 'package:dmc/page/common/tv_play_mixin.dart';
import 'package:dmc/utils/pc_helper.dart';
import 'package:dmc/utils/tv_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:indexed_list_view/indexed_list_view.dart';

/// TV端 - 电视直播页面控制器
class PlayerPageController extends GetxController with TvPlayMixin, StateMixin {
  /// Tab选项卡
  late TabController tabController;

  @override
  void changeStatus(RxStatus rxStatus) {
    change(null, status: rxStatus);
  }

  @override
  void onInit() {
    super.onInit();
    tvController = IndexedScrollController();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  late IndexedScrollController tvController;

  /// 是否显示菜单
  var isShowMenu = false.obs;

  

  Uint8List? s;
  void take() async {
    s = await player.screenshot();
  }

  RxInt playeIndex = 0.obs;
  void previous() {
    if (playeIndex > 0) {
      playeIndex.value--;
      debugPrint("当前播放的电视台下标:$playeIndex,总数量:${TvHelper.tvs.length}");
      tvController.jumpToIndex(playeIndex.value);
    }
  }

  void next() {
    if (playeIndex.value + 1 < TvHelper.tvs.length) {
      playeIndex.value++;
      debugPrint("当前播放的电视台下标:$playeIndex,总数量:${TvHelper.tvs.length}");
      tvController.jumpToIndex(playeIndex.value);
    }
  }

  void ok() {
    play(TvHelper.tvs[playeIndex.value]);
  }

  void showMenu({bool show = true}) {
    isShowMenu.value = show;
  }

  void keyboardInput(RawKeyEvent value) {
    //debugPrint("遥控器：${value.data}");
    if (value.data is RawKeyEventDataAndroid) {
      var key = value.data as RawKeyEventDataAndroid;
      if (key.flags == 520) {
        //上19 下20 左21 右22 // 8是遥控器按下，520是遥控器 弹起
        switch (key.keyCode) {
          case 4: //返回键
            debugPrint("遥控器：${value.data}");
            showMenu(show: false);
            break;
          case 19: //↑
            debugPrint("遥控器：${value.data}");
            previous();
            break;
          case 20:
            debugPrint("遥控器：${value.data}");
            next();
            break;
          case 21:
            left();
            break;
          case 22: //→
            debugPrint("遥控器：${value.data}");
            showMenu(show: false);
            break;
          case 23:
            debugPrint("遥控器：${value.data}");
            ok();
            break;
          case 82: //系统菜单 - 切换节点
            debugPrint("遥控器：${value.data}");
            showMenu();
            break;
          default:
        }
      }
    } else if (value is RawKeyDownEvent &&
        value.data is RawKeyEventDataWindows) {
      var key = value.data as RawKeyEventDataWindows;
      //功能
      debugPrint("遥控器：${key.keyCode}");
      //左键 弹出菜单

      //左 37 上38 右 39 下40
      switch (key.keyCode) {
        case 27:
          PcHelper.switchSystemCommand();
          break;
        case 13:
          ok();
          break;
        case 37:
          left();
          break;
        case 39:
          showMenu(show: false);
          break;
        case 38:
          previous();
          break;
        case 40:
          next();
          break;
        default:
      }
    }
  }

  void left() {
    //如果菜单已经被打开，切换节点
    if (isShowMenu.value) {
      if (currentTv.value != null) {
        if (currentTv.value!.sourceId + 1 < currentTv.value!.source.length) {
          currentTv.value!.sourceId++;
        } else {
          currentTv.value!.sourceId = 0;
        }
        debugPrint(
            "节点:${currentTv.value!.sourceId}/${currentTv.value!.source.length}");
        ok();
        TvHelper.save();
        TvHelper.tvs.refresh();
      }
    } else {
      showMenu();
    }
  }

  void right() {}
}
