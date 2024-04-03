import 'package:dmc/model/tv/tv.dart';
import 'package:dmc/page/tv/home_item.dart';
import 'package:dmc/page/tv/tv_player_page.dart';
import 'package:dmc/provider/tv_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 电视上面的电视列表
class TvHomePage extends StatelessWidget {
  const TvHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      backgroundColor: const Color(0xFFFEFEFE),
      body: GridView.builder(
        itemCount: TvProvider.tvs.length,
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 160,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.86,
        ),
        itemBuilder: (context, index) {
          Tv tv = TvProvider.tvs[index];
          return TvHomeItem(
            tv: tv,
            onSelected: () {
              Get.to(() => const TvPlayerPage(), arguments: tv);
            },
          );
        },
      ),
    );
  }
}
