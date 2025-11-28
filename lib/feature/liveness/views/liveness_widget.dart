part of 'liveness_page.dart';

Widget bodyLive(LivenessController controller) {
  return Stack(
    children: [
      SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Transform.scale(
              scale: 1,
              child: Center(
                child:
                    controller.stepsSequence.isNotEmpty &&
                            controller.cameraIsInitialize.value
                        ? CameraPreview(controller.cameraController)
                        : const SizedBox(),
              ),
            ),
            CustomPaint(painter: CustomShapePainter()),
            _circularPercentIndicator(controller),
            // _speakerButton(controller),
            // cameraOverlay(controller, color: AppColors.bg())
          ],
        ),
      ),
      Visibility(
        visible: controller.currentStep == 0,
        child: Positioned(
          left: AppDimens.padding30,
          right: AppDimens.padding30,
          top: /*GetPlatform.isAndroid
              ? Get.height / 8
              : */
              Get.height / 8 /*Get.height / 2 + Get.height / 10 + 50*/,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 343,
                child: Text(
                  LocaleKeys.app_live_ness_action.tr,
                  style: const TextStyle(
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    // Size
                    height: 16.34 / 12,
                    letterSpacing: 0.3,
                    color: AppColors.white,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      Visibility(
        visible: controller.isFaceEmpty.value,
        child: Positioned(
          left: AppDimens.padding30,
          right: AppDimens.padding30,
          top: Get.height / 2,
          child: Container(
            color: AppColors.bgInviable(),
            child: Text(
              LocaleKeys.app_face_empty.tr,
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                // Size
                height: 16.34 / 12,
                letterSpacing: 0.3,
                color: AppColors.colorRed,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ).paddingAll(AppDimens.padding8),
          ),
        ),
      ),
      Visibility(
        visible: controller.isManyFace.value,
        child: Positioned(
          left: AppDimens.padding30,
          right: AppDimens.padding30,
          top: Get.height / 2 + (controller.isNotSmile.value ? 15 : 0),
          child: Container(
            color: AppColors.bgInviable(),
            child: Text(
              LocaleKeys.app_many_face.tr,
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 16.34 / 12,
                letterSpacing: 0.3,
                color: AppColors.colorRed,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ).paddingAll(AppDimens.padding8),
          ),
        ),
      ),
      Visibility(
        visible: controller.isNotSmile.value,
        child: Positioned(
          left: AppDimens.padding30,
          right: AppDimens.padding30,
          top: Get.height / 2 - (controller.isNotSmile.value ? 15 : 0),
          child: Container(
            color: AppColors.bgInviable(),
            child: Text(
              LocaleKeys.app_not_smile_face.tr,
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                // Size
                height: 16.34 / 12,
                letterSpacing: 0.3,
                color: AppColors.colorRed,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ).paddingAll(AppDimens.padding8),
          ),
        ),
      ),
      Visibility(
        visible: controller.currentStep.value > 0,
        child: Stack(
          children: [
            Positioned(
              left: AppDimens.padding20,
              right: AppDimens.padding20,
              top: /*GetPlatform.isAndroid
                    ? Get.height / 8
                    : */
                  Get.height / 8 /*Get.height / 2 + Get.height / 10 + 50*/,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.app_live_ness_action1.tr,
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      // Size
                      height: 16.34 / 12,
                      letterSpacing: 0.3,
                      color: AppColors.white,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center, // Align
                  ),
                  // _buildListStep(controller),
                ],
              ),
            ),
            Positioned(
              left: AppDimens.padding10,
              right: AppDimens.padding10,
              top: Get.height / 1.45,
              child: Column(
                children: [
                  if (controller.currentStep.value <=
                          controller.stepsSequence.length &&
                      controller.currentStep.value > 0)
                    Column(
                      children: [
                        const SizedBox(height: AppDimens.sizeIconSpinner),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: AppDimens.sizeIconSpinner),
                            SvgPicture.asset(
                              LivenessCollection.questionsIconAction[controller
                                      .stepsSequence[controller
                                          .currentStep
                                          .value -
                                      1]] ??
                                  '',
                            ),
                            const SizedBox(width: AppDimens.sizeIconSpinner),
                          ],
                        ),
                        const SizedBox(height: AppDimens.sizeIcon),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      controller.currentStep.value == 0 ||
                              controller.currentStep.value >
                                  controller.stepsSequence.length
                          ? controller.currentStep.value >
                                  controller.stepsSequence.length
                              ? const SizedBox()
                              : Text(
                                LocaleKeys.app_startFace.tr,
                                maxLines: 2,
                                style: TextStyle(
                                  color: AppColors.selectJob(),
                                  fontSize: AppDimens.sizeTextMediumTb,
                                  fontFamily: 'Open Sans',
                                  height: 16.34 / 12,
                                  letterSpacing: 0.3,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.center,
                              )
                          : controller.isShowResult.value
                          ? Text(
                            LocaleKeys.app_successFace.tr,
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: AppDimens.sizeTextMediumTb,
                              fontFamily: 'Open Sans',
                              height: 16.34 / 12,
                              letterSpacing: 0.3,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none,
                            ),
                          )
                          : Text(
                            LivenessCollection.questionsAction[controller
                                    .stepsSequence[controller
                                        .currentStep
                                        .value -
                                    1]] ??
                                '',
                            style: TextStyle(
                              color: AppColors.selectJob(),
                              fontSize: AppDimens.sizeTextMediumTb,
                              fontFamily: 'Open Sans',
                              height: 16.34 / 12,
                              letterSpacing: 0.3,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none,
                            ),
                          ),
                    ],
                  ).paddingOnly(bottom: AppDimens.padding5),
                ],
              ),
            ),
          ],
        ),
      ),
      // if (controller.imageTemp.value != null)
      //   Container(
      //     height: Get.height,
      //     width: Get.width,
      //     color: AppColors.black,
      //   ),
      // if (controller.imageTemp.value != null)
      //   Positioned(
      //     left: 25,
      //     right: 25,
      //     top: Get.height / 3.3 - Get.height / 6,
      //     child: Screenshot(
      //       controller: controller.screenshotControllerResult,
      //       child: SizedBox(
      //         width: Get.size.width - 50,
      //         height: Get.size.height / 2,
      //         child: ClipRect(
      //           child: OverflowBox(
      //             maxWidth: Get.size.width - AppConst.paddingLeftRightLiveNess,
      //             maxHeight: Get.size.height - AppConst.paddingTopBotLiveNess,
      //             child: FractionalTranslation(
      //               translation: Offset(
      //                   AppConst.offsetLiveNessX, AppConst.offsetLiveNessY),
      //               child: Container(
      //                 decoration: BoxDecoration(
      //                   border: Border.all(
      //                     color: Colors.black, // Màu của border
      //                     width: 20.0, // Độ dày của border
      //                   ),
      //                 ),
      //                 child: Image.memory(
      //                   controller.imageTemp.value!,
      //                   // fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      Positioned(
        left: AppDimens.padding10,
        right: AppDimens.padding10,
        bottom: AppDimens.padding5,
        child: Visibility(
          visible: controller.currentStep == 0,
          child: _buildButton(controller),
        ),
      ),
      Positioned(
        left: AppDimens.padding10,
        right: AppDimens.padding10,
        top: 0,
        child: Align(
          alignment: Alignment.topCenter,
          child: AppBar(
            leading: IconButton(
              onPressed: () async {
                Get.back();
                await controller.closePros();
              },
              icon: const Icon(Icons.arrow_back_ios, size: 16),
            ),
            backgroundColor: Colors.transparent,
            iconTheme: Get.theme.iconTheme.copyWith(color: AppColors.bg()),
            elevation: 0,
            title: Text(
              LocaleKeys.app_profileFaceID.tr,
              style: TextStyle(
                color: AppColors.bg(),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
          ),
        ) /*Container(
          alignment: Alignment.topLeft,
          child: TextButton(
            onPressed: () {
              controller.onClose();
              Get.back();
            },
            child: buildBaseText(LocaleKeys.app_cancel.tr,
                fontSize: AppDimens.fontExtraLarge,
                fontWeight: FontWeight.w600,
                textColor: AppColors.bgDisable()),
          ),
        ),*/,
      ),
    ],
  );
}

Widget _buildButton(LivenessController controller) {
  return BaseButton.buildButton(
    LocaleKeys.app_start.tr,
    () async {
      controller.startStreamPicture();
    },
    colors: AppColors.colorBtnPrimaryBlue,
    textStyle: const TextStyle(
      color: AppColors.white,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  ).paddingOnly(
    left: AppDimens.paddingSmall,
    right: AppDimens.paddingSmall,
    bottom: AppDimens.paddingSmall,
  );
}

CircularPercentIndicator _circularPercentIndicator(
  LivenessController controller,
) {
  return CircularPercentIndicator(
    radius: Get.size.width / 2 - AppDimens.paddingMedium,
    lineWidth: AppDimens.padding3,
    percent:
        controller.currentStep.value <= 1
            ? 0
            : (controller.currentStep.value - 1) /
                controller.stepsSequence.length,
    backgroundColor: AppColors.transparent,
    progressColor: AppColors.colorBoderLiveNess(),
  );
}
