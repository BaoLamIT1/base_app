import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/base/app_state_store/app_state_store.dart';
import '../../../core/base/base_controller/base_refresh_controller.dart';
import '../../../core/route/app_route.dart';

class HomeController extends BaseRefreshGetxController {
  final store = AppStateStore();


  void navigateToLivenessInstruction() {
    Get.toNamed(AppRoutes.routeInstructLiveness);
  }

  @override
  Future<void> onLoadMore() async {
    refreshController.loadComplete();
  }

  @override
  Future<void> onRefresh() async {
    refreshController.refreshCompleted();
  }
}
