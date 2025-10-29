import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../../model/login_request_model.dart';

class FirebaseAuthService {
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;

  Future<UserModel?> login(String username, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: username, // nếu backend dùng email làm username
      password: password,
    );

    final fb.User? firebaseUser = result.user;
    if (firebaseUser == null) return null;

    return UserModel(
      id: firebaseUser.uid,
      username: firebaseUser.email ?? '',
      fullName: firebaseUser.displayName ?? '',
      email: firebaseUser.email,
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<UserModel?> getCurrentUser() async {
    final fb.User? user = _auth.currentUser;
    if (user == null) return null;
    return UserModel(
      id: user.uid,
      username: user.email ?? '',
      fullName: user.displayName ?? '',
      email: user.email,
    );
  }
}
