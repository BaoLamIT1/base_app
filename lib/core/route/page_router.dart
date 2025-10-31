import 'package:base_app/feature/authentication/login/views/login_page.dart';
import 'package:base_app/feature/home/view/home_page.dart';
import 'package:get/get.dart';

import '../../feature/setting/views/setting_page.dart';
import '../../feature/splash/splash_page.dart';
import 'app_route.dart';

class PageRouter {
  static var route = [
    GetPage(name: AppRoutes.routeSplash, page: () => const SplashPage()),
    GetPage(name: AppRoutes.routeLogIn, page: () => const LoginPage()),
    GetPage(name: AppRoutes.routeHomePage, page: () => HomePage()),
    GetPage(name: AppRoutes.routeSettingPage, page: () => SettingPage()),
  ];
}
