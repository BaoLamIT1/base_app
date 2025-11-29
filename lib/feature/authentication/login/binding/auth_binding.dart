import 'package:get/get.dart';

import '../controller/login_controller.dart';
import '../repository/auth_repository.dart';
import '../repository/impl/firebase_auth_repository.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => FirebaseAuthRepository());
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
