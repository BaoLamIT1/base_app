
class CreateFaceRequest {
  final List<String>? listBase64;
  final String? employeeId;

  CreateFaceRequest({
    this.listBase64,
    this.employeeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'list_base64': listBase64,
      'employee_id': employeeId,
    };
  }

  factory CreateFaceRequest.fromJson(Map<String, dynamic> json) {
    return CreateFaceRequest(
    listBase64: json['list_base64'] != null
          ? List<String>.from(json['list_base64'])
          : null,
      employeeId: json['employee_id'],
    );
  }
}