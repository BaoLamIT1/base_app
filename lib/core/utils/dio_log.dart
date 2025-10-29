import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../route/app_route.dart';

const String kTriggerShowDioLog = "DX_SHOW_LOG_EFACE";

class Diolog {
  static final Diolog _instance = Diolog._();

  Diolog._();

  factory Diolog() => _instance;

  /// show requests/responses in both 3 mode:
  /// 1. [kDebugMode]: for debug, development testing.
  /// 2. [kProfileMode]: for profiling, performance testing.
  /// 3. [kReleaseMode]: for release, beta, alpha testing. End use will use this mode.
  bool showDebug = kDebugMode || kReleaseMode || kProfileMode;

  /// Show dialog if user trigger
  Future<void> showDiolog() async {
    final bool needToShow = await _triggerCheckShowDiolog();

    if (!needToShow) return;

    // showDebugBtn(Get.context!);

    Get.toNamed(AppRoutes.routeDioLog);
  }

  Future<bool> _triggerCheckShowDiolog() async {
    final ClipboardData? cbData = await Clipboard.getData(Clipboard.kTextPlain);

    if (cbData == null || cbData.text?.isEmpty == true) {
      return false;
    }

    return _isValidClipboardData(cbData.text!);
  }

  bool _isValidClipboardData(String cbData) {
    return cbData == kTriggerShowDioLog;
  }
}
