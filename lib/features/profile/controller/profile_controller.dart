import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/storage/local_storage.dart';
import '../repository/profile_repository.dart';

class ProfileController extends ChangeNotifier {
  final ProfileRepository repository;

  ProfileController(this.repository);

  bool isLoading = false;

  Map<String, dynamic>? profile;

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  Future loadProfile() async {
    isLoading = true;
    notifyListeners();

    try {
      profile = await repository.getProfile();

      nameController.text = profile?["name"] ?? "";
      emailController.text = profile?["email"] ?? "";

    } catch (e) {
      print(" LOAD PROFILE ERROR: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future saveProfile() async {
    isLoading = true;
    notifyListeners();

    try {
      final updated = {
        "name": nameController.text,
        "email": emailController.text,
        "role": "USER"
      };

      await repository.updateProfile(updated);

      profile = updated;

      print(" PROFILE SAVED");

    } catch (e) {
      print(" SAVE ERROR: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future logout(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      await LocalStorage.clear();

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
            (route) => false,
      );
    } catch (e) {
      print("LOGOUT ERROR: $e");
    }

    isLoading = false;
    notifyListeners();
  }

}
