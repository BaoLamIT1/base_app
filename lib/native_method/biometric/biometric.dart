import 'package:app_settings/app_settings.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

import '../../core/utils/widgets/show_popup.dart';
import '../../generated/locales.g.dart';

class Biometrics {
  factory Biometrics() => _singleton;

  Biometrics._internal();

  static final Biometrics _singleton = Biometrics._internal();

  LocalAuthentication auth = LocalAuthentication();

  Future<bool?> checkBiometrics() async {
    try {
      return await auth.canCheckBiometrics;
    } catch (_) {
      return null;
    }
  }

  Future<List<BiometricType>?> getAvailableBiometrics() async {
    try {
      return await auth.getAvailableBiometrics();
    } catch (_) {
      return null;
    }
  }

  Future<bool?> authenticate({
    String localizedReasonStr = LocaleKeys.biometric_authenticationTitle,
    Function? onDeviceUnlockUnavailable,
    Function? onAfterLimit,
  }) async {
    bool authenticated = false;
    auth = LocalAuthentication();
    try {
      authenticated = await auth.authenticate(
        authMessages: <AuthMessages>[
          IOSAuthMessages(
            cancelButton: LocaleKeys.biometric_cancelButton.tr,
            goToSettingsButton: LocaleKeys.biometric_setting.tr,
            goToSettingsDescription:
                LocaleKeys.biometric_authenticationContent.tr,
            lockOut: LocaleKeys.biometric_lockout.tr,
          ),
          AndroidAuthMessages(
            cancelButton: LocaleKeys.biometric_cancelButton.tr,
            biometricHint: LocaleKeys.biometric_authentication.tr,
            biometricNotRecognized: LocaleKeys.biometric_authenticationError.tr,
            biometricRequiredTitle: LocaleKeys.biometric_authentication.tr,
            biometricSuccess: LocaleKeys.biometric_authenticationSuccess.tr,
            goToSettingsButton: LocaleKeys.biometric_setting.tr,
            goToSettingsDescription: LocaleKeys.biometric_authentication.tr,
            signInTitle: LocaleKeys.biometric_authentication.tr,
          ),
        ],
        localizedReason: localizedReasonStr.tr,
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          sensitiveTransaction: false,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == auth_error.lockedOut) {
          if (onAfterLimit != null) onAfterLimit();
        } else if (e.code == auth_error.notEnrolled ||
            e.code == auth_error.notAvailable) {
          ShowPopup.showDialogConfirm(
            LocaleKeys.biometric_noAuthenticationError.tr,
            actionTitle: LocaleKeys.biometric_setting.tr,
            confirm: () {
              AppSettings.openAppSettings(type: AppSettingsType.security);
            },
          );
        } else if (e.code == auth_error.passcodeNotSet) {
          if (onDeviceUnlockUnavailable != null) {
            onDeviceUnlockUnavailable();
            return null;
          } else {
            authenticated = true;
          }
        }
      }

      try {
        auth.stopAuthentication();
      } catch (_) {}
    }
    return authenticated;
  }

  void cancelAuthentication() {
    auth.stopAuthentication();
  }
}
