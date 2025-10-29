import 'package:base_app/feature/authentication/login/views/login_page.dart';
import 'package:get/get.dart';

import '../../feature/splash/splash_page.dart';
import 'app_route.dart';

class PageRouter {
  static var route = [
    GetPage(name: AppRoutes.routeSplash, page: () => const SplashPage()),
    GetPage(
      name: AppRoutes.routeLogIn,
      page: () => const LoginPage(),
    ),
  ];
}
