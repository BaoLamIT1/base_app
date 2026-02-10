part of 'nfc_page.dart';

Widget _body(ScanNfcKycController controller) {
  return SizedBox(
    height: Get.height,
    width: Get.width,
    child: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: SvgPicture.asset(Assets.icons.iconNfc)),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.bottomSheet(
                        const SDSBottomSheet(
                          title: "",
                          body: VideoScanNfcPage(),
                          noHeader: true,
                        ),
                      );
                    },
                    child: TextUtils(
                      text: LocaleKeys.nfc_nfcTutorial.tr,
                      availableStyle: StyleEnum.MbBodyBold,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                ),
                TextUtils(
                  text: LocaleKeys.nfc_instructTitle.tr,
                  availableStyle: StyleEnum.MbSubRegular,
                  color: AppColors.basicBlack,
                ).paddingOnly(
                  bottom: AppDimens.padding5,
                  top: AppDimens.padding30,
                ),
                _titleInstruct(),
              ],
            ).paddingAll(AppDimens.padding15),
          ),
        ),
        _buildButtonNfcContinue(controller),
      ],
    ),
  );
}

Widget _titleInstruct() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdsSBHeight5,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: TextUtils(
              text: LocaleKeys.update_information_kyc_Number1.tr,
              availableStyle: StyleEnum.MbBodyRegular,
              color: AppColors.basicBlack,
            ),
          ),
          Expanded(
            child: TextUtils(
              text: LocaleKeys.nfc_Step1.tr,
              size: AppDimens.sizeTextSmallTb,
              fontWeight: FontWeight.w400,
              color: AppColors.basicBlack,
              maxLine: 4,
            ),
          ),
        ],
      ),
      sdsSBHeight5,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: TextUtils(
              text: LocaleKeys.update_information_kyc_Number2.tr,
              size: AppDimens.sizeTextSmallTb,
              fontWeight: FontWeight.w400,
              color: AppColors.basicBlack,
            ),
          ),
          Expanded(
            child: TextUtils(
              text: LocaleKeys.nfc_Step2.tr,
              size: AppDimens.sizeTextSmallTb,
              fontWeight: FontWeight.w400,
              color: AppColors.basicBlack,
              maxLine: 2,
            ),
          ),
        ],
      ),
      sdsSBHeight5,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: TextUtils(
              text: LocaleKeys.update_information_kyc_Number3.tr,
              size: AppDimens.sizeTextSmallTb,
              fontWeight: FontWeight.w400,
              color: AppColors.basicBlack,
            ),
          ),
          Expanded(
            child: TextUtils(
              text: LocaleKeys.nfc_Step3.tr,
              size: AppDimens.sizeTextSmallTb,
              fontWeight: FontWeight.w400,
              color: AppColors.basicBlack,
              maxLine: 2,
            ),
          ),
        ],
      ),
    ],
  ).paddingOnly(bottom: AppDimens.padding5);
}

Widget _buildButtonNfcContinue(ScanNfcKycController controller) {
  return Column(
    children: [
      UtilWidgets.buildButton(
        LocaleKeys.nfc_buttonStart.tr,
        () {
          controller.checkAvailabilityNfc();
          // ShowDialog.funcOpenDialog(const NfcDialog());
        },
        isLoading: controller.isShowLoading.value,
        backgroundColor: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(AppDimens.radius4),
        colorText: AppColors.white,
      ).paddingAll(AppDimens.padding15),
      // Obx(
      //   () => UtilWidgets.buildButton(
      //     LocaleKeys.nfc_buttonSkip.tr,
      //     () async {
      //       await controller.getInfoORC();
      //     },
      //     isLoading: controller.isShowLoading.value,
      //     backgroundColor: AppColors.transparent,
      //     border: Border.all(width: 1, color: AppColors.primaryColor),
      //     borderRadius: BorderRadius.circular(AppDimens.radius4),
      //     colorText: AppColors.primaryColor,
      //   ).paddingAll(AppDimens.padding15),
      // ),
    ],
  );
}
