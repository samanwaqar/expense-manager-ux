import '../enum/http_methods.dart';


class RequestAttr {
  final String url;
  final HttpMethod method;
  final Map<String, dynamic> body;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> queryParams;

  RequestAttr({
    required this.url,
    required this.method,
    this.body = const {},
    this.headers = const {},
    this.queryParams = const {},
  });

  @override
  String toString() {
    return '''
              URL: $url
              METHOD: $method
              HEADERS: $headers
              QUERY: $queryParams
              BODY: $body
              ''';
  }
}
