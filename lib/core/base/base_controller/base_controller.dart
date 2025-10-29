import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../gen/assets.gen.dart';
import '../../core.src.dart';
import '../../values/collection.dart';

class BaseGetxController extends GetxController {
  final isShowLoading = false.obs;
  RxBool isKeyBoardShow = false.obs;
  String errorContent = '';

  /// Sử dụng một số màn bắt buộc sử dụng loading overlay
  final isLoadingOverlay = false.obs;

  void showLoading() {
    isShowLoading.value = true;
  }

  void hideLoading() {
    isShowLoading.value = false;
  }

  void showLoadingOverlay() {
    isLoadingOverlay.value = true;
  }

  void hideLoadingOverlay() {
    isLoadingOverlay.value = false;
  }

  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
    String typeAction = AppConst.actionFail,
  }) async {
    BotToast.showCustomText(
      duration: message.length > 100 ? 5.seconds : duration,
      align: Alignment.topCenter,
      toastBuilder: (cancel) {
        return Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimens.padding10,
              horizontal: AppDimens.padding12,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: AppDimens.padding5,
              vertical: AppDimens.padding10,
            ),
            decoration: BoxDecoration(
              color: AppCollection.mapColorBackgroundSnackBar[typeAction],
              border: Border.all(
                color:
                    AppCollection.mapColorBorderSnackBar[typeAction] ??
                    AppColors.statusRed,
              ),
              borderRadius: BorderRadius.circular(AppDimens.padding6),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(2, 4),
                  blurRadius: 8.1,
                  color: Colors.black.withOpacity(0.15),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppCollection.mapIconSnackBar[typeAction] ??
                            Assets.icons.iconSnackBarFail,
                      ).paddingOnly(right: AppDimens.padding8),
                      sdsSBWidth4,
                      Expanded(
                        child: TextUtils(
                          fontWeight: FontWeight.w700,
                          availableStyle: StyleEnum.MbBodyBold,
                          text: message.tr,
                          maxLine: 3,
                        ),
                      ),
                    ],
                  ),
                ),
                // if (mainButton != null) mainButton,
                InkWell(
                  onTap: cancel,
                  child: const Icon(
                    Icons.close,
                    color: AppColors.colorBlack,
                  ).paddingOnly(left: AppDimens.padding14),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
