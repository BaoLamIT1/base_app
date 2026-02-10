import 'package:base_app/core/utils/utils.src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../core/base/base_widget/base_widget.dart';
import '../../core/values/colors.dart';
import '../../core/values/dimens.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locales.g.dart';
import 'nfc_dialog_controller.dart';

class NfcDialog extends BaseGetWidget<NfcDialogController> {
  @override
  NfcDialogController get controller => Get.put(NfcDialogController());

  const NfcDialog({super.key});

  @override
  Widget buildWidgets(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            child: TextUtils(
              text:
                  controller.isReading.value
                      ? LocaleKeys.nfc_nfcWaitingTitle.tr
                      : LocaleKeys.nfc_dialogTitle.tr,
              availableStyle: StyleEnum.MbTitle2Bold,
              color: AppColors.basicGrey1,
            ).paddingOnly(
              top: AppDimens.padding20,
              bottom: AppDimens.padding15,
            ),
          ),
          SvgPicture.asset(Assets.icons.iconScanNfc),
          TextUtils(
            text:
                controller.isReading.value
                    ? LocaleKeys.nfc_nfcWaiting.tr
                    : LocaleKeys.nfc_dialogContent.tr,
            availableStyle: StyleEnum.MbBodyRegular,
            color: AppColors.basicBlack,
            maxLine: 3,
            textAlign: TextAlign.center,
          ).paddingAll(AppDimens.padding10),
          buildProgressBar(controller),
          UtilWidgets.buildButton(
            LocaleKeys.nfc_buttonSkip.tr,
            () async {
              await controller.closeNfc();
            },
            isLoading: controller.isShowLoading.value,
            backgroundColor: AppColors.primaryColor,
            border: Border.all(width: 1, color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(AppDimens.radius4),
            colorText: AppColors.white,
            colorOverlay: AppColors.basicGrey3,
          ).paddingAll(AppDimens.padding15),
        ],
      ).paddingOnly(bottom: AppDimens.padding10),
    );
  }

  Widget buildProgressBar(NfcDialogController controller) {
    return Visibility(
      visible: controller.isReading.value,
      child: LinearPercentIndicator(
        width: Get.width / 1.5,
        lineHeight: AppDimens.padding5,
        alignment: MainAxisAlignment.center,
        percent: controller.processQuantity.value / controller.maxProcess,
        progressColor: AppColors.primaryColor,
        barRadius: const Radius.circular(AppDimens.radius4),
      ).paddingOnly(top: AppDimens.padding4, bottom: AppDimens.padding4),
    );
  }
}
