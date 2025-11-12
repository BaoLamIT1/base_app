// ignore_for_file: depend_on_referenced_packages
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../core/base/app_controller/app_controller.dart';
import '../../../../core/base/app_state_store/app_state_store.dart';
import '../../../../core/core.src.dart';
import '../../../../core/utils/widgets/keyboard.dart';
import '../../../../generated/locales.g.dart';
import '../../../../native_method/biometric/biometric.dart';
import '../../../../native_method/crypto/crypto_helper.dart';
import '../../../change_language/view/change_language_page.dart';
import '../model/login_request_model.dart';
import '../repository/auth_repository.dart';

class LoginController extends BaseGetxController {
  final formKey = GlobalKey<FormState>();
  final LoginRequestModel loginRequestModel = LoginRequestModel();

  final TextEditingController accountController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode accountNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  late final AuthRepository authRepository;

  // late final PersonalInformationRepository _personalRepository =
  //     PersonalInformationRepository(this);

  final store = AppStateStore();

  final biometrics = Biometrics();

  final remember = HIVE_APP.get(
    AppKey.keyRemember,
    defaultValue: true,
  ); // Always remember
  final rememberBiometric = HIVE_APP.get(
    AppKey.keyRememberBiometric,
    defaultValue: false,
  );
  final username = HIVE_APP.get(AppKey.keyUsername);
  final password = HIVE_APP.get(AppKey.keyPass);
  final RxString fullNameOrUserName = RxString(
    HIVE_APP.get(AppKey.keyFullNameOrUserName, defaultValue: ''),
  );

  // Ngôn ngữ hiện tại.
  Rx<String> languageCodeHome = ''.obs;
  Rx<String> countryCodeHome = ''.obs;

  Timer? clickTimer;
  int clickCount = 0;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    clickTimer?.cancel();
    super.onClose();
  }

  Future<void> navToHome() async {
    await loginWithUsernamePassword(
      accountController.text.trim(),
      passwordController.text.trim(),
    );
  }

  void navToHomeWithoutLogIn(){
    Get.toNamed(AppRoutes.routePageBuilder);
  }

  Future<bool> loginWithUsernamePassword(
      String userName,
      String passWord, {
        bool isAutoLogin = false,
      }) async {
    if (!isAutoLogin) {
      KeyBoard.hide();
      if (!(formKey.currentState?.validate() ?? false)) return false;
      showLoading();
    }

    try {
      final userModel = await authRepository.loginWithUsernamePassword(userName, passWord);

      if (userModel == null) {
        showSnackBar("Login failed");
        return false;
      }

      // Lưu token (nếu API trả token, với Firebase thì lấy từ FirebaseAuth)
      HIVE_APP.put(AppKey.keyToken, 'Bearer ${userModel.id}'); // hoặc lấy token thật
      HIVE_APP.put(AppKey.keyRemember, true);

      final encryptedUsername = CryptoHelper.encrypt(userName);
      final encryptedPassword = CryptoHelper.encrypt(passWord);
      HIVE_APP.put(AppKey.keyUsername, encryptedUsername);
      HIVE_APP.put(AppKey.keyPass, encryptedPassword);

      if (store.hasBiometricChanged == true) {
        await store.resetBiometricStateAndroid();
        HIVE_APP.put(AppKey.keyRememberBiometric, false);
        store.isFingerprintOrFaceID.value = false;
      }

      if (!isAutoLogin) {
        Get.offAndToNamed(AppRoutes.routeHomePage);
      }
      return true;
    } catch (e) {
      showSnackBar("Error: ${e.toString()}");
      return false;
    } finally {
      if (!isAutoLogin) hideLoading();
    }
  }
  Future<void> loginBiometric() async {
    if (!store.isFingerprintOrFaceID.value) {
      showSnackBar(LocaleKeys.biometric_biometricIsDisabled.tr);
      return;
    }

    // Khi biometrics có sự thay đổi
    if (store.hasBiometricChanged == true) {
      ShowPopup.showDialogConfirmOnly(
        LocaleKeys.biometric_biometricChanged.tr,
        actionTitle: LocaleKeys.app_close.tr,
        confirm: () {
          Get.back();
        },
      );
      return;
    }

    //  Nếu không có thay đổi, tiến hành xác thực biometric
    final isAuthenticated = await biometrics.authenticate(
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
    );
    // Nếu biometric authentication thành công thì log in
    if (isAuthenticated != null && isAuthenticated) {
      showLoading();

      if (remember && username != null && password != null) {
        final success = await loginWithUsernamePassword(
          CryptoHelper.decrypt(username),
          CryptoHelper.decrypt(password),
          isAutoLogin: true,
        );
        if (success) {
          // await fetchPersonalInfoControl();
          Get.offAllNamed(AppRoutes.routeHomePage);
          showSnackBar(
            LocaleKeys.biometric_authenticationSuccess.tr,
            typeAction: AppConst.actionSuccess,
          );
        } else {
          showSnackBar(LocaleKeys.biometric_biometricFailed.tr);
        }
      } else {
        showSnackBar(LocaleKeys.biometric_noAccountSaved.tr);
      }
      hideLoading();
    } else {
      showSnackBar(LocaleKeys.biometric_biometricFailed.tr);
    }
  }

  void showLog() {
    clickCount++;
    if (clickCount == 1) {
      clickTimer = Timer(const Duration(seconds: 2), () {
        clickCount = 0;
      });
    } else if (clickCount >= 5) {
      Diolog().showDiolog();
    }
  }

  void changeLanguage({
    required String countryCode,
    required String languageCode,
  }) {
    AppLocale.updateLocale(Locale(languageCode, countryCode));
    Get.back();
    showSnackBar(
      LocaleKeys.language_selectLanguageSuccess.tr,
      typeAction: AppConst.actionSuccess,
    );
  }

  void routeToLoginForgotPass() {
    Get.toNamed(AppRoutes.routeLoginForgotPass);
  }

  void changeAccount() {
    ShowPopup.showDialogConfirm(
      LocaleKeys.login_changeAccountConfirm.tr,
      confirm: _resetAccountData,
      actionTitle: LocaleKeys.app_confirm.tr,
    );
  }

  void _resetAccountData() {
    // Xóa dữ liệu lưu trong Hive
    HIVE_APP.delete(AppKey.keyUsername);
    HIVE_APP.delete(AppKey.keyPass);
    HIVE_APP.delete(AppKey.keyFullNameOrUserName);
    HIVE_APP.delete(AppKey.keyRememberBiometric);
    HIVE_APP.delete(AppKey.keyRemember);

    // Reset các biến trong controller
    fullNameOrUserName.value = '';
    accountController.clear();
    passwordController.clear();

    // Reset trạng thái biometric
    store.isFingerprintOrFaceID.value = false;
  }

  Future<void> changeLanguageBottomSheet() async {
    KeyBoard.hide();
    while (MediaQuery.of(Get.context!).viewInsets.bottom > 0) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    Get.bottomSheet(ChangeLanguagePage());
  }
}
