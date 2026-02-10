import 'package:app_settings/app_settings.dart';
import 'package:base_app/core/utils/utils.src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../generated/locales.g.dart';
import '../../../utils/text/font_style.dart';
import '../../../values/colors.dart';
import '../../../values/dimens.dart';

class BottomSheetCheckNfc extends StatelessWidget {
  final bool isSupportNfc;

  const BottomSheetCheckNfc(this.isSupportNfc, {super.key});

  String getTitle() {
    return isSupportNfc
        ? LocaleKeys.check_nfc_title_installation_guide.tr
        : LocaleKeys.check_nfc_title_not_available.tr;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextUtils(
          text: getTitle(),
          availableStyle: StyleEnum.MbTitle2Bold,
          color: AppColors.basicGrey1,
        ),
        sdsSBHeight20,
        SvgPicture.asset(
          isSupportNfc
              ? Assets.icons.iconSupportNfc
              : Assets.icons.iconNoSupportNfc,
        ),
        sdsSBHeight20,
        Visibility(visible: isSupportNfc, child: _buildInstallationGuide()),
        Visibility(visible: !isSupportNfc, child: _buildContactSupport()),
        sdsSBHeight20,
        isSupportNfc
            ? UtilWidgets.buildButton(
              LocaleKeys.check_nfc_setting.tr,
              () {
                AppSettings.openAppSettings(type: AppSettingsType.nfc);
              },
              backgroundColor: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(AppDimens.radius4),
              height: AppDimens.sizeIcon35,
            ).paddingSymmetric(vertical: AppDimens.padding5)
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildInstallationGuide() {
    return RichText(
      text: TextSpan(
        text: LocaleKeys.check_nfc_content_installation_guide_one.tr,
        style: FontStyleUtils.fontStyleSans(color: Colors.black),
        children: [
          TextSpan(
            text: LocaleKeys.check_nfc_content_installation_guide_two.tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: LocaleKeys.check_nfc_content_installation_guide_three.tr,
          ),
          TextSpan(
            text: LocaleKeys.check_nfc_content_installation_guide_four.tr,
          ),
          TextSpan(
            text: LocaleKeys.check_nfc_content_installation_guide_five.tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  // Widget _buildBottomContactSupport() {
  //   return UtilWidgets.buildButton(
  //     LocaleKeys.check_nfc_contact.tr,
  //     () async {
  //       await UtilWidgets.launchInBrowser(
  //         LocaleKeys.check_nfc_number_hotline.tr,
  //       ).then((value) {
  //         if (Get.isBottomSheetOpen ?? false) {
  //           Get.back();
  //         }
  //       });
  //     },
  //     backgroundColor: AppColors.primaryColor,
  //     colorText: AppColors.white,
  //     borderRadius: BorderRadius.circular(AppDimens.radius4),
  //     height: AppDimens.sizeIcon35,
  //     border: Border.all(color: AppColors.primaryColor),
  //     colorOverlay: AppColors.basicGrey3,
  //   ).paddingSymmetric(vertical: AppDimens.padding16);
  // }

  Widget _buildContactSupport() {
    return RichText(
      text: TextSpan(
        text: LocaleKeys.check_nfc_not_available.tr,
        style: FontStyleUtils.fontStyleSans(color: Colors.black),
        children: [
          TextSpan(text: LocaleKeys.check_nfc_please_contact.tr),
          TextSpan(
            text: LocaleKeys.check_nfc_hotline.tr,
            style: FontStyleUtils.fontStyleSans(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: LocaleKeys.check_nfc_number_hotline.tr,
            style: FontStyleUtils.fontStyleSans(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: LocaleKeys.check_nfc_support.tr),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
