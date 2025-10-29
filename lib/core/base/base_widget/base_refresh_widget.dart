import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../utils/widgets/util_widgets.dart';
import '../../values/colors.dart';
import '../../values/dimens.dart';
import '../base_controller/base_refresh_controller.dart';
import 'base_widget.dart';

abstract class BaseRefreshWidget<T extends BaseRefreshGetxController>
    extends BaseGetWidget<T> {
  const BaseRefreshWidget({super.key});

  Widget buildPage(
      {PreferredSizeWidget? appBar,
      required Widget body,
      double miniumBottom = 0,
      RxBool? isShowSupportCus,
      Color? statusBarColor,
      bool isNeedUpToPage = false}) {
    // Rx<Offset> position = Offset(Get.width - 50, Get.height / 2 + 100).obs;
    // RxBool? isDraging = false.obs;

    return UtilWidgets.buildSafeArea(
      Obx(
        () => Stack(
          alignment: Alignment.bottomRight,
          children: [
            Scaffold(
              appBar: appBar,
              body: body,
              extendBody: true,
              floatingActionButton:
                  isNeedUpToPage && controller.showBackToTopButton.value
                      ? InkWell(
                          onTap: () {
                            controller.scrollControllerUpToTop.animateTo(0,
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn);
                          },
                          child: const CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              size: AppDimens.sizeIconSpinner,
                              color: AppColors.white,
                            ),
                          ),
                        )
                      : null,
            ),
          ],
        ),
      ),
      color: statusBarColor,
      miniumBottom: 0,
    );
  }
}
