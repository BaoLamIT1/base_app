import 'dart:typed_data';

import 'package:base_app/core/core.src.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../gen/assets.gen.dart';
import '../../../generated/locales.g.dart';
import '../../liveness/collection/liveness_collection.dart';
import '../controller/liveness_result_controller.dart';

part 'liveness_result_view.dart';

class LivenessResultPage extends BaseGetWidget<LivenessResultController> {
  const LivenessResultPage({super.key});

  @override
  LivenessResultController get controller =>
      Get.put(LivenessResultController());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white2,
      appBar: buildAppBar(
        titleText: LocaleKeys.app_complete_identification.tr,
        showActions: false,
        iconColor: AppColors.bg(),
      ),
      body: _buildBody(controller),
      bottomNavigationBar: _buildFooter(controller).paddingOnly(
        left: AppDimens.padding15,
        right: AppDimens.padding15,
        bottom: AppDimens.padding10,
      ),
    );
  }
}
