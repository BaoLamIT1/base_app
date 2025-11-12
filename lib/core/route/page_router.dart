import 'package:base_app/feature/authentication/login/views/login_page.dart';
import 'package:base_app/feature/home/home.src.dart';
import 'package:base_app/feature/home/view/page_builder.dart';
import 'package:base_app/feature/instruct_liveness/instruct_liveness.src.dart';
import 'package:base_app/feature/liveness/views/liveness_page.dart';
import 'package:base_app/feature/liveness_result/views/liveness_result_page.dart';
import 'package:get/get.dart';

import '../../feature/setting/views/setting_page.dart';
import '../../feature/splash/splash_page.dart';
import 'app_route.dart';

class PageRouter {
  static var route = [
    GetPage(name: AppRoutes.routeSplash, page: () => const SplashPage()),
    GetPage(name: AppRoutes.routeLogIn, page: () => const LoginPage()),
    GetPage(name: AppRoutes.routePageBuilder, page: () => PageBuilder()),
    GetPage(name: AppRoutes.routeHomePage, page: () => const HomePage()),
    GetPage(name: AppRoutes.routeSettingPage, page: () => const SettingPage()),
    GetPage(
      name: AppRoutes.routeInstructLiveness,
      page: () => InstructLivenessPage(),
    ),
    GetPage(name: AppRoutes.routeLiveness, page: () => const LiveNessPage()),
    GetPage(name: AppRoutes.routeLivenessResult, page: () => const LivenessResultPage()),
  ];
}
