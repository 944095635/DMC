import 'dart:convert';

import 'package:dmc/model/tv/tv.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 电视台数据提供
class TvProvider {
  /// 电视节目列表
  static RxList<Tv> tvs = RxList.empty();

  /// 获取电视节目数量
  static int get length => tvs.length;

  /// 程序初始化
  static Future init() async {
    //检查缓存中是否存在电视列表
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //如果不存在
    if (prefs.containsKey("tvs")) {
      String jsonStr = prefs.getString("tvs")!;
      var list = json.decode(jsonStr);
      //int index = 0;
      for (var item in list) {
        //if (index >= 20) {
        //  break;
        //}
        tvs.add(Tv.fromJson(item));
        //index++;
      }
    } else {
      //从配置文件中读取
      await _loadTVs();
      //将数据缓存
      await prefs.setString("tvs", json.encode(tvs));
    }
  }

  /// 缓存数据
  static Future<bool> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //将数据缓存
    return prefs.setString("tvs", json.encode(tvs));
  }

  /// 读取电视台列表
  static Future _loadTVs() async {
    String jsonStr1 = await rootBundle.loadString("assets/CCTV.json");
    String jsonStr2 = await rootBundle.loadString("assets/NOCCTV.json");
    for (var item in jsonDecode(jsonStr1)) {
      Tv tv = Tv.fromJson(item);
      tvs.add(tv);
    }
    for (var item in jsonDecode(jsonStr2)) {
      Tv tv = Tv.fromJson(item);
      tvs.add(tv);
    }
    return tvs;
  }
}
