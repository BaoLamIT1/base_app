part of 'setting_page.dart';

Widget _buildBody(SettingController controller) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(AppDimens.padding10),
      child: Column(
        children: [
          _buildSettingList(controller),
          sdsSBHeight30,
          _buildLogoutSection(controller),
        ],
      ),
    ),
  );
}

Widget _buildSettingList(SettingController controller) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppDimens.radius8),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // chỉ hiện biometric khi có remember
        if (controller.remember) ...[
          _buildListTitle(
            controller.store.isFaceID
                ? Assets.icons.iconFaceId
                : Assets.icons.iconFingerprint,
            LocaleKeys.biometric_logInByBiometric.tr,
            onTap: () {},
            trailingWidget: Obx(
              () => CupertinoSwitch(
                value: controller.store.isFingerprintOrFaceID.value,
                activeColor: AppColors.primaryColor,
                onChanged: (value) async {
                  await controller.changeSettingBiometric(value);
                },
              ),
            ),
          ),
          const Divider(),
        ],
        _buildListTitle(
          Assets.icons.iconGlobe, // icon
          LocaleKeys.language_language.tr,
          onTap: () {
            Get.bottomSheet(ChangeLanguagePage());
          },
          trailingWidget: _buildChangeLanguageTrailing(controller),
        ),
        const Divider(),
      ],
    ),
  );
}

Widget _buildLogoutSection(SettingController controller) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppDimens.radius8),
    ),
    child: _buildListTitle(
      Assets.icons.iconLogOut,
      LocaleKeys.app_logout.tr,
      onTap: () {
        controller.onTapLogout();
      },
    ),
  );
}

Widget _buildListTitle(
  String svgIcon,
  String title, {
  void Function()? onTap,
  Widget? trailingWidget,
  Color? colorIcon,
}) {
  return ListTile(
    title: TextUtils(
      text: title,
      availableStyle: StyleEnum.MbBodyBold,
      maxLine: 2,
    ),
    leading: SvgPicture.asset(
      svgIcon,
      width: AppDimens.padding30,
      height: AppDimens.padding30,
      colorFilter: ColorFilter.mode(
        colorIcon ?? AppColors.primaryColor,
        BlendMode.srcIn,
      ),
    ),
    onTap: onTap,
    trailing: trailingWidget ?? const SizedBox(),
  );
}

Widget _buildChangeLanguageTrailing(SettingController controller) {
  return Obx(() {
    // lấy locale hiện tại
    String? selected =
        controller.languageCodeHome.value.isEmpty
            ? Get.locale?.languageCode
            : controller.languageCodeHome.value;
    selected = selected?.toLowerCase();

    // chọn cờ theo ngôn ngữ
    String flagPath;
    String label;
    switch (selected) {
      case AppConst.languageCodeEN:
        flagPath = Assets.icons.iconLanguageEn.path;
        label = LocaleKeys.language_language_english.tr;
        break;
      case AppConst.languageCodeVN:
      default:
        flagPath = Assets.icons.iconLanguageVn.path;
        label = LocaleKeys.language_language_vietnamese.tr;
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          flagPath,
          width: AppDimens.sizeIconMedium,
          height: AppDimens.sizeIconMedium,
        ),
        sdsSBWidth6,
        TextUtils(text: label, availableStyle: StyleEnum.MbBodyBold),
      ],
    );
  });
}
