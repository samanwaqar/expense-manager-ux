import 'package:expense_app/features/profile/controller/profile_controller.dart';
import 'package:expense_app/features/profile/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/network/api_client.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/route_generator.dart';
import 'data/remote/remote_data_source.dart';
import 'data/repository/app_repository.dart';
import 'features/dashboard/controller/dashboard_controller.dart';
import 'features/expense/controller/expense_controller.dart';
import 'features/login/controller/login_controller.dart';
import 'features/reports/controller/reports_controller.dart';
import 'features/signup/controller/signup_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  //  SINGLE SOURCE OF TRUTH
  final ApiClient apiClient = ApiClient();

  late final RemoteDataSource remoteDataSource =
  RemoteDataSource(apiClient);

  late final AppRepository appRepository =
  AppRepository(remoteDataSource);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //  LOGIN
        ChangeNotifierProvider(
          create: (_) => LoginController(appRepository),
        ),
        //Signup
        ChangeNotifierProvider(
          create: (_) => SignupController(appRepository),
        ),

        //  DASHBOARD
        ChangeNotifierProvider(
          create: (_) => DashboardController(appRepository),
        ),

        // EXPENSE
        ChangeNotifierProvider(
          create: (_) => ExpenseController(appRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => ReportsController(appRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileController(ProfileRepository()),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense App',

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),

        initialRoute: AppRoutes.splash,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
