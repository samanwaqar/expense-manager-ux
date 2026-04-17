import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  static Future<void> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("accessToken", accessToken);
    await prefs.setString("refreshToken", refreshToken);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("accessToken");
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("refreshToken");
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("accessToken");
    await prefs.remove("refreshToken");
  }

  // ================= PROFILE DATA =================

  static Future<void> save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("accessToken");
    await prefs.remove("refreshToken");
    await prefs.remove("name");
    await prefs.remove("email");
    await prefs.clear();
  }
}
