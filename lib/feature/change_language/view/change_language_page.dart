import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/base/base_widget/base_button.dart';
import '../../../core/base/base_widget/base_widget.dart';
import '../../../core/utils/widgets/size_box.dart';
import '../../../core/utils/widgets/util_widgets.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/dimens.dart';
import '../../../generated/locales.g.dart';
import '../controller/change_language_controller.dart';

final class ChangeLanguagePage extends BaseGetWidget<ChangeLanguageController> {
  ChangeLanguagePage({super.key});

  @override
  late final ChangeLanguageController controller = Get.put(
    ChangeLanguageController(),
  );

  @override
  Widget buildWidgets(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(
          AppDimens.defaultPadding,
          0,
          AppDimens.defaultPadding,
          MediaQuery.of(Get.context!).viewInsets.bottom +
              AppDimens.defaultPadding,
        ),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                sdsSBHeight30,
                Obx(
                  () => Column(
                    children:
                        controller.items.map((e) {
                          final isSelected =
                              e['languageCode'] ==
                              controller.tempLanguageCode.value;

                          return GestureDetector(
                            onTap:
                                () => controller.selectLanguage(
                                  e['languageCode']!,
                                  e['countryCode']!,
                                ),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    e['flag']!,
                                    width: AppDimens.sizeIconMedium,
                                    height: AppDimens.sizeIconMedium,
                                  ),
                                  sdsSBWidth20,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        UtilWidgets.buildText(
                                          e['title']!,
                                          fontSize: AppDimens.sizeTextMedium,
                                          textColor:
                                              isSelected
                                                  ? AppColors.primaryColor
                                                  : AppColors.black,
                                          fontWeight:
                                              isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                        ),
                                        sdsSBHeight3,
                                        UtilWidgets.buildText(
                                          e['miniTitle']!.tr,
                                          fontSize: AppDimens.sizeTextSmall,
                                          textColor: AppColors.basicGrey,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    const Icon(
                                      Icons.check,
                                      color: AppColors.primaryColor,
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
                sdsSBHeight30,
                BaseButton.buildButton(
                  LocaleKeys.app_confirm.tr,
                  controller.confirmLanguage,
                  colors: AppColors.colorBtnPrimaryBlue,
                ),
              ],
            ),
            // Positioned(
            //   right: AppDimens.paddingZero,
            //   top: AppDimens.padding25,
            //   child: InkWell(
            //     child: const Icon(
            //       Icons.close,
            //       color: Colors.black,
            //       size: AppDimens.sizeIconMedium,
            //     ),
            //     onTap: () => Get.back(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  static Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topCenter,
          width: AppDimens.sizeDialogNotiIcon,
          height: AppDimens.padding4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.btnSmall),
            color: AppColors.basicGrey1,
          ),
        ).paddingSymmetric(vertical: AppDimens.paddingVerySmall),
        Text(
          LocaleKeys.language_language.tr,
          style: Get.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
