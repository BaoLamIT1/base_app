import 'package:base_app/core/core.src.dart';
import 'package:base_app/feature/nfc/views/video_scan_nfc_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/base/base_widget/bottom_sheet/base_bottom_sheet.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locales.g.dart';
import '../controller/nfc_kyc_controller.dart';

part 'nfc_view.dart';

class ScanNfcKycPage extends BaseGetWidget<ScanNfcKycController> {
  const ScanNfcKycPage({super.key});

  @override
  ScanNfcKycController get controller => Get.put(ScanNfcKycController());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        titleText: LocaleKeys.update_information_kyc_registerCa.tr,
      ),
      body: _body(controller),
    );
  }
}
