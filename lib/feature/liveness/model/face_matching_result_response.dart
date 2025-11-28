class FaceMatchingResultResponse {
  FaceMatchingResultResponse({
    this.version,
    this.sessionId,
    this.processStatus,
    this.processMessage,
    this.firstFileId,
    this.secondFileId,
    this.matchingResult,
  });

  final String? version;
  final String? sessionId;
  final String? processStatus;
  final String? processMessage;
  final String? firstFileId;
  final String? secondFileId;
  final double? matchingResult;

  factory FaceMatchingResultResponse.fromJson(Map<String, dynamic> json){
    return FaceMatchingResultResponse(
      version: json["version"],
      sessionId: json["session_id"],
      processStatus: json["process_status"],
      processMessage: json["process_message"],
      firstFileId: json["first_file_id"],
      secondFileId: json["second_file_id"],
      matchingResult: json["matching_result"],
    );
  }

  Map<String, dynamic> toJson() => {
    "version": version,
    "session_id": sessionId,
    "process_status": processStatus,
    "process_message": processMessage,
    "first_file_id": firstFileId,
    "second_file_id": secondFileId,
    "matching_result": matchingResult,
  };

}