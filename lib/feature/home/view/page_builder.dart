import 'package:base_app/core/core.src.dart';
import 'package:base_app/feature/home/home.src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../gen/assets.gen.dart';
import '../../../generated/locales.g.dart';
import '../../setting/views/setting_page.dart';

class PageBuilder extends BaseGetWidget<PageBuilderController> {
  PageBuilder({super.key});

  @override
  final PageBuilderController controller = Get.put(PageBuilderController());

  @override
  Widget buildWidgets(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: controller.canPop.value,
        onPopInvokedWithResult: controller.onPopInvoked,
        child: Scaffold(
          body: _buildBody(),
          bottomNavigationBar: _buildBottomNavigationBar(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return TabBarView(
      controller: controller.tabCtrl,
      physics: const NeverScrollableScrollPhysics(),
      children: const [HomePage(), SettingPage()],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(
      () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.pageIndex.value,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.colorGrey2,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: controller.changePage,
        items: _navBarsItems(),
      ),
    );
  }

  BottomNavigationBarItem _buildItem({
    required int index,
    required String svgPath,
    required String svgPathSelected,
    required String label,
  }) {
    final isSelected = controller.pageIndex.value == index;
    return BottomNavigationBarItem(
      label: '',
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            isSelected ? svgPathSelected : svgPath,
            width: 20.w,
            height: 20.h,
            // ignore: deprecated_member_use
          ),
          sdsSBHeight4,
          Text(
            label,
            style: TextStyle(
              fontSize: AppDimens.sizeTextSmallest,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? AppColors.primaryColor : AppColors.colorGrey2,
            ),
          ),
        ],
      ),
    );
  }

  List<BottomNavigationBarItem> _navBarsItems() => [
    _buildItem(
      index: 0,
      svgPath: Assets.icons.icHome,
      svgPathSelected: Assets.icons.icHomeBlue,
      label: LocaleKeys.app_home.tr,
    ),
    // _buildItem(
    //   index: 1,
    //   svgPath: Assets.icons.icNotification,
    //   svgPathSelected: Assets.icons.icNotificationBlue,
    //   label: LocaleKeys.app_notification.tr,
    // ),
    _buildItem(
      index: 1,
      svgPath: Assets.icons.icUser,
      svgPathSelected: Assets.icons.icUserBlue,
      label: LocaleKeys.app_individual.tr,
    ),
  ];
}
