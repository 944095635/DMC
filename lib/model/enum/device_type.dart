enum DeviceType {
  /// 未知
  unknow,

  /// 平板
  tablet(),

  /// 手机
  phone,

  /// 电脑(Windows + MacOS + Linux)
  pc,

  /// 电视(Android TV + MacOS TV)
  tv;

  @override
  String toString() {
    switch (this) {
      case DeviceType.phone:
        return "手机";
      case DeviceType.pc:
        return "电脑(Windows + MacOS + Linux)";
      case DeviceType.tablet:
        return "平板";
      case DeviceType.tv:
        return "电视(暂时只支持安卓)";
      default:
        return "未知";
    }
  }
}
