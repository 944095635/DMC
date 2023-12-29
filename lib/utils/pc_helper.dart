import 'package:get/get.dart';

/// Windows 和 MacOS 桌面专用
class PcHelper {
  static var isOpenSystemCommand = true.obs;

  static void switchSystemCommand() {
    isOpenSystemCommand.value = !isOpenSystemCommand.value;
    //开启 或者 隐藏系统窗口操作按钮
    //systemCommandCallback?.call(isOpen);
  }
}
