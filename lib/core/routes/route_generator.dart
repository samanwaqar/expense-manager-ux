import 'package:flutter/material.dart';
import '../../features/dashboard/view/main_view.dart';
import '../../features/splashscreen/splash_screen.dart';
import '../../features/login/view/login_screen.dart';
import '../../features/signup/view/signup_screen.dart';
import '../../features/expense/view/expense_detail_screen.dart';
import '../../features/expense/view/add_expense_screen.dart';
import '../../features/expense/view/upload_receipt_screen.dart';

import 'app_routes.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {

    //  SPLASH
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());

    //  AUTH
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => SignupScreen());

    //  MAIN APP (BOTTOM NAV ROOT)
      case AppRoutes.main:
        return MaterialPageRoute(builder: (_) => MainNavigation());

    //  EXPENSE DETAIL
      case AppRoutes.expenseDetail:
        return MaterialPageRoute(
          builder: (_) => ExpenseDetailScreen(expense: args as Map),
        );

    //  ADD EXPENSE
      case AppRoutes.addExpense:
        return MaterialPageRoute(builder: (_) => AddExpenseScreen( expense: settings.arguments as Map?,));

    //  UPLOAD RECEIPT
      case AppRoutes.uploadReceipt:
        return MaterialPageRoute(builder: (_) => UploadReceiptScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("Route not found: ${settings.name}"),
            ),
          ),
        );
    }
  }
}
