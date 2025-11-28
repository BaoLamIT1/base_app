import 'package:base_app/core/core.src.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../gen/assets.gen.dart';
import '../../../generated/locales.g.dart';
import '../controller/instruct_liveness_controller.dart';

part 'instruct_liveness_view.dart';

class InstructLivenessPage extends BaseGetWidget<InstructLivenessController> {
  const InstructLivenessPage({super.key});

  @override
  InstructLivenessController get controller =>
      Get.put(InstructLivenessController());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white2,
      appBar: buildAppBar(
        titleText: LocaleKeys.app_instruct_liveness.tr,
        showActions: false,
        iconColor: AppColors.bg(),
      ),
      body: _buildBody(controller),
      bottomNavigationBar: _buildButton(
        controller,
      ).paddingOnly(bottom: AppDimens.padding10),
    );
  }
}
