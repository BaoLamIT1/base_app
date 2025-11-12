part of 'home_page.dart';

Widget _buildBody(HomeController controller) {
  return Padding(
    padding: const EdgeInsets.all(AppDimens.padding16),
    child: UtilWidgets.buildSmartRefresher(
      refreshController: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoadMore: controller.onLoadMore,
      enablePullDown: true,
      enablePullUp: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          _buildButtonFace(controller),
        ],
        ),
      ),
    ),
  );
}

Widget _buildButtonFace(HomeController controller) {
  return Container(
    height: 46.h,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: AppColors.colorLinearGradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          controller.navigateToLivenessInstruction();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.icons.icAddFaceid,
              height: 20,
            ),
            sdsSBWidth8,
            TextUtils(
              text: LocaleKeys.app_addFaceId.tr,
              availableStyle: StyleEnum.MbBodyBold,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    ),
  );
}