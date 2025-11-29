part of 'login_page.dart';

Widget _buildBody(LoginController controller) {
  return SizedBox(
    child: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: Get.height,
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.06),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppDimens.radius30),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.05),
                          // Shadow color
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () => controller.changeLanguageBottomSheet(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildChangeLanguageButton(controller),
                          sdsSBWidth4,
                          UtilWidgets.buildText(
                            LocaleKeys.language_countryCode.tr,
                            fontSize: AppDimens.sizeTextSmallest,
                            textColor: AppColors.black,
                          ),
                          sdsSBWidth2,
                          const Icon(
                            Icons.arrow_drop_down_sharp,
                            size: AppDimens.sizeIcon16,
                          ),
                        ],
                      ).paddingSymmetric(
                        horizontal: AppDimens.padding8,
                        vertical: AppDimens.padding4,
                      ),
                    ),
                  ).paddingOnly(right: AppDimens.padding20),
                ),
                SizedBox(height: Get.height * 0.1),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                    left: AppDimens.padding16,
                    bottom: AppDimens.padding20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      controller.showLog();
                    },
                    child: Image.asset(
                      Assets.images.iconLogo.path,
                      fit: BoxFit.fill,
                      height: 40.h,
                    ),
                  ),
                ),
                _buildTitle(controller.fullNameOrUserName),
                sdsSBHeight10,
                _buildListInput(controller),
                sdsSBHeight10,
                _buildForgotPass(controller),
                Row(
                  children: [
                    Expanded(child: _buildLoginButton(controller)),
                    _buildBiometricButton(controller),
                  ],
                ).paddingOnly(right: AppDimens.padding16),
                const Spacer(),
                Expanded(child: _buildDevelopBy()),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildChangeLanguageButton(LoginController controller) {
  return Obx(() {
    // lấy locale hiện tại (nếu LoginController chưa có giá trị thì fallback sang Get.locale)
    String? selected =
        controller.languageCodeHome.value.isEmpty
            ? Get.locale?.languageCode
            : controller.languageCodeHome.value;
    selected = selected?.toLowerCase();

    // map languageCode -> flag (có thể tạo helper cho gọn)
    String flagPath;
    switch (selected) {
      case AppConst.languageCodeEN:
        flagPath = Assets.icons.iconLanguageEn.path;
        break;
      case AppConst.languageCodeVN:
      default:
        flagPath = Assets.icons.iconLanguageVn.path;
        break;
    }

    return Image.asset(
      flagPath,
      width: AppDimens.sizeIcon,
      height: AppDimens.sizeIcon,
    );
  });
}

Widget _buildTitle(RxString fullNameOrUserName) {
  return Obx(() {
    // Ẩn nếu đã có tên trong Hive (đã đăng nhập trước đó)
    if (fullNameOrUserName.value.isNotEmpty) {
      return const SizedBox.shrink();
    }

    // Hiển thị nếu lần đầu đăng nhập
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: AppDimens.padding16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextUtils(
              text: LocaleKeys.app_loginTitle.tr,
              availableStyle: StyleEnum.MbTitle2Bold,
              color: AppColors.basicBlack,
            ),
          ],
        ),
      ),
    );
  });
}

Widget _buildListInput(LoginController controller) {
  return Form(
    key: controller.formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildUserInfoWithChangeBtn(controller),
        sdsSBHeight15,
        _buildPassword(controller),
      ],
    ),
  ).paddingOnly(left: AppDimens.paddingSmall, right: AppDimens.paddingSmall);
}

