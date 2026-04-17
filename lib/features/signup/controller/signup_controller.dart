import 'package:flutter/material.dart';
import '../../../data/repository/app_repository.dart';

class SignupController extends ChangeNotifier {
  final AppRepository repository;

  bool isLoading = false;
  String? error;

  SignupController(this.repository);

  Future<bool> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final response = await repository.signup({
        "name": name,
        "email": email,
        "password": password,
        "role": "USER"
      });

      // FIXED RESPONSE HANDLING
      if (!response.isError &&
          (response.statusCode == 200 || response.statusCode == 201)) {

        final data = response.data;

        print(" USER CREATED:");
        print("ID: ${data["id"]}");
        print("EMAIL: ${data["email"]}");
        print("NAME: ${data["name"]}");

        isLoading = false;
        notifyListeners();
        return true;
      }

      error = response.message ?? "Signup failed";
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
    return false;
  }
}
