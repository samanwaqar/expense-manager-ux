import 'package:flutter/material.dart';
import '../../../data/repository/app_repository.dart';

class DashboardController extends ChangeNotifier {
  final AppRepository repository;

  DashboardController(this.repository);

  bool isLoading = false;
  String? error;

  List expenses = [];

  double dailyTotal = 0;
  double monthlyTotal = 0;
  double totalExpense = 0;

  Future initDashboard() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      print(" DASHBOARD INIT STARTED");

      final response = await repository.getExpenses();

      if (!response.isError && response.data != null) {
        expenses = response.data;
        _calculateStats();
      } else {
        error = response.message ?? "Failed dashboard";
      }

    } catch (e) {
      error = e.toString();
      print(" DASHBOARD ERROR: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  void _calculateStats() {
    totalExpense = 0;
    dailyTotal = 0;
    monthlyTotal = 0;

    DateTime now = DateTime.now();

    for (var e in expenses) {
      double amount = (e["amount"] ?? 0).toDouble();

      totalExpense += amount;

      DateTime date;
      try {
        date = DateTime.parse(e["date"]);
      } catch (_) {
        date = now;
      }

      if (date.day == now.day &&
          date.month == now.month &&
          date.year == now.year) {
        dailyTotal += amount;
      }

      if (date.month == now.month &&
          date.year == now.year) {
        monthlyTotal += amount;
      }
    }

    print(" TOTAL: $totalExpense");
  }
}
