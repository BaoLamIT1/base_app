// repository/impl/api_auth_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../auth_repository.dart';
import '../../model/login_request_model.dart';

class ApiAuthRepository implements AuthRepository {
  final String baseUrl = 'https://your-api.com';

  @override
  Future<UserModel?> loginWithUsernamePassword(String username, String password) async {
    final request = LoginRequestModel(username: username, password: password);
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toMap()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Giả sử API trả về token + user info
      final userData = data['user'];
      return UserModel(
        id: userData['id'].toString(),
        username: userData['username'],
        fullName: userData['fullName'],
        email: userData['email'],
      );
    }
    return null;
  }

  @override
  Future<void> logout() async {
    // Gọi API logout nếu cần
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    // Gọi API get profile
    return null;
  }
}