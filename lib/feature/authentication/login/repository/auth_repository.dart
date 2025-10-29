import '../model/login_request_model.dart';

abstract class AuthRepository {
  Future<UserModel?> loginWithUsernamePassword(String username, String password);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}