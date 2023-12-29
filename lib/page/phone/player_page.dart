import 'package:dmc/extension/size_extension.dart';
import 'package:dmc/model/tv/tv.dart';
import 'package:dmc/page/phone/player_controller.dart';
import 'package:dmc/utils/device.dart';
import 'package:dmc/utils/tv_helper.dart';
import 'package:dmc/widget/star.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';

/// 手机端 - 电视直播播放页面
class PlayerPage extends GetView<PlayerPageController> {
  const PlayerPage({super.key});

  /// 构建主体结构
  @override
  Widget build(BuildContext context) {
    Get.put(PlayerPageController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: buildMediaKit(),
          ),
          Obx(
            () => controller.currentTv.value != null
                ? buildTvInfo()
                : const SizedBox(),
          ),
          const Divider(height: 1),
          Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              isScrollable: true,
              dividerHeight: 0,
              padding: const EdgeInsets.only(left: 16),
              labelPadding: const EdgeInsets.symmetric(horizontal: 20),
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.label,
              controller: controller.tabController,
              tabs: const [
                Tab(text: "直播"),
                Tab(text: "收藏"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                buildList(),
                Obx(() => buildListLike()),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 当前播放的电视节目的信息 + 投屏
  Widget buildTvInfo() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        top: 20,
        bottom: 20,
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
          10.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  controller.currentTv.value!.name,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Obx(
                () => Text(
                  "节点:${controller.currentTv.value!.sourceId + 1}",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          10.horizontalSpace,
          Obx(
            () => StarWidget(
              controller.currentTv.value!.star,
              onTap: () {
                controller.like();
              },
            ),
          ),
          const Spacer(),
          IconButton(
            icon: SvgPicture.asset(
              "assets/image/ellipsis.svg",
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              showTvSource();
            },
          ),
        ],
      ),
    );
  }

  Widget buildList() {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
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

  Widget buildListLike() {
    var list = TvHelper.tvs.where((p0) => p0.star).toList();
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        mainAxisExtent: 50,
        crossAxisCount: 3,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return buildTvItem(list[index]);
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
  buildMediaKit() {
    Video video = Video(
      controller: controller.mediaKitController,
      onExitFullscreen: () async {
        Device.setPreferredOrientations();
      },
    );
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
          // MaterialCustomButton(
          //   icon: SvgPicture.asset(
          //     "assets/image/frame/back.s1vg",
          //     colorFilter: const ColorFilter.mode(
          //       Colors.white,
          //       BlendMode.srcIn,
          //     ),
          //   ),
          //   onPressed: () {
          //     Get.back();
          //   },
          // ),
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

  /// 选择电视节点
  void showTvSource() {
    if (controller.currentTv.value != null) {
      // ElevatedButton(
      //       onPressed: () {},
      //       child: const Text("投屏"),
      //     ),
      Get.bottomSheet(
        CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    "节点列表",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            SliverList.builder(
              itemCount: controller.currentTv.value!.source.length,
              itemBuilder: (b, i) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    controller.changeSource(i);
                  },
                  child: Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        color: controller.currentTv.value!.sourceId == i
                            ? Colors.black
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            "节点:${i + 1}",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                          ),
                          20.horizontalSpace,
                          Expanded(
                            child: Text(
                              controller.currentTv.value!.source[i],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }
  }
}
