import 'package:dio/dio.dart';
import '../constants/url_constants.dart';
import '../storage/local_storage.dart';
import 'request_attr.dart';
import 'server_response.dart';
import 'logging_interceptor.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: UrlConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  )..interceptors.add(LoggingInterceptor());

  //  REFRESH TOKEN FUNCTION
  static Future<String?> _refreshAccessToken() async {
    try {
      final refreshToken = await LocalStorage.getRefreshToken();

      if (refreshToken == null) return null;

      final response = await _dio.post(
        "/auth/refresh",
        data: {
          "refreshToken": refreshToken,
        },
      );

      final newAccessToken = response.data["accessToken"];

      await LocalStorage.saveTokens(
        newAccessToken,
        refreshToken,
      );

      return newAccessToken;

    } catch (e) {
      return null;
    }
  }

  static Future<ServerResponse> request(RequestAttr attr) async {
    try {
      String? token = await LocalStorage.getToken();

      final isAuthRoute = attr.url.startsWith("/auth");

      final response = await _dio.request(
        attr.url,
        data: attr.body,
        queryParameters: attr.queryParams,
        options: Options(
          method: attr.method.name,
          headers: {
            ...attr.headers,
            if (token != null && !isAuthRoute)
              "Authorization": "Bearer $token",
          },
        ),
      );

      return ServerResponse(
        data: response.data,
        isError: false,
        message: "Success",
        statusCode: response.statusCode ?? 200,
      );

    } catch (e) {
      if (e is DioException) {

        //  TOKEN EXPIRED → TRY REFRESH
        if (e.response?.statusCode == 401) {

          final newToken = await _refreshAccessToken();

          if (newToken != null) {

            final retryResponse = await _dio.request(
              attr.url,
              data: attr.body,
              queryParameters: attr.queryParams,
              options: Options(
                method: attr.method.name,
                headers: {
                  ...attr.headers,
                  "Authorization": "Bearer $newToken",
                },
              ),
            );

            return ServerResponse(
              data: retryResponse.data,
              isError: false,
              message: "Success (refreshed)",
              statusCode: retryResponse.statusCode ?? 200,
            );
          }

          // refresh failed → logout
          await LocalStorage.clear();
        }

        return ServerResponse(
          data: e.response?.data,
          isError: true,
          message: e.message ?? "Error",
          statusCode: e.response?.statusCode ?? 500,
        );
      }

      return ServerResponse(
        data: null,
        isError: true,
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
