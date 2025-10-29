import 'dart:ui';

import 'package:get/get.dart';

import '../../../core/base/base_controller/base_controller.dart';
import '../../../core/values/app_locale.dart';
import '../../../core/values/const.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locales.g.dart';

class ChangeLanguageController extends BaseGetxController {
  final RxString tempLanguageCode = ''.obs;
  final RxString tempCountryCode = ''.obs;

  final List<Map<String, String>> items = [
    {
      'languageCode': AppConst.languageCodeVN,
      'countryCode': AppConst.countryCodeVN,
      'title': 'Tiếng Việt',
      'miniTitle': LocaleKeys.language_language_vietnamese.tr,
      'flag': Assets.icons.iconLanguageVn.path,
    },
    {
      'languageCode': AppConst.languageCodeEN,
      'countryCode': AppConst.countryCodeEN,
      'title': 'English',
      'miniTitle': LocaleKeys.language_language_english.tr,
      'flag': Assets.icons.iconLanguageEn.path,
    },
  ];

  @override
  void onInit() {
    super.onInit();

    final locale = Get.locale;
    tempLanguageCode.value = locale?.languageCode ?? AppConst.languageCodeVN;
    tempCountryCode.value = locale?.countryCode ?? AppConst.countryCodeVN;
  }

  void selectLanguage(String languageCode, String countryCode) {
    tempLanguageCode.value = languageCode;
    tempCountryCode.value = countryCode;
  }

  void confirmLanguage() {
    AppLocale.updateLocale(
      Locale(tempLanguageCode.value, tempCountryCode.value),
    );
    Get.back();
    showSnackBar(
      LocaleKeys.language_selectLanguageSuccess.tr,
      typeAction: AppConst.actionSuccess,
    );
  }
}
