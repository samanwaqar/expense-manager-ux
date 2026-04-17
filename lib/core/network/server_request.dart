class ServerRequest {
  final String url;
  final dynamic body;
  final String? token;

  ServerRequest({required this.url, this.body, this.token});
}
