import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

class CryptoHelper {
  static const _key = 'v6s3pYmVhSePbK+G(D?A/x8u5r2nXjUg'; // 32 bytes cho AES-256
  static final Key _secretKey = Key.fromUtf8(_key);

  /// Mã hoá AES-GCM
  /// Mã hoá AES-GCM
  static String encrypt(String plainText) {
    if (plainText.isEmpty) return "";
    try {
      // Random IV (12 bytes cho GCM)
      final rnd = Random.secure();
      final ivBytes = Uint8List.fromList(
        List<int>.generate(12, (_) => rnd.nextInt(256)),
      );
      final iv = IV(ivBytes);

      final encrypter = Encrypter(AES(_secretKey, mode: AESMode.gcm));
      final encrypted = encrypter.encrypt(plainText, iv: iv);

      // Ghép IV + cipherText -> base64
      final combined = iv.bytes + encrypted.bytes;
      return base64Encode(combined);
    } catch (e) {
      return "";
    }
  }

  /// Giải mã AES-GCM
  static String decrypt(String encryptedText) {
    if (encryptedText.isEmpty) return "";
    try {
      final combined = base64Decode(encryptedText);

      // Tách IV (12 bytes đầu) + dữ liệu mã hoá
      final iv = IV(Uint8List.fromList(combined.sublist(0, 12)));
      final cipherText = combined.sublist(12);

      final encrypter = Encrypter(AES(_secretKey, mode: AESMode.gcm));
      return encrypter.decrypt(Encrypted(cipherText), iv: iv);
    } catch (e) {
      return "";
    }
  }

}
