import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/base/base_widget/base_widget.dart';
import '../../../core/utils/text/text_utils.dart';
import '../../../core/utils/widgets/size_box.dart';
import '../../../core/utils/widgets/util_widgets.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/const.dart';
import '../../../core/values/dimens.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locales.g.dart';
import '../../change_icon/change_icon_page.dart';
import '../../change_language/view/change_language_page.dart';
import '../controller/setting_controller.dart';

part 'setting_widgets.dart';

class SettingPage extends BaseGetWidget<SettingController> {
  const SettingPage({super.key});

  @override
  SettingController get controller => Get.put(SettingController());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white2,
      appBar: buildAppBar(
        titleText: LocaleKeys.app_setting.tr,
        showActions: false,
        showIcon: false,
        iconColor: AppColors.bg(),
      ),
      body: _buildBody(controller),
    );
  }
}
