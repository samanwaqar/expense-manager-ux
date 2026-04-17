class ApiError {
  final String errorCode;
  final String message;

  ApiError({
    required this.errorCode,
    required this.message,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      errorCode: json["code"] ?? "UNKNOWN",   //  FIX HERE
      message: json["message"] ?? "",
    );
  }
}
