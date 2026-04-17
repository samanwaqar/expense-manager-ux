import 'package:flutter/material.dart';
import '../../../data/model/api_error.dart';
import '../../../data/repository/app_repository.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/utils/toast_helper.dart';


class LoginController extends ChangeNotifier {
  final AppRepository repository;

  bool isLoading = false;
  String? error;

  LoginController(this.repository);

  Future<bool> login(String email, String password) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final response = await repository.login({
        "email": email,
        "password": password,
      });

      //  SUCCESS
      if (!response.isError && response.statusCode == 200) {
        final data = response.data;

        String accessToken = data["accessToken"];
        String refreshToken = data["refreshToken"];

        await LocalStorage.saveTokens(accessToken, refreshToken);

        isLoading = false;
        notifyListeners();
        return true;
      }

      //  ERROR HANDLING (NEW CLEAN WAY)
      final errorData = response.data;

      if (errorData != null && errorData is Map<String, dynamic>) {
        final apiError = ApiError.fromJson(errorData);
        // switch (apiError.errorCode) {
        //   case "INCORRECT_PASSWORD":
        //     ToastHelper.show("Incorrect password");
        //     break;
        //
        //   case "USER_NOT_FOUND":
        //     ToastHelper.show("Email not found");
        //     break;
        //
        //   case "INVALID_REFRESH_TOKEN":
        //     ToastHelper.show("Session expired. Please login again.");
        //     break;
        //
        //   default:
        //     ToastHelper.show(apiError.message.isNotEmpty
        //         ? apiError.message
        //         : "Login failed");
        // }

        error = apiError.message;
      } else {
        error = response.message;
      }

    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
    return false;
  }
}
