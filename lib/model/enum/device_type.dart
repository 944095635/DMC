enum DeviceType {
  /// 未知
  unknow(0),

  /// 手机
  phone(1),

  /// 平板
  tablet(2),

  /// 电脑(Windows + MacOS + Linux)
  pc(3),

  /// 电视(Android TV + MacOS TV)
  tv(4);

  final int code;
  const DeviceType(this.code);

  @override
  String toString() {
    switch (this) {
      case DeviceType.phone:
        return "手机";
      case DeviceType.pc:
        return "电脑(Windows/MacOS/Linux)";
      case DeviceType.tablet:
        return "平板";
      case DeviceType.tv:
        return "电视(AndroidTV/MacTV)";
      default:
        return "未知";
    }
  }
}
