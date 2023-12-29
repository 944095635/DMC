import 'dart:io';

import 'package:dmc/extension/size_extension.dart';
import 'package:dmc/model/tv/tv.dart';
import 'package:dmc/page/tv/player_controller.dart';
import 'package:dmc/utils/pc_helper.dart';
import 'package:dmc/utils/tv_helper.dart';
import 'package:dmc/widget/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:indexed_list_view/indexed_list_view.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:window_manager/window_manager.dart';

/// Tv端 - 电视直播播放页面
class PlayerPage extends GetView<PlayerPageController> {
  const PlayerPage({super.key});

  /// 构建主体结构
  @override
  Widget build(BuildContext context) {
    Get.put(PlayerPageController());
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: Platform.isWindows
            ? PreferredSize(
                preferredSize: const Size.fromHeight(kWindowCaptionHeight),
                child: Obx(
                  () => Offstage(
                    offstage: !PcHelper.isOpenSystemCommand.value,
                    child: WindowCaption(
                      title: Text(
                        controller.currentTv.value?.name ?? "",
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      brightness: Brightness.dark,
                      //backgroundColor: Colors.black,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              )
            : null,
        extendBodyBehindAppBar: true,
        body: RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: controller.keyboardInput,
          child: Stack(
            fit: StackFit.expand,
            children: [
              buildMediaKit(showController: false),
              // Container(
              //   color: Colors.blue,
              // ),
              Obx(
                () => AnimatedPositioned(
                  right: controller.isShowMenu.value ? 20 : -220,
                  top: 20,
                  bottom: 20,
                  curve: Curves.elasticOut,
                  duration: const Duration(milliseconds: 1200),
                  child: buildFilterWidget(
                    radius: 10,
                    width: 200,
                    color: const Color(0x33FFFFFF),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    child: IndexedListView.builder(
                      controller: controller.tvListController,
                      minItemCount: 0,
                      maxItemCount: TvHelper.tvs.length - 1,
                      itemBuilder: (context, index) {
                        Tv tv = TvHelper.tvs[index];
                        return Obx(
                          () => Container(
                            constraints: const BoxConstraints(minHeight: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: index == controller.playeIndex.value
                                  ? const Color(0x33FFFFFF)
                                  : null,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (index == controller.playeIndex.value) ...{
                                  Expanded(
                                    child: Text(
                                      "${tv.name} / 节点:${tv.sourceId + 1}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                } else ...{
                                  Text(
                                    tv.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                },
                                if (tv == controller.currentTv.value) ...{
                                  SvgPicture.asset(
                                    "assets/image/frame/play.svg",
                                    width: 16,
                                    height: 16,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                }
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 列表标签
  Widget buildTvTab() {
    return CustomScrollView(
      slivers: [
        Obx(
          () => controller.currentTv.value != null
              ? SliverToBoxAdapter(
                  child: buildTvInfo(),
                )
              : const SliverToBoxAdapter(),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: Obx(
            () => buildList(),
          ),
        ),
      ],
    );
  }

  /// 当前播放的电视节目的信息 + 投屏
  Widget buildTvInfo() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 30,
        bottom: 10,
      ),
      child: Row(
        children: [
          if (controller.currentTv.value?.image != null) ...{
            CircleAvatar(
              radius: 24,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  controller.currentTv.value!.image!,
                  color: Colors.white,
                ),
              ),
            ),
            // Image.asset(
            //   controller.currentTv.value!.image!,
            //   fit: BoxFit.contain,
            // )
          },
          20.horizontalSpace,
          Obx(
            () => Text(
              controller.currentTv.value?.name ?? "",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            child: const Text("投屏"),
          )
        ],
      ),
    );
  }

  Widget buildList() {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        mainAxisExtent: 50,
        crossAxisCount: 3,
      ),
      itemCount: TvHelper.tvs.length,
      itemBuilder: (context, index) {
        return buildTvItem(TvHelper.tvs[index]);
      },
    );
  }

  Widget buildTvItem(Tv tv) {
    return GestureDetector(
      onTap: () {
        controller.play(tv);
      },
      behavior: HitTestBehavior.opaque,
      child: Obx(
        () => Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFEFEFE),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: controller.currentTv.value?.name == tv.name
                  ? Theme.of(Get.context!).colorScheme.background
                  : const Color(0xAAEEEEEE),
            ),
          ),
          child: Text(
            tv.name,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  /// 播放器主体
  /// 播放器主体
  buildMediaKit({bool showController = true}) {
    Video video = Video(
      controller: controller.mediaKitController,
    );
    if (!showController) {
      return video;
    }
    return MaterialVideoControlsTheme(
      normal: MaterialVideoControlsThemeData(
        volumeGesture: true,
        brightnessGesture: true,
        displaySeekBar: false,
        seekOnDoubleTap: false,
        buttonBarButtonSize: 32.0,
        buttonBarButtonColor: Colors.white,
        primaryButtonBar: [],
        topButtonBar: [
          MaterialCustomButton(
            icon: SvgPicture.asset(
              "assets/image/frame/back.svg",
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              Get.back();
            },
          ),
          const Spacer(),
          MaterialCustomButton(
            icon: SvgPicture.asset(
              "assets/image/ellipsis.svg",
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {},
          ),
        ],
        bottomButtonBar: [
          const MaterialDesktopPlayOrPauseButton(),
          const Spacer(),
          const MaterialFullscreenButton(),
        ],
      ),
      fullscreen: const MaterialVideoControlsThemeData(
        // Modify theme options:
        displaySeekBar: false,
        primaryButtonBar: [
          MaterialPlayOrPauseButton(
            iconSize: 48,
          )
        ],
        automaticallyImplySkipNextButton: false,
        automaticallyImplySkipPreviousButton: false,
      ),
      child: video,
    );
  }
}
