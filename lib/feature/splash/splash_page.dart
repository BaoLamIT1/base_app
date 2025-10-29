import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/base/app_controller/app_controller.dart';
import '../../core/values/colors.dart';
import '../../gen/assets.gen.dart';

class SplashPage extends GetView {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AppController(), permanent: true);
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: Center(child: SvgPicture.asset(Assets.icons.iconFaceId)),
      ),
    );
  }
}
