import 'package:get/get.dart';

import '../../../core/base/base_controller/base_controller.dart';
import '../../../core/route/app_route.dart';

class InstructLivenessController extends BaseGetxController {
  void navigateToLiveness() {
    Get.toNamed(AppRoutes.routeLiveness);
  }
}
