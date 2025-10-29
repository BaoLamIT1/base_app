import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/core.src.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locales.g.dart';
import '../controller/login_controller.dart';

part 'login_view.dart';

class LoginPage extends BaseGetWidget {
  const LoginPage({super.key});

  @override
  LoginController get controller => Get.put(LoginController());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(body: _buildBody(controller));
  }
}
