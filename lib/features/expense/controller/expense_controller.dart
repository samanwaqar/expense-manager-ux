import 'package:flutter/material.dart';
import '../../../data/repository/app_repository.dart';

class ExpenseController extends ChangeNotifier {
  final AppRepository repository;

  ExpenseController(this.repository);

  bool isLoading = false;
  String? error;

  String selectedFilter = "ALL";

  List allExpenses = [];
  List filteredExpenses = [];

  Future fetchExpenses() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();
      print(" FETCH EXPENSES START");

      final response = await repository.getExpenses();

      if (!response.isError && response.data != null) {
        allExpenses = response.data;
        filteredExpenses = allExpenses;

        print(" EXPENSES LOADED: ${allExpenses.length}");
      } else {
        error = response.message ?? "Failed to load expenses";
        print(" ERROR: $error");
      }

    } catch (e) {
      error = e.toString();
      print(" EXCEPTION: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  void filterExpenses(String type) {
    selectedFilter = type;

    DateTime now = DateTime.now();

    try {
      if (type == "ALL") {
        filteredExpenses = allExpenses;
      }

      else if (type == "DAILY") {
        filteredExpenses = allExpenses.where((e) {
          DateTime d = _safeDate(e["date"]);
          return _isSameDay(d, now);
        }).toList();
      }

      else if (type == "MONTHLY") {
        filteredExpenses = allExpenses.where((e) {
          DateTime d = _safeDate(e["date"]);
          return d.month == now.month && d.year == now.year;
        }).toList();
      }

      else if (type == "CATEGORY") {
        filteredExpenses = allExpenses.where((e) {
          return (e["category"] ?? "") == "Food";
        }).toList();
      }

      print(" FILTER APPLIED: $type (${filteredExpenses.length})");

    } catch (e) {
      print(" FILTER ERROR: $e");
    }

    notifyListeners();
  }

  DateTime _safeDate(dynamic value) {
    try {
      if (value == null) return DateTime.now();
      return DateTime.parse(value.toString());
    } catch (_) {
      return DateTime.now();
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  Future<bool> addExpense(Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      print(" ADD EXPENSE: $data");

      final response = await repository.addExpense(data);

      if (!response.isError) {
        print(" EXPENSE ADDED");

        await fetchExpenses(); // refresh list
        return true;
      } else {
        print(" ADD FAILED: ${response.message}");
      }

    } catch (e) {
      print(" ADD ERROR: $e");
    }

    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> updateExpense(int id, Map<String, dynamic> data) async {
    try {
      isLoading = true;
      notifyListeners();

      print(" UPDATE EXPENSE ID: $id");

      final response = await repository.updateExpense(id, data);

      if (!response.isError) {
        print(" UPDATED");

        await fetchExpenses();
        return true;
      } else {
        print(" UPDATE FAILED");
      }

    } catch (e) {
      print(" UPDATE ERROR: $e");
    }

    isLoading = false;
    notifyListeners();
    return false;
  }
  Future<bool> deleteExpense(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      print("🗑 DELETE EXPENSE ID: $id");

      final response = await repository.deleteExpense(id);

      if (!response.isError) {
        print(" DELETED");

        await fetchExpenses();
        return true;
      } else {
        print(" DELETE FAILED");
      }

    } catch (e) {
      print(" DELETE ERROR: $e");
    }

    isLoading = false;
    notifyListeners();
    return false;
  }

}
