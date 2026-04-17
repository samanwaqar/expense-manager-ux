import 'package:flutter/material.dart';
import '../../../data/repository/app_repository.dart';
import '../repository/reports_repository.dart';

class ReportsController extends ChangeNotifier {
  final AppRepository repository;

  ReportsController(this.repository);

  bool isLoading = false;
  String? error;
  Map<String, dynamic> report = {};

  Future loadReport() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      print(" LOADING REPORT...");

      final response = await repository.monthlyReport();

      if (response.isError) {
        error = response.message ?? "Something went wrong";
        print(" API ERROR: ${error}");
      } else {
        final data = response.data;

        if (data is Map<String, dynamic>) {
          report = data;
          print(" REPORT LOADED: $report");
        } else {
          error = "Invalid report format";
          print(" INVALID FORMAT: $data");
        }
      }

    } catch (e) {
      error = e.toString();
      print(" EXCEPTION: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
