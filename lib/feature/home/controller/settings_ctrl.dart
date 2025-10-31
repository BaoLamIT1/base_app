import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../core/core.src.dart';

mixin PopScopeCtrlMixin<T> on BaseGetxController {
  bool get didPop;

  late final canPop = RxBool(didPop);

  void onPopInvoked(bool didPop, T? result);
}

class SettingsCtrl extends BaseGetxController {}
