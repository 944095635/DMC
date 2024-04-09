import 'package:dmc/page/tv/tv_player_page_controller.dart';
import 'package:get/get.dart';

class TvPlayerNodePageController extends GetxController with StateMixin {
  TvPlayerPageController tvPlayer = Get.find();

  @override
  void onInit() {
    super.onInit();
    value = [];
    //加载当前播放电视的节点列表
    loadData();
  }

  void loadData() {
    //找到电视播放器实例

    for (var item in tvPlayer.tv.source) {
      value.add(item);
    }
    change(value, status: RxStatus.success());
  }

  void changeNode(int index) {
    tvPlayer.play(index);
  }
}
