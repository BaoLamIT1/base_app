class CreateFaceResponse {
  final int code;
  final FaceData? data;
  final int messageId;
  final String message;
  final bool status;

  CreateFaceResponse({
    required this.code,
    required this.data,
    required this.messageId,
    required this.message,
    required this.status,
  });

  factory CreateFaceResponse.fromJson(Map<String, dynamic> json) {
    return CreateFaceResponse(
      code: json['code'] ?? 0,
      data: json['data'] != null ? FaceData.fromJson(json['data']) : null,
      messageId: json['message_id'] ?? 0,
      message: json['message'] ?? '',
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'data': data?.toJson(),
      'message_id': messageId,
      'message': message,
      'status': status,
    };
  }
}

class FaceData {
  final int processedImages;
  final int failedImages;
  final String employeeName;
  final String employeeCode;

  FaceData({
    required this.processedImages,
    required this.failedImages,
    required this.employeeName,
    required this.employeeCode,
  });

  factory FaceData.fromJson(Map<String, dynamic> json) {
    return FaceData(
      processedImages: json['processed_images'] ?? 0,
      failedImages: json['failed_images'] ?? 0,
      employeeName: json['employee_name'] ?? '',
      employeeCode: json['employee_code'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'processed_images': processedImages,
      'failed_images': failedImages,
      'employee_name': employeeName,
      'employee_code': employeeCode,
    };
  }
}
