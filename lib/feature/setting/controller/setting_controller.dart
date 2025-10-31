import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../core/base/app_controller/app_controller.dart';
import '../../../core/base/app_state_store/app_state_store.dart';
import '../../../core/base/base_controller/base_controller.dart';
import '../../../core/route/app_route.dart';
import '../../../core/utils/widgets/show_popup.dart';
import '../../../core/values/key.dart';
import '../../../generated/locales.g.dart';
import '../../../native_method/biometric/biometric.dart';

mixin PopScopeCtrlMixin<T> on BaseGetxController {
  bool get didPop;

  late final canPop = RxBool(didPop);

  void onPopInvoked(bool didPop, T? result);
}

class SettingController extends BaseGetxController {
  final store = AppStateStore();

  // Ngôn ngữ hiện tại.
  Rx<String> languageCodeHome = ''.obs;

  Rx<String> countryCodeHome = ''.obs;

  final remember = HIVE_APP.get(AppKey.keyRemember, defaultValue: false);

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> changeSettingBiometric(
    bool value, {
    bool isToDialog = false,
  }) async {
    if (value) {
      await Biometrics()
          .authenticate(
            onDeviceUnlockUnavailable: () {
              Fluttertoast.showToast(
                msg: LocaleKeys.biometric_msgUnavailable.tr,
                toastLength: Toast.LENGTH_LONG,
              );
            },
            onAfterLimit: () {
              Fluttertoast.showToast(
                msg: LocaleKeys.biometric_msgLimit.tr,
                toastLength: Toast.LENGTH_LONG,
              );
            },
          )
          .then((isAuthenticated) async {
            if (isAuthenticated != null && isAuthenticated) {
              store.isFingerprintOrFaceID.value = true;
              HIVE_APP.put(
                AppKey.keyRememberBiometric,
                store.isFingerprintOrFaceID.value,
              );
              store.hasBiometricChanged = false;
              store.saveStatusBiometricIOS();
            } else {
              showSnackBar(LocaleKeys.biometric_biometricFailed.tr);
            }
          });
    } else {
      store.isFingerprintOrFaceID.value = false;
      HIVE_APP.put(
        AppKey.keyRememberBiometric,
        store.isFingerprintOrFaceID.value,
      );
    }
  }

  void onTapLogout() {
    ShowPopup.showDialogConfirm(
      LocaleKeys.app_logoutTitle.tr,
      confirm: () {
        HIVE_APP.delete(AppKey.keyToken);
        // // final remember = HIVE_APP.get(AppKey.keyRemember, defaultValue: false);
        // // if (!remember) {
        // /// Nếu không remember → clear luôn account
        // HIVE_APP.delete(AppKey.keyUsername);
        // HIVE_APP.delete(AppKey.keyPass);
        // //}
        Get.offAllNamed(AppRoutes.routeLogIn);
      },
      actionTitle: LocaleKeys.app_logout,
    );
  }
}
