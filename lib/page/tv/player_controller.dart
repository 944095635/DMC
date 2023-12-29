import 'package:dmc/page/common/tv_play_mixin.dart';
import 'package:dmc/utils/pc_helper.dart';
import 'package:dmc/utils/tv_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:indexed_list_view/indexed_list_view.dart';

/// TV端(电视机) - 电视直播页面控制器
class PlayerPageController extends GetxController with TvPlayMixin, StateMixin {
  // #region 基础参数
  /// 显示电视台列表
  var isShowTvListMenu = false.obs;

  /// 是否显示菜单
  var isShowMenu = false.obs;

  /// 选中的电视台
  RxInt playeIndex = 0.obs;

  /// 选中的下标(菜单上)
  RxInt selectIndex = 0.obs;

  /// TV 电视列表控制器
  late IndexedScrollController tvListController;
  // #endregion

  // #region 初始化&销毁
  @override
  void changeStatus(RxStatus rxStatus) {
    change(null, status: rxStatus);
  }

  @override
  void onInit() {
    super.onInit();
    tvListController = IndexedScrollController();
  }

  @override
  void onClose() {
    tvListController.dispose();
    super.onClose();
  }
  // #endregion

  // #region 节目选择
  /// 选择上一个节目
  void selectPrevious() {
    debugPrint("当前Index:$selectIndex,总数量:${TvHelper.length}");
    String fromIndex;
    if (selectIndex > 0) {
      fromIndex = (selectIndex.value + 1).toString();
      selectIndex.value--;
    } else {
      fromIndex = "1";
      selectIndex.value = TvHelper.length - 1; //跳到长度-1的下标
    }
    var toIndex = (selectIndex.value + 1).toString();
    debugPrint("目前是第$fromIndex个节目,跳转到$toIndex个节目");
    tvListController.jumpToIndex(selectIndex.value); //控制UI跳过去
  }

  /// 选择下一个节目
  void selectNext() {
    debugPrint("当前Index:$selectIndex,总数量:${TvHelper.length}");
    String fromIndex;
    if (selectIndex.value + 1 < TvHelper.length) {
      fromIndex = (selectIndex.value + 1).toString();
      selectIndex.value++;
    } else {
      fromIndex = TvHelper.length.toString(); //最后一个
      selectIndex.value = 0; //跳到第一个的下标
    }
    var toIndex = (selectIndex.value + 1).toString();
    debugPrint("目前是第$fromIndex个节目,跳转到$toIndex个节目");
    tvListController.jumpToIndex(selectIndex.value); //控制UI跳过去
  }
  // #endregion

  // #region 菜单 - 遥控器
  /// 按键监听
  void keyboardInput(RawKeyEvent rawKey) {
    //遥控器按下 && 安卓设备的遥控器
    if (rawKey is RawKeyDownEvent) // && value.data is RawKeyEventDataAndroid)
    {
      //var rawKey = value.data as RawKeyEventDataAndroid;
      //上19(↑) 下20(↓)  左21(←) 右22(→) 确定23(OK)
      //后退4(back) 菜单82(MENU)
      switch (rawKey.logicalKey) {
        case LogicalKeyboardKey.goBack: //BACK 4
          //按下OK的时候菜单 关闭菜单
          showTvListMenu(false);
          break;
        case LogicalKeyboardKey.arrowUp: //↑ 19
          //快速跳台 上
          break;
        case LogicalKeyboardKey.arrowDown: //↓ 20
          //快速跳台 下
          break;
        case LogicalKeyboardKey.arrowLeft: //← 21
          //后退 （直播可以后退）
          break;
        case LogicalKeyboardKey.arrowRight: //→ 22
          //快进 （直播可以快进）
          break;
        case LogicalKeyboardKey.select: //OK 23
          //按下OK的时候 打开菜单
          showTvListMenu(true);
          break;
        case LogicalKeyboardKey.contextMenu: //MENU 82
          EasyLoading.showSuccess("MENU");
          break;
      }
    }
  }
  // #endregion

  // #region 播放界面无菜单按键
  /// 没有打开任何菜单的情况下 按键
  void tempMenuKeyInput(RawKeyEvent rawKey) {
    switch (rawKey.logicalKey) {
      case LogicalKeyboardKey.goBack: //BACK 4
        //按下OK的时候菜单 关闭菜单
        showTvListMenu(false);
        break;
      case LogicalKeyboardKey.arrowUp: //↑ 19
        //快速跳台 上
        break;
      case LogicalKeyboardKey.arrowDown: //↓ 20
        //快速跳台 下
        break;
      case LogicalKeyboardKey.arrowLeft: //← 21
        //后退 （直播可以后退）
        break;
      case LogicalKeyboardKey.arrowRight: //→ 22
        //快进 （直播可以快进）
        break;
      case LogicalKeyboardKey.select: //OK 23
        //按下OK的时候 打开菜单
        showTvListMenu(true);
        break;
      case LogicalKeyboardKey.contextMenu: //MENU 82
        EasyLoading.showSuccess("MENU");
        break;
    }
  }
  // #endregion

  // #region 电视列表菜单按键
  /// 电视节目列表菜单下的按键输入
  void tvListMenuKeyInput(RawKeyEvent rawKey) {
    switch (rawKey.logicalKey) {
      case LogicalKeyboardKey.goBack: //BACK 4
        //按下OK的时候菜单 关闭菜单
        showTvListMenu(false);
        break;
      case LogicalKeyboardKey.arrowUp: //↑ 19
        selectPrevious();
        break;
      case LogicalKeyboardKey.arrowDown: //↓ 20
        selectNext();
        break;
      case LogicalKeyboardKey.arrowLeft: //← 21
        break;
      case LogicalKeyboardKey.arrowRight: //→ 22
        break;
      case LogicalKeyboardKey.select: //OK 23
        //按下OK的时候 播放选中的节目
        break;
      case LogicalKeyboardKey.contextMenu: //MENU 82
        break;
    }
  }
  // #endregion

  /// 显示 电视列表菜单
  void showTvListMenu(bool open) {
    isShowTvListMenu.value = open;
  }

  void keyboardInput2(RawKeyEvent rawKey) {
    //遥控器按下 && 安卓设备的遥控器
    if (rawKey is RawKeyDownEvent) // && value.data is RawKeyEventDataAndroid)
    {
      //var rawKey = value.data as RawKeyEventDataAndroid;
      //上19(↑) 下20(↓)  左21(←) 右22(→) 确定23(OK)
      //后退4(back) 菜单82(MENU)
      debugPrint("遥控器:$value");
      EasyLoading.showSuccess(rawKey.logicalKey.toString());

      if (isShowTvListMenu.value) {
        //打开电视列表菜单的时候 按键逻辑
        tvListMenuKeyInput(rawKey);
      } else {
        //播放界面 没有打开菜单的时候
        tempMenuKeyInput(rawKey);
      }
    }
  }

  void ok() {
    play(TvHelper.tvs[playeIndex.value]);
  }

  void showMenu({bool show = true}) {
    isShowMenu.value = show;
  }

  void keyboardInput1(RawKeyEvent value) {
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
            selectPrevious();
            break;
          case 20:
            debugPrint("遥控器：${value.data}");
            selectNext();
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
          //previous();
          break;
        case 40:
          //next();
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
