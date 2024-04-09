import 'package:dmc/extension/size_extension.dart';
import 'package:dmc/page/tv/tv_player_node_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// 播放菜单页面
class TvPlayerMenuPage extends StatefulWidget {
  const TvPlayerMenuPage({super.key});

  @override
  State<TvPlayerMenuPage> createState() => _TvPlayerMenuPageState();
}

class _TvPlayerMenuPageState extends State<TvPlayerMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: () async {
          if (Get.nestedKey(1)!.currentState?.canPop() == true) {
            Get.back(id: 1);
            return false;
          }
          return true;
        },
        child: SizedBox.expand(
          child: Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 300,
              child: Navigator(
                key: Get.nestedKey(1),
                initialRoute: "/",
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) {
                      return buildMenu();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 菜单列表
  Widget buildMenu() {
    return Padding(
      padding: const EdgeInsets.only(top: 60, right: 60),
      child: ListView(
        children: [
          buildButton("电视节目列表", Icons.playlist_play),
          12.verticalSpace,
          buildButton("电视节点", Icons.power_input, id: 1),
          12.verticalSpace,
          buildButton("添加到收藏夹", Icons.playlist_play),
          12.verticalSpace,
          buildButton("电视收藏夹", Icons.library_add_check_rounded),
          12.verticalSpace,
          buildButton("分享", Icons.share),
          12.verticalSpace,
          buildButton("设置", Icons.settings),
          12.verticalSpace,
        ],
        //itemBuilder: (context, index) {
        //  return buildButton(index.toString());
        //},
        //separatorBuilder: (BuildContext context, int index) {
        //  return 12.verticalSpace;
        //},
        //itemCount: 20,
      ),
    );
  }

  Widget buildButton(
    String title,
    IconData icon, {
    int id = 0,
  }) {
    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.accept ||
              event.logicalKey == LogicalKeyboardKey.select ||
              event.logicalKey == LogicalKeyboardKey.enter) {
            if (id == 1) {
              Get.to(() => const TvPlayerNodePage(), id: 1,transition: Transition.rightToLeft);
              return KeyEventResult.handled;
            }
          }
        }
        return KeyEventResult.ignored;
      },
      //;
      child: Builder(
        builder: (context) {
          FocusNode node = Focus.of(context);
          return Center(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: node.hasFocus
                    ? const Color(0xFFE3E3E3)
                    : const Color(0xFF262728),
                borderRadius: BorderRadius.circular( 10),
              ),
              width: node.hasFocus ? 300 : 200,
              height: node.hasFocus ? 50 : 48,
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: node.hasFocus
                        ? const Color(0xFF303030)
                        : const Color(0xFFE3E3E3),
                  ),
                  12.horizontalSpace,
                  Text(
                    title,
                    style: TextStyle(
                      color: node.hasFocus
                          ? const Color(0xFF303030)
                          : const Color(0xFFE3E3E3),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
