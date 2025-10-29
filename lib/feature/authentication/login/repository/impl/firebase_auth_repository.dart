import 'package:base_app/feature/authentication/login/repository/service/firebase_auth_service.dart';

import '../../model/login_request_model.dart';
import '../auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuthService _service = FirebaseAuthService();

  @override
  Future<UserModel?> loginWithUsernamePassword(
    String username,
    String password,
  ) async {
    return await _service.login(username, password);
  }

  @override
  Future<void> logout() async {
    await _service.logout();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return await _service.getCurrentUser();
  }
}
