import 'package:flutter/services.dart';

class IconSwitcher {
  static const _channel = MethodChannel('app.icon.switcher');

  static Future<void> change(String aliasName) async {
    await _channel.invokeMethod('changeIcon', {'alias': aliasName});
  }
}
