import 'package:dmc/page/tv/tv_player_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';

class TvPlayerPage extends GetView<TvPlayerPageController> {
  const TvPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TvPlayerPageController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: KeyboardListener(
        focusNode: FocusNode(canRequestFocus: false),
        onKeyEvent: (event) {
          if (event is KeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.accept ||
                event.logicalKey == LogicalKeyboardKey.select ||
                event.logicalKey == LogicalKeyboardKey.enter) {
              controller.showMenu();
            }
          }
        },
        child: buildMediaKit(showController: false),
      ),
    );
  }

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
