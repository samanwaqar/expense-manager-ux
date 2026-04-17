import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _goLogin();
  }

  Future<void> _goLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    print("➡ ALWAYS GO LOGIN");

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.login,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F1115),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [

            Icon(Icons.account_balance_wallet,
                size: 80,
                color: Colors.lightBlueAccent),

            SizedBox(height: 20),

            Text(
              "Expense Tracker",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            CircularProgressIndicator(
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
