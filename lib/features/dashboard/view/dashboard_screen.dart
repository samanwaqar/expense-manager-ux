import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/dashboard_controller.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      context.read<DashboardController>().initDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DashboardController>();

    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),

      body: controller.isLoading
          ? Center(child: CircularProgressIndicator())

          : controller.error != null
          ? Center(child: Text(controller.error!))

          : Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _card(
              "Total Expense",
              "Rs ${controller.totalExpense}",
              Icons.attach_money,
              Colors.blue,
            ),

            SizedBox(height: 12),

            _card(
              "Today Spending",
              "Rs ${controller.dailyTotal}",
              Icons.today,
              Colors.orange,
            ),

            SizedBox(height: 12),

            _card(
              "Monthly Spending",
              "Rs ${controller.monthlyTotal}",
              Icons.calendar_month,
              Colors.green,
            ),

            SizedBox(height: 12),

            _card(
              "Total Transactions",
              "${controller.expenses.length}",
              Icons.receipt,
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(String title, String value, IconData icon, Color color) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 35),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
