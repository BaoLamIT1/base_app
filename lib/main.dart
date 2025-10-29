import 'package:bot_toast/bot_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'core/base/app_controller/app_controller.dart';
import 'core/route/app_route.dart';
import 'core/route/page_router.dart';
import 'core/values/app_locale.dart';
import 'core/values/colors.dart';
import 'core/values/strings.dart';
import 'generated/locales.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();

  // Initialize notification service
  await _initializeNotifications();
  runApp(const Application());
}

Future<void> _initializeNotifications() async {
  // Request notification permissions first
  //await PermissionService.requestAll();
  // Initialize notification service
  //await NotificationService().init();
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _Application();
}

class _Application extends State<Application> {
  bool useSafeArea = false;

  @override
  void initState() {
    _checkAndroidSDK();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.initState();
  }

  Future<void> _checkAndroidSDK() async {
    if (GetPlatform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 35) {
        setState(() {
          useSafeArea = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget app = GetMaterialApp(
      title: AppStr.appName,
      locale: AppLocale.defaultLocale,
      supportedLocales: AppLocale.supportLocales,
      translationsKeys: AppTranslation.translations,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.routeLogIn,
      getPages: PageRouter.route,
      builder: BotToastInit(),
      localizationsDelegates: AppLocale.localizationsDelegates,
    );
    return GestureDetector(
      // onTap: KeyBoard.hide,
      child: Container(
        color: AppColors.white,
        child: useSafeArea ? SafeArea(top: false, child: app) : app,
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
