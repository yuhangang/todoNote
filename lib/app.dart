import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noname/commons/utils/lifecycle/lifecycle_manager.dart';
import 'package:noname/navigation/routes.dart';
import 'package:noname/views/home/home_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/views/intro_slider/intro_slider.dart';
import 'package:noname/views/login/login_page.dart';
import 'package:noname/state/providers/global/globalProvider.dart';

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = new GlobalKey();

class MyApp extends StatelessWidget {
  bool isFirstRun;
  MyApp({required this.isFirstRun});
  static const PageRoutes pageRoutes = PageRoutes();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CoreManager(
      child: Consumer(
          builder: (context, watch, _) {
        ThemeSetting theme = watch(GlobalProvider.themeProvider);
        Auth auth = watch(GlobalProvider.authProvider);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ));
        return MaterialApp(
          navigatorKey: Get.key,
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme.getTheme(),
          darkTheme: theme.getTheme(isSystemDarkMode: true),
          home: AudioServiceWidget(
              child: auth.isAuth
                  ? HomePage()
                  : this.isFirstRun
                      ? IntroPage()
                      : LoginPage()),
          routes: pageRoutes.routes,
        );
      } as Widget Function(
              BuildContext, T Function<T>(ProviderBase<Object?, T>), Widget?)),
    );
  }
}
