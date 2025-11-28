import 'package:base_app/core/core.src.dart';
import 'package:base_app/feature/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../gen/assets.gen.dart';
import '../../../generated/locales.g.dart';

part 'home_view.dart';

class HomePage extends BaseGetWidget<HomeController> {
  const HomePage({super.key});

  @override
  HomeController get controller => Get.put(HomeController());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white2,
      appBar: buildAppBar(
        titleText: LocaleKeys.app_home.tr,
        showActions: false,
        showIcon: false,
        iconColor: AppColors.bg(),
      ),
      body: _buildBody(controller),
    );
  }
}
