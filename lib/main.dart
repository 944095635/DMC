import 'dart:io';
import 'package:dmc/page/splash/splash_page.dart';
import 'package:dmc/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:media_kit/media_kit.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 播放器初始化
  MediaKit.ensureInitialized();

  //Windows
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1100, 760),
      center: true,
      skipTaskbar: false,
      backgroundColor: Colors.white,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DMC',
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      theme: ThemeData(
          fontFamily: Platform.isWindows ? miFontFamily : null,
          scaffoldBackgroundColor: const Color(0xFFF8F8F8),
          cardColor: Colors.white,
          colorScheme: const ColorScheme.light(
            primary: Colors.black, //文字颜色
            secondary: Colors.white,
            onSecondary: Colors.white,

            surface: Colors.white, //表面颜色
            onSurface: Colors.black, //部分区域的文字
            surfaceTint: Colors.transparent,

            background: Colors.black,
            onBackground: Colors.white,

            //        ColorScheme ColorScheme.light({
            // Brightness brightness = Brightness.light,
            // Color primary = const Color(0xff6200ee),
            // Color onPrimary = Colors.white,
            // Color? primaryContainer,
            // Color? onPrimaryContainer,
            // Color? secondaryContainer,
            // Color? onSecondaryContainer,
            // Color? tertiary,
            // Color? onTertiary,
            // Color? tertiaryContainer,
            // Color? onTertiaryContainer,
            // Color error = const Color(0xffb00020),
            // Color onError = Colors.white,
            // Color? errorContainer,
            // Color? onErrorContainer,

            // Color? surfaceVariant,
            // Color? onSurfaceVariant,
            // Color? outline,
            // Color? outlineVariant,
            // Color? shadow,
            // Color? scrim,
            // Color? inverseSurface,
            // Color? onInverseSurface,
            // Color? inversePrimary,
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            toolbarHeight: 50,
            scrolledUnderElevation: 0,
            foregroundColor: Colors.black,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(0),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              backgroundColor: const MaterialStatePropertyAll(Colors.black),
              foregroundColor: const MaterialStatePropertyAll(Colors.white),
            ),
          ),
          bottomAppBarTheme: const BottomAppBarTheme(
            elevation: 10,
            color: Colors.white,
            shadowColor: Colors.black,
            surfaceTintColor: Colors.white,
          ),
          chipTheme: const ChipThemeData(
            elevation: 0,
            pressElevation: 0,
            surfaceTintColor: Colors.transparent,
            selectedColor: Colors.black,
            shadowColor: Colors.white,
            backgroundColor: Colors.white,
            secondaryLabelStyle: TextStyle(color: Colors.white),
            labelStyle: TextStyle(color: Colors.black),
          ),
          dividerTheme: const DividerThemeData(color: Color(0xAAEAECEB)),
          inputDecorationTheme: InputDecorationTheme(
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: Colors.white,
              shadows: [
                BoxShadow(
                  blurRadius: 0,
                  offset: const Offset(0, 0),
                  color: Colors.grey.shade100,
                )
              ],
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          )
          //extensions: const [
          //  ThemeColors.light,
          //],
          ),
      builder: EasyLoading.init(
        builder: (context, child) => GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            //await Future.delayed(const Duration(milliseconds: 300));
          },
          child: child!,
        ),
        //builder: (context, child) => MediaQuery(
        //  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        //  child: child!,
        //),
      ),
    );
  }
}
