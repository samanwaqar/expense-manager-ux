import 'package:expense_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../controller/expense_controller.dart';

class ExpenseListScreen extends StatefulWidget {
  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {

  String formatDate(String? date) {
    if (date == null) return "";
    final parsed = DateTime.parse(date);
    return DateFormat("dd MMM").format(parsed);
  }

  Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case "food":
        return Colors.orange;
      case "travel":
        return Colors.blue;
      case "shopping":
        return Colors.purple;
      case "bill":
        return Colors.red;
      case "transport":
        return Colors.blueAccent;
      case "entertainment":
        return Colors.pink;
      case "appliances":
        return Colors.green;
      case "toy":
        return Colors.pink;
      default:
        return Colors.teal;
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ExpenseController>().fetchExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ExpenseController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text("My Expenses"),
        backgroundColor: Colors.lightBlue[100],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addExpense);
        },
      ),

      body: Column(
        children: [
          _buildFilters(controller),
          Expanded(child: _buildBody(controller)),
        ],
      ),
    );
  }

  Widget _buildBody(ExpenseController controller) {
    if (controller.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (controller.filteredExpenses.isEmpty) {
      return Center(child: Text("No Expenses Found"));
    }

    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: controller.filteredExpenses.length,
      itemBuilder: (_, i) {
        final e = controller.filteredExpenses[i];

        final category = e["category"] ?? "General";

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.expenseDetail,
              arguments: e,
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 6)
              ],
            ),
            child: Row(
              children: [

                // ICON
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: getCategoryColor(category)
                        .withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.receipt,
                      color: getCategoryColor(category)),
                ),

                SizedBox(width: 12),

                // TEXT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        e["title"] ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 5),

                      Row(
                        children: [

                          // CATEGORY TAG
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: getCategoryColor(category)
                                  .withOpacity(0.15),
                              borderRadius:
                              BorderRadius.circular(10),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                color:
                                getCategoryColor(category),
                                fontSize: 12,
                              ),
                            ),
                          ),

                          SizedBox(width: 8),

                          Text(
                            formatDate(e["createdAt"]),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // AMOUNT
                Text(
                  "Rs ${e["amount"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilters(ExpenseController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          _chip(controller, "ALL"),
          _chip(controller, "DAILY"),
          _chip(controller, "MONTHLY"),
          _chip(controller, "CATEGORY"),
        ],
      ),
    );
  }

  Widget _chip(ExpenseController controller, String label) {
    final isSelected = controller.selectedFilter == label;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: Colors.lightBlue,
        onSelected: (_) {
          controller.filterExpenses(label);
        },
      ),
    );
  }
}
