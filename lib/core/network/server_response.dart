class ServerResponse {
  dynamic data;
  bool isError;
  String message;
  int statusCode;

  ServerResponse({
    required this.data,
    required this.isError,
    required this.message,
    required this.statusCode,
  });

  @override
  String toString() {
    return '''
STATUS: $statusCode
ERROR: $isError
MESSAGE: $message
DATA: $data
''';
  }
}
