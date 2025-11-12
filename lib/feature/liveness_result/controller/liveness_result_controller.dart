import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/base/app_state_store/app_state_store.dart';
import '../../../core/base/base_controller/base_controller.dart';
import '../../../core/route/app_route.dart';
import '../../../core/utils/function/image_converter.dart';
import '../../../core/values/const.dart';
import '../../../generated/locales.g.dart';
import '../../liveness/collection/liveness_collection.dart';

class LivenessResultController extends BaseGetxController {
  final formKey = GlobalKey<FormState>();
  List<MapEntry<LivenessStep, Uint8List>> allImages = [];
  TextEditingController fullNameController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();
  TextEditingController classNameController = TextEditingController();
  final store = AppStateStore();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is List<MapEntry<LivenessStep, Uint8List>>) {
      allImages = List<MapEntry<LivenessStep, Uint8List>>.from(Get.arguments);
    }
  }

  Future<void> createFace() async {
    showLoading();
    if (allImages.isNotEmpty) {
      try {
        final converter = ImageConverter();
        final listBase64 =
            allImages
                .map((entry) => converter.convertToBase64(entry.value))
                .toList();

        // final response = await livenessRepository.createFace(
        //   CreateFaceRequest(
        //     listBase64: listBase64,
        //     employeeId: store.personalInformation?.employeeId ?? "",
        //   ),
        // );

        // if (response != null && response.code == 200) {
        showSnackBar(
          LocaleKeys.app_addFaceSuccess.tr,
          typeAction: AppConst.actionSuccess,
        );
        // store.setIsHasFace(true);
        Get.until((route) => Get.currentRoute == AppRoutes.routeHomePage);
        // } else {
        //   showSnackBar(LocaleKeys.app_addFaceFailed.tr);
        // }
      } catch (e) {
        showSnackBar(LocaleKeys.app_errorProcessingImage.tr);
      } finally {
        hideLoading();
      }
    } else {
      showSnackBar(LocaleKeys.app_noImageDataAvailable.tr);
    }
  }

  void navigateToLivenessInstruction() {
    Get.until((route) => Get.currentRoute == AppRoutes.routeInstructLiveness);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    studentIdController.dispose();
    classNameController.dispose();
    super.onClose();
  }
}
