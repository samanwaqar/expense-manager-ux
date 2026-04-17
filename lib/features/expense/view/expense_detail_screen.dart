import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../controller/expense_controller.dart';
import '../../../core/routes/app_routes.dart';

class ExpenseDetailScreen extends StatelessWidget {
  final Map expense;

  ExpenseDetailScreen({required this.expense});

  String formatDate(String? date) {
    if (date == null) return "";
    final parsed = DateTime.parse(date);
    return DateFormat("dd MMM yyyy, hh:mm a").format(parsed);
  }

  Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case "food":
        return Colors.orange;
      case "travel":
        return Colors.blue;
      case "shopping":
        return Colors.purple;
      case "bills":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ExpenseController>();
    final category = expense["category"] ?? "General";

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text("Expense Detail"),
        backgroundColor: Colors.lightBlue[100],
        actions: [

          // ✏ EDIT
          IconButton(
            icon: Icon(Icons.edit, color: Colors.green),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.addExpense,
                arguments: expense,
              );
            },
          ),

          // 🗑 DELETE WITH BOTTOM SHEET
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Icon(Icons.warning, color: Colors.brown, size: 40),
                        SizedBox(height: 10),

                        Text(
                          "Delete Expense?",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),

                        SizedBox(height: 10),

                        Text(
                          "This action cannot be undone.",
                          style: TextStyle(color: Colors.blueGrey),
                        ),

                        SizedBox(height: 20),

                        Row(
                          children: [

                            Expanded(
                              child: OutlinedButton(
                                onPressed: () =>
                                    Navigator.pop(context),
                                child: Text("Cancel"),
                              ),
                            ),

                            SizedBox(width: 10),

                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);

                                  bool success =
                                  await controller.deleteExpense(
                                      expense["id"]);

                                  if (success) Navigator.pop(context);
                                },
                                child: Text("Delete",
                                    style: TextStyle(
                                    color: Colors.white),
                              ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  children: [

                    Icon(Icons.account_balance_wallet,
                        size: 50, color: Colors.lightBlue),

                    SizedBox(height: 10),

                    Text(
                      "Rs ${expense["amount"]}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 15),

                    // CATEGORY TAG
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color:
                        getCategoryColor(category).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: getCategoryColor(category),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Divider(),

                    SizedBox(height: 20),

                    _buildDetailRow(
                      icon: Icons.title,
                      label: "Title",
                      value: expense["title"],
                    ),

                    SizedBox(height: 15),

                    _buildDetailRow(
                      icon: Icons.access_time,
                      label: "Date",
                      value: formatDate(expense["createdAt"]),
                    ),

                    // 📸 RECEIPT IMAGE
                    if (expense["receiptUrl"] != null &&
                        expense["receiptUrl"].toString().isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Receipt",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          SizedBox(height: 10),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              expense["receiptUrl"],
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[700]),
        SizedBox(width: 10),
        Text(
          "$label: ",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
