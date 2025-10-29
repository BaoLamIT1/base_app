import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

import '../../utils/widgets/util_widgets.dart';
import '../../values/colors.dart';
import '../../values/dimens.dart';
import '../base_controller/base_controller.dart';

abstract class BaseGetWidget<T extends BaseGetxController> extends GetView<T> {
  const BaseGetWidget({super.key});

  Widget buildWidgets(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return buildWidgets(context);
  }

  Widget baseShowLoading(WidgetCallback child) {
    return Obx(
      () => controller.isShowLoading.value
          ? const Center(child: UtilWidgets.buildLoading)
          : child(),
    );
  }

  Widget buildLoadingOverlay(WidgetCallback child) {
    return Obx(
      () => Stack(
        children: [
          LoadingOverlayPro(
            progressIndicator: !GetPlatform.isMobile
                ? const CupertinoActivityIndicator(
                    radius: 50,
                  )
                : UtilWidgets.buildLoading,
            isLoading: controller.isLoadingOverlay.value,
            child: child(),
          ),
        ],
      ),
    );
  }
}

abstract class BaseWidget {
  static int oldFunc = 0;

  static Widget buildLogo(String imgLogo, double height, {double? width}) {
    return SizedBox(
      height: height,
      child: Image.asset(
        imgLogo,
        width: width ?? Get.width,
      ),
    );
  }

  static Widget buildLoading() {
    return const CupertinoActivityIndicator(
      color: AppColors.colorBlack,
    );
  }

  static Widget buildDivider(
      {double height = AppDimens.padding10,
      double thickness = 1.0,
      double indent = 0.0,
      Color? color}) {
    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: indent,
      color: color ?? AppColors.dividerColor(),
    );
  }

  static Widget baseBottomSheetNotHeight({required Widget body}) {
    return SafeArea(
      bottom: false,
      child: Container(
          padding: const EdgeInsets.only(bottom: AppDimens.padding10),
          decoration: BoxDecoration(
              color: AppColors.baseColorShimmer(),
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppDimens.sizeIcon))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              body,
            ],
          )),
    );
  }
}
