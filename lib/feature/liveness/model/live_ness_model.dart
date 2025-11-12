class SendImageResponse {
  int? status_code;
  String? status;
  String? percent;

  SendImageResponse({
    this.status_code,
    this.status,
    this.percent,
  });

  factory SendImageResponse.fromJson(Map<String, dynamic> json) =>
      SendImageResponse(
        status_code: json["status_code"],
        status: json["status"],
        percent: json["percent"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": status_code,
        "status": status,
        // "data": data?.toJson(),
        "percent": percent,
      };
}
