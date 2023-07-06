import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nuntium/config/constants.dart';
import 'package:nuntium/core/service/theme_service.dart';
import 'package:nuntium/features/article/presentation/controller/select_favorite_topic_controller.dart';
import 'package:nuntium/features/article/presentation/view/article_view.dart';

import 'config/dependency_injection.dart';

void main() async {
  await initModule();
  Get.put(ArticleController());
  runApp(MyApp());
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
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // onGenerateRoute: RouteGenerator.getRoute,
          // initialRoute: Routes.homeView,
          theme: _themeService.getThemeData(),
          themeMode: _themeService.getThemeMode(),
          home: const ArticleView(),
        );
      },
    );
  }
}