Widget _buildUserInfoWithChangeBtn(LoginController controller) {
  return Obx(() {
    final hasAccount = controller.fullNameOrUserName.value.isNotEmpty;

    if (!hasAccount) return _buildAccount(controller);
    return Row(
      children: [
        Flexible(child: _buildHelloUsername(controller)),
        sdsSBWidth20,
        GestureDetector(
          onTap: controller.changeAccount,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.padding10),
            child: SvgPicture.asset(
              Assets.icons.iconChangeUser,
              width: AppDimens.padding15,
              height: AppDimens.padding15,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  });
}

Widget _buildAccount(LoginController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextUtils(
        text: LocaleKeys.app_accountTitle.tr,
        availableStyle: StyleEnum.NunitoInput,
        color: AppColors.basicGrey1,
      ),
      const SizedBox(height: AppDimens.padding4),
      UtilWidgets.buildInput(
        TextInputModel(
          hintText: LocaleKeys.app_enterAccountTitle.tr,
          textEditingController: controller.accountController,
          focusNode: controller.accountNode,
          maxLength: 20,
          size: 14,
          svgIconPath: Assets.icons.iconPerson,
          isValidated: true,
          onFieldSubmitted: (value) {
            controller.passwordNode.requestFocus();
          },
        ),
      ),
    ],
  );
}

Widget _buildHelloUsername(LoginController controller) {
  return TextUtils(
    text: controller.fullNameOrUserName.value,
    availableStyle: StyleEnum.MbTitle2Bold,
    color: AppColors.basicBlack,
    textAlign: TextAlign.left,
  );
}

Widget _buildPassword(LoginController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextUtils(
        text: LocaleKeys.app_passwordTitle.tr,
        availableStyle: StyleEnum.NunitoInput,
        color: AppColors.basicGrey1,
      ),
      const SizedBox(height: AppDimens.padding8),
      UtilWidgets.buildInput(
        TextInputModel(
          hintText: LocaleKeys.app_enterPasswordTitle.tr,
          textEditingController: controller.passwordController,
          focusNode: controller.passwordNode,
          isPassword: true,
          maxLength: 20,
          svgIconPath: Assets.icons.iconLock,
          isValidated: true,
          size: 14,
          onFieldSubmitted: (value) {
            controller.navToHome();
          },
        ),
      ),
    ],
  );
}

Widget _buildForgotPass(LoginController controller) {
  return Padding(
    padding: const EdgeInsets.only(left: AppDimens.padding16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            controller.routeToLoginForgotPass();
          },
          child: TextUtils(
            text: LocaleKeys.app_forgotPassword.tr,
            size: AppDimens.sizeTextSmall,
            color: AppColors.primaryColor,
            textDecoration: TextDecoration.underline,
            colorDecoration: AppColors.primaryColor,
          ),
        ),
      ],
    ).paddingOnly(right: AppDimens.paddingSmall),
  );
}

Widget _buildLoginButton(LoginController controller) {
  return Obx(
    () => BaseButton.buildButton(
      LocaleKeys.app_loginTitle.tr,
      () => controller.navToHome(),
      colors: AppColors.colorBtnPrimaryBlue,
      isLoading: controller.isShowLoading.value,
    ).paddingAll(AppDimens.paddingSmall),
  );
}

Widget _buildBiometricButton(LoginController controller) {
  if (!controller.remember ||
      controller.username == null ||
      controller.password == null ||
      !controller.rememberBiometric) {
    return const SizedBox.shrink();
  }
  return GestureDetector(
    onTap: () async {
      await controller.loginBiometric();
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.padding10),
      child: SvgPicture.asset(
        controller.store.isFaceID
            ? Assets.icons.iconFaceId
            : Assets.icons.iconFingerprint,
        width: AppDimens.padding40,
        height: AppDimens.padding40,
        colorFilter: const ColorFilter.mode(
          AppColors.primaryColor,
          BlendMode.srcIn,
        ),
      ),
    ),
  );
}

Widget _buildDevelopBy() {
  return SizedBox(
    width: Get.width,
    height: 50,
    child: Center(
      child: TextUtils(
        text: LocaleKeys.login_productOfLamBaoBao.tr,
        color: AppColors.basicBlack,
        availableStyle: StyleEnum.DBBodySub,
        textAlign: TextAlign.center,
      ),
    ).paddingOnly(bottom: AppDimens.padding15),
  );
}
