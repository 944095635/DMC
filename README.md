# <strong>DMC 💖 </strong>

- 软件英文名字:   `damn crazy.`

- 软件中文名字:   `绝对是来捣乱的`/`他妈的疯了`

- 是否开源：暂时闭源
- 开发阶段：前期测试阶段UI未定稿
- 软件没签名，下次更新需要卸载安装，后期增加打包签名

- ## QQ群 623512997

<br></br>

<img src="https://raw.githubusercontent.com/944095635/DMC/master/phone.png" width='360'>
<img src="https://raw.githubusercontent.com/944095635/DMC/master/mac.png" >
<img src="https://raw.githubusercontent.com/944095635/DMC/master/desktop.png" >


<br></br>
#### 做这个软件的起因

- 某些人为了利益一直不放开自己的权力（让我想起以前的成都公交卡），
- 平时看电视比较多，但是电信机顶盒 和 小米电视，切换系统就要更换遥控器非常的麻烦，快速切换直播源一直是我想要的功能。
- 这个事情早晚会放开的，会有专门的电视App用来播放电视直播，所以这个程序目前只是一个过渡产品，能维持到什么时候也不确定，我甚至不知道是否合法。

<br></br>
#### 准备支持的功能:

| 功能 | 支持 | 说明 | 
| -------- | ----- | ----- |
| 电视直播     | ✅    |  CCTV + 地方电视台  |
| 手机投屏  | ⛔    |  手机选好节目推送到电视播放  |
| 局域网NAS    | ⛔    |  选择NAS资源进行播放或推送给电视播放 |

<br></br>
#### 目前支持的系统:

| 平台 | 支持 | 说明 | 下载 |
| -------- | ----- | ----- | ---- |
| Android     | ✅    | 手机 Phone 平板 Tablet 电视 TV  | [下载](https://github.com/944095635/DMC/releases) |
| iOS         | ⛔    | 暂时无法发布         |  |
| macOS       | ⛔    | 暂时无法发布         |  |
| Windows     | ✅    | Windows 7 以上的64位系统. | [下载](https://github.com/944095635/DMC/releases) / 可能需要安装C++ runtime 2015|
| GNU/Linux   | ⛔    | 暂时无法发布   |   |
| Web         | ⛔    | 暂时无法发布    |  |

<br></br>
#### 交互模式:
- 手机 触屏操作
- 电视(Android TV + MacOS TV) 遥控器
- 平板 + 电脑(Windows + MacOS + Linux) 鼠标操作

<br></br>
#### 电视遥控器操作
默认状态下
- 遥控器 左键 = 呼出电视列表
- 遥控器 右键 = 关闭电视列表
- 遥控器 返回 = 无反应，请使用Home键退出

菜单状态下
- 遥控器 左键 = 切换线路
- 遥控器 上键 = 上一个电视台
- 遥控器 下键 = 下一个电视台
- 遥控器 确认 = 播放该电视台

#### Windows操作

默认状态下
- 键盘 左键 = 呼出电视列表
- 键盘 右键 = 关闭电视列表
- 键盘 ESC = 隐藏窗口按钮/退出全屏模式
- 键盘 Space = 播放/暂停

菜单状态下
- 键盘 左键 = 切换线路
- 键盘 上键 = 上一个电视台
- 键盘 下键 = 下一个电视台
- 键盘 Enter = 播放该电视台

<br></br>
#### 资源来源:

所有的资源来自互联网分享，我无法保证资源的访问权限，访问速度，清晰度，质量等。

<br></br>
#### App 使用到的框架:
- [Flutter](https://flutter.dev/)
  
- Flutter SDK 3.13.9

- Dart SDK 3.1.5

```yaml
dependencies:
  get: ^4.6.6                          #GetX
  http: ^1.1.0                         #网络访问
  animate_do: ^3.1.2                   #动画组件
  flutter_svg: ^2.0.9                  #SVG图标
  date_format: ^2.0.7                  #日期格式
  window_manager: ^0.3.7               #窗口管理
  json_annotation: ^4.8.1              #JSON
  device_info_plus: ^9.1.0             #设备信息
  flutter_easyloading: ^3.0.5          #提示信息
  cached_network_image: ^3.3.0         #图片缓存
  media_kit: ^1.1.10+1                 #
  media_kit_video: ^1.2.4              #
  media_kit_libs_video: ^1.0.4         #
```
