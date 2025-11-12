import 'dart:convert';
import 'dart:typed_data';
class ImageConverter {

  /// Convert Uint8List sang Base64
  String convertToBase64(Uint8List imageData) {
    try {
      final base64String = base64Encode(imageData);
      return base64String;
    } catch (e) {
      throw Exception('Base64 conversion failed');
    }
  }
}