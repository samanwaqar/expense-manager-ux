import 'package:flutter/material.dart';
import '../../expense/view/expense_list_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../../reports/view/reports_screen.dart';
import 'dashboard_screen.dart';


class MainNavigation extends StatefulWidget {
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {

  int index = 0;

  final screens = [
    DashboardScreen(),
    ExpenseListScreen(),
    ReportsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },

        type: BottomNavigationBarType.fixed, // IMPORTANT FIX

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: "Expenses",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Reports",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
