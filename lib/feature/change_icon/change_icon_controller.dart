import 'package:base_app/core/base/base_controller/base_controller.dart';
import 'package:base_app/core/core.src.dart';
import 'package:flutter/services.dart';

class ChangeIconController extends BaseGetxController {
  static const _channel = MethodChannel('app.icon.switcher');

  String currentIcon = 'default';
  bool isLoading = false;

  final List<AppIconItem> icons = [
    AppIconItem(
      alias: 'MainActivityAlias1',
      name: 'Biểu tượng 1',
      asset: 'assets/icons/ic_launcher_alt1.png',
    ),
    AppIconItem(
      alias: 'MainActivityCRM',
      name: 'Biểu tượng 2',
      asset: 'assets/icons/ic_logo_crm.png',
    ),
    AppIconItem(
      alias: 'MainActivityHRM',
      name: 'Biểu tượng 3',
      asset: 'assets/icons/ic_logo_hrm.png',
    ),
  ];
  Future<void> changeIcon(String alias) async {
    showLoading();
    try {
      await _channel.invokeMethod('changeIcon', {'alias': alias});
      currentIcon = alias;
      showSnackBar(
        'Đã đổi biểu tượng, quay ra màn hình chính để xem!',
        typeAction: AppConst.actionSuccess,
      );
    } catch (e) {
      showSnackBar('Đổi biểu tượng thất bại: $e');
    } finally {
      hideLoading();
    }
  }
}

class AppIconItem {
  final String alias;
  final String name;
  final String asset;

  AppIconItem({required this.alias, required this.name, required this.asset});
}
