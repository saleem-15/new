// ignore_for_file: unused_import

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nuntium/config/constants.dart';
import 'package:nuntium/config/localization/locale_settings.dart';
import 'package:nuntium/core/resorces/manager_assets.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/service/theme_service.dart';
import 'package:nuntium/core/storage/local/app_settings_shared_preferences.dart';
import 'package:nuntium/core/storage/local/hive_db.dart';
import 'package:nuntium/routes/routes.dart';

import 'config/dependency_injection.dart';

void statusAndNavigationBarSettings({
  statusBarColor = ManagerColors.transparent,
  bool isStatusBarIconWhite = false,
  Color systemNavigationBarColor = ManagerColors.white, // navigation bar color
}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusBarColor, // status bar color
      statusBarIconBrightness:
          isStatusBarIconWhite ? Brightness.light : Brightness.dark, // status bar Icons color
      systemNavigationBarColor: systemNavigationBarColor, // navigation bar color
    ),
  );
}

void main() async {
  await initModule();

  //!!!!!!!!!!! Delete app data (ONLY FOR TEST) !!!!!!!!!!!!!
  // await instance<AppSettingsSharedPreferences>().clear();
  // await MyHive.clear();

  runApp(
    EasyLocalization(
      supportedLocales: localeSettings.supportedLocales,
      path: translationPath,
      fallbackLocale: localeSettings.defaultLocale,
      startLocale: localeSettings.defaultLocale,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final ThemeService _themeService;

  MyApp({super.key}) : _themeService = ThemeService();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: const Size(
        Constants.deviceWidth,
        Constants.deviceHeight,
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: localeSettings.textDirection,
          child: GetMaterialApp(
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.splashView,
            theme: _themeService.getThemeData(),
            themeMode: _themeService.getThemeMode(),
          ),
        );
      },
    );
  }
}