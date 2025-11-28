import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../../generated/locales.g.dart';
import '../../route/app_route.dart';
import '../app_state_store/app_state_store.dart';

late Box HIVE_APP;

class AppController extends GetxController {
  final state = AppStateStore();

  @override
  Future<void> onInit() async {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    ).then((_) => Get.offAllNamed(AppRoutes.routeLogIn));
    // await initHive();
    // state.isFaceID = await state.checkBiometricsFaceIdIos();
    //
    // // Get.put(BaseConnectAPI(), permanent: true);
    //
    // final token = HIVE_APP.get(AppKey.keyToken);
    // final remember = HIVE_APP.get(AppKey.keyRemember, defaultValue: false);
    // final rememberBiometric = HIVE_APP.get(
    //   AppKey.keyRememberBiometric,
    //   defaultValue: false,
    // );
    // final username = HIVE_APP.get(AppKey.keyUsername);
    // final password = HIVE_APP.get(AppKey.keyPass);
    //
    // // AppInitType initType;
    //
    // await state.checkBiometricChangeState();
    //
    // if (rememberBiometric == true && state.hasBiometricChanged) {
    //   Get.offAllNamed(AppRoutes.routeLogIn);
    //   ShowPopup.showDialogConfirmOnly(
    //     LocaleKeys.biometric_biometricChanged.tr,
    //     actionTitle: LocaleKeys.app_close.tr,
    //     confirm: () {
    //       Get.back();
    //     },
    //   );
    //   return;
    // }
  }

  void _handleLoginFailed() {
    Get.offAllNamed(AppRoutes.routeLogIn);
  }

  //   @override
  //   void onClose() {
  //     super.onClose();
  //     // webSocketService.disconnect();
  //   }
}

Future<void> initHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  HIVE_APP = await Hive.openBox(LocaleKeys.app_name.tr);
}
