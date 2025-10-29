import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../base/app_controller/app_controller.dart';
import 'const.dart';

sealed class AppLocale {
  /// English.
  static const Locale en = Locale('en', 'EN');

  /// Vietnamese.
  static const Locale vi = Locale('vi', 'VN');

  static Future<void> updateLocale(Locale locale) async {
    await Get.updateLocale(locale);
    return HIVE_APP.put(AppConst.keyLocale, '$locale');
  }

  static Locale get defaultLocale {
    // return vi;
    final deviceLocale = Get.deviceLocale;
    final internalLocale = HIVE_APP.get(
      AppConst.keyLocale,
      defaultValue: '$deviceLocale',
    );
    return supportLocales.singleWhere(
      (locale) => internalLocale == '$locale',
      orElse: () => deviceLocale ?? vi,
    );
  }

  static const List<Locale> supportLocales = [vi, en];

  static const List<LocalizationsDelegate> localizationsDelegates = [
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
