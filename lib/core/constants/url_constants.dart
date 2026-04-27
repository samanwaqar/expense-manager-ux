class UrlConstants {

  static const bool isEmulator = false;

  static const String baseUrl = isEmulator
      ? "http://10.0.2.2:8080"
      : "http://192.168.3.50:8080";

  static const String login = "/auth/login";
  static const String signup = "/auth/sign-up";

  static const String addExpense = "/expenses/create";
  static const String getExpenses = "/expenses/getAll";
  static const String updateExpense = "/expenses/"; // + id
  static const String deleteExpense = "/expenses/"; // + id

  static const String dashboard = "/expenses/dashboard";
  static const String monthlyReport = "/expenses/monthly-report";

  static const profile = "/user/profile";
  static const updateProfile = "/user/update-profile";

}
