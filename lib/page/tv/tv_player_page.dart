import 'package:animate_do/animate_do.dart';
import 'package:dmc/page/tv/tv_player_page_controller.dart';
import 'package:dmc/style/theme_colors.dart';
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
        onKeyEvent: (rawKey) {
          if (rawKey is KeyDownEvent) {
            switch (rawKey.logicalKey) {
              case LogicalKeyboardKey.arrowUp: //↑ 19
                //显示菜单
                controller.showMenu();
                Future.delayed(Duration(seconds: 3)).then((value) => {
                      FocusManager.instance.primaryFocus?.requestFocus(),
                      debugPrint(FocusManager.instance.primaryFocus.toString()),
                    });

                break;
              case LogicalKeyboardKey.arrowDown: //↓ 20
                //隐藏菜单
                controller.hideMenu();
                break;
            }
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            buildMediaKit(showController: false),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: FadeInUp(
                controller: (p0) {
                  controller.menuController = p0;
                },
                child: buildNodes(),
              ),
            ),
          ],
        ),
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

  /// 绘制节点菜单
  buildNodes() {
    return FocusScope(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ThemeColor.glassColor,
        ),
        child: Wrap(children: [
          for (int i = 0; i < controller.tv.source.length; i++) ...{
            buildNodeItem(
              i,
              controller.tv.source[i],
              callBack: () {
                controller.play(i);
              },
            )
          }
        ]),
      ),
    );
  }

  /// 节点菜单项
  buildNodeItem(
    int index,
    String source, {
    Function()? callBack,
  }) {
    return Focus(
      autofocus: index == 0,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.accept ||
              event.logicalKey == LogicalKeyboardKey.select ||
              event.logicalKey == LogicalKeyboardKey.enter) {
            callBack?.call();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Builder(
        builder: (context) {
          FocusNode node = Focus.of(context);
          return GestureDetector(
            onTap: () {
              node.requestFocus();
              callBack?.call();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: node.hasFocus
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 105, 105, 105),
                    )
                  : null,
              child: Text(
                "节点${index + 1}",
                style: TextStyle(
                  color: node.hasFocus ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
