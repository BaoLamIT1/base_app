part of 'instruct_liveness_page.dart';

Widget _buildBody(InstructLivenessController controller) {
  return Column(
    children: [
      Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.padding16),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      Assets.images.imgIntructLiveness.path,
                      width: 227.w,
                      height: 227.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  sdsSBHeight20,
                  TextUtils(
                    text: LocaleKeys.app_LivenessGuideTitle.tr,
                    availableStyle: StyleEnum.MbTitle1Bold,
                    color: AppColors.mainBlack,
                  ),
                  sdsSBHeight16,
                  Column(
                    children: [
                      _buildItemText(LocaleKeys.app_LivenessStartHint.tr, 1),
                      const SizedBox(height: AppDimens.paddingVerySmall),
                      _buildItemText(LocaleKeys.app_LivenessStepHint.tr, 2),
                    ],
                  ),
                  sdsSBHeight16,
                  TextUtils(
                    text: LocaleKeys.app_LivenessNote.tr,
                    availableStyle: StyleEnum.MbBodyRegular,
                    color: AppColors.StatusRed(),
                    maxLine: 5,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildButton(InstructLivenessController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding16),
    child: BaseButton.buildButton(LocaleKeys.app_start.tr, () {
      controller.navigateToLiveness();
    }, colors: AppColors.colorBtnPrimaryBlue),
  );
}

Widget _buildItemText(String title, int number) {
  return Row(
    children: [
      Container(
        width: 20.w,
        height: 20.h,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: TextUtils(
          text: '$number',
          color: AppColors.white,
          availableStyle: StyleEnum.MbBodyBold11,
        ),
      ),
      sdsSBWidth12,
      Expanded(
        child: TextUtils(
          text: title,
          availableStyle: StyleEnum.MbBodyRegular,
          color: AppColors.mainBlack,
          maxLine: 4,
          textAlign: TextAlign.left,
        ),
      ),
    ],
  );
}
