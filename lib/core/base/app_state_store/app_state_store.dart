import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../../native_method/biometric/biometric.dart';
import '../../../native_method/biometric/native_method_channel.dart';
import '../../values/key.dart';
import '../app_controller/app_controller.dart';

class AppStateStore {
  static final AppStateStore _instance = AppStateStore._internal();

  factory AppStateStore() => _instance;

  AppStateStore._internal() {
    isFingerprintOrFaceID.value = HIVE_APP.get(
      AppKey.keyRememberBiometric,
      defaultValue: false,
    );
  }

  final biometricMethodChannel = NativeMethodChannel();
  bool hasBiometricChanged = false;

  Rx<bool> isHasFace = false.obs;

  final RxBool isFingerprintOrFaceID = false.obs;

  ///có faceID không
  bool isFaceID = false;

  /// Initialize biometric change state only if biometric is enabled
  Future<void> checkBiometricChangeState() async {
    final rememberBiometric = HIVE_APP.get(
      AppKey.keyRememberBiometric,
      defaultValue: false,
    );
    if (rememberBiometric) {
      try {
        final result = await biometricMethodChannel.checkBiometricChanged();
        hasBiometricChanged = result;
      } catch (e) {
        hasBiometricChanged = false;
      }
    } else {
      hasBiometricChanged = false;
    }
  }

  /// Reset biometric state and update change status
  Future<void> resetBiometricStateAndroid() async {
    await biometricMethodChannel.resetBiometricStateAndroid();
  }

  // void setToken(TokenModel token) {
  //   _tokenModel.value = token;
  //   final encryptedToken =
  //   CryptoHelper.encrypt('Bearer ${token.accessToken ?? ""}');
  //   HIVE_APP.put(AppKey.keyToken, encryptedToken);
  //   //Logger().d("Saved encrypted accessToken: $encryptedToken");
  // }
  //
  // void clear() {
  //   _tokenModel.value = null;
  // }

  void setIsHasFace(bool isHasFaces) {
    isHasFace.value = isHasFaces;
  }

  Future<void> saveStatusBiometricIOS() async {
    await biometricMethodChannel.updateBiometricStateIOS();
  }

  Future<bool> checkBiometricsFaceIdIos() async {
    bool faceId = false;
    if (GetPlatform.isIOS) {
      String checkIos = await biometricMethodChannel.getBiometricTypeIOS();
      if (checkIos == "faceID") {
        faceId = true;
      } else {
        faceId = false;
      }
    } else {
      var biometrics = await Biometrics().getAvailableBiometrics();
      if (biometrics != null) {
        faceId = biometrics.contains(BiometricType.face);
      }
    }
    return faceId;
  }
}
