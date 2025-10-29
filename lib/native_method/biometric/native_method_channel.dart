import 'dart:io';

import 'package:flutter/services.dart';

import '../../core/base/app_controller/app_controller.dart';
import '../../core/core.src.dart';

class NativeMethodChannel {
  ///cách đặt tên channel hiện tại là bundle id + tên channel
  static const MethodChannel _channel = MethodChannel(
    'vn.dxtech.evision/eVision_channel',
  );

  // static const String _biometricStateKey = 'biometric_state';

  /// Kiểm tra biometric có thay đổi không
  Future<bool> checkBiometricChanged() async {
    if (Platform.isAndroid) {
      return await _checkBiometricChangedAndroid();
    } else if (Platform.isIOS) {
      return await _checkBiometricChangedIOS();
    }
    return false;
  }

  /// Android: invalidate key khi có vân tay mới
  Future<bool> _checkBiometricChangedAndroid() async {
    final bool hasChanged =
        await _channel.invokeMethod('getStatusBiometricAndroid') ?? false;
    return hasChanged;
  }

  /// iOS: dùng kiểm tra xem trạng thái biometric có thay đổi không
  Future<bool> _checkBiometricChangedIOS() async {
    bool hasBiometricChanged = false;
    final String statusIOSBase64Present =
        await _channel.invokeMethod('getStatusBiometricIOS') ?? '';
    final String statusIOSBase64Old =
        HIVE_APP.get(AppKey.saveStatusChangeIOS) ?? "";
    if (statusIOSBase64Old != statusIOSBase64Present) {
      hasBiometricChanged = true;
    }
    return hasBiometricChanged;
  }

  /// Reset biometric Android
  Future<void> resetBiometricAndroid() async {
    if (Platform.isAndroid) {
      await _channel.invokeMethod('resetBiometricAndroid');
    }
  }

  /// lưu trặng thái biometric trên iOS được gọi lúc bật biomteric vì ios
  /// trả về trạng thái hiện dạng base64 nên phaải tự lưu và kiểm tra
  Future<void> updateBiometricStateIOS() async {
    if (Platform.isIOS) {
      final String statusIOSBase64 =
          await _channel.invokeMethod('getStatusBiometricIOS') ?? '';
      if (statusIOSBase64.isNotEmpty) {
        HIVE_APP.put(AppKey.saveStatusChangeIOS, statusIOSBase64);
      }
    }
  }

  /// Reset/Update biometric state sau khi login thành công trên android
  Future<void> resetBiometricStateAndroid() async {
    if (Platform.isAndroid) {
      await resetBiometricAndroid();
    }
  }

  /// Lấy loại biometric trên iOS (Touch ID / Face ID) để hiển thị
  /// ngon với các thiết bị ios chưa bật biometric bao giờ
  Future<String> getBiometricTypeIOS() async {
    final String biometricType =
        await _channel.invokeMethod('getBiometricType') ?? '';
    return biometricType;
  }
}
