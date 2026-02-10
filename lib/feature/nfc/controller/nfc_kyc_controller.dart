import 'package:base_app/core/core.src.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/base/base_widget/bottom_sheet/base_bottom_sheet.dart';
import '../../../core/base/base_widget/bottom_sheet/bottom_sheet_check_nfc.dart';
import '../../nfc_dialog/nfc_dialog.dart';
import '../../nfc_dialog/nfc_dialog_controller.dart';
import 'check_support_nfc.dart';

class ScanNfcKycController extends BaseGetxController {
  final RxBool maybeContinue = false.obs;
  // late NfcRepository nfcRepository;
  String statusNFC = "";

  @override
  Future<void> onInit() async {
    statusNFC = await CheckSupportNfc.checkNfcAvailability();
    //nfcRepository = NfcRepository(this);
    super.onInit();
  }

  void checkAvailabilityNfc() async {
    if (statusNFC == AppConst.nfcAvailable) {
      await scanNFC();
    } else if (statusNFC == AppConst.nfcDisabled) {
      showNfcBottomSheet(true);
    } else if (statusNFC == AppConst.nfcDisabledNotSupported) {
      showNfcBottomSheet(false);
    }
  }

  void showNfcBottomSheet(bool isSupportNfc) {
    Get.bottomSheet(
      SDSBottomSheet(
        title: "",
        body: BottomSheetCheckNfc(isSupportNfc),
        noHeader: true,
      ),
      isScrollControlled: true,
    );
  }

  Future<void> funcCheckIn(Widget child) async {
    Get.dialog(child, barrierDismissible: false);
  }

  Future<void> scanNFC() async {
    if (GetPlatform.isIOS) {
      NfcDialogController nfcDialogController = Get.put(NfcDialogController());
      await nfcDialogController.scanNFC();
    } else if (GetPlatform.isAndroid) {
      ShowPopup.funcOpenDialog(const NfcDialog());
    }
  }

  // Future<void> getInfoORC() async {
  //   Get.toNamed(AppRoutes.routeAwaitOCRData);
  // }
}
