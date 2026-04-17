import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<http.Response> get(String url, {String? token}) {
    return http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token"
      },
    );
  }

  Future<http.Response> post(String url, dynamic body, {String? token}) {
    return http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token"
      },
    );
  }
  Future<http.Response> put(String url, dynamic body, {String? token}) {
    return http.put(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token"
      },
    );
  }

  Future<http.Response> delete(String url, {String? token}) {
    return http.delete(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token"
      },
    );
  }

}
