class InfoOcrResponse {
  InfoOcrResponse({
    this.version,
    this.sessionId,
    required this.ocrResult,
  });

  final String? version;
  final String? sessionId;
  final List<OcrResult> ocrResult;

  factory InfoOcrResponse.fromJson(Map<String, dynamic> json) {
    return InfoOcrResponse(
      version: json["version"],
      sessionId: json["session_id"],
      ocrResult: json["ocr_result"] == null
          ? []
          : List<OcrResult>.from(
              json["ocr_result"]!.map((x) => OcrResult.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "version": version,
        "session_id": sessionId,
        "ocr_result": ocrResult.map((x) => x.toJson()).toList(),
      };
}

class OcrResult {
  OcrResult({
    this.fileId,
    this.processStatus,
    this.processMessage,
    this.docType,
    required this.data,
  });

  final String? fileId;
  final String? processStatus;
  final dynamic processMessage;
  final String? docType;
  final List<Datum> data;

  factory OcrResult.fromJson(Map<String, dynamic> json) {
    return OcrResult(
      fileId: json["file_id"],
      processStatus: json["process_status"],
      processMessage: json["process_message"],
      docType: json["doc_type"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "file_id": fileId,
        "process_status": processStatus,
        "process_message": processMessage,
        "doc_type": docType,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Datum {
  Datum({
    required this.code,
    required this.label,
    required this.text,
  });

  final String? code;
  final String? label;
  final String? text;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      code: json["code"],
      label: json["label"],
      text: json["text"],
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "label": label,
        "text": text,
      };
}
