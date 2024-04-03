enum ViewType {
  /// 未知
  unknow(0),

  /// 手机 触屏操作
  phone(1),

  /// 平板 + 电脑(Windows + MacOS + Linux) 鼠标操作
  plus(2),

  /// 电视(Android TV + MacOS TV) 遥控器
  tv(3);

  final int code;
  const ViewType(this.code);
}
