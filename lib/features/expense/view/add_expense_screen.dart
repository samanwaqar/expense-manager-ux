import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/expense_controller.dart';

class AddExpenseScreen extends StatefulWidget {
  final Map? expense; //  for update

  AddExpenseScreen({this.expense});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  String category = "Food";

  @override
  void initState() {
    super.initState();

    //  PREFILL FOR UPDATE
    if (widget.expense != null) {
      titleController.text = widget.expense!["title"] ?? "";
      amountController.text =
          (widget.expense!["amount"] ?? "").toString();
      category = widget.expense!["category"] ?? "Food";
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ExpenseController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.expense == null
            ? "Add Expense"
            : "Update Expense"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),

            SizedBox(height: 12),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount"),
            ),

            SizedBox(height: 12),

            DropdownButtonFormField(
              value: category,
              items: ["Food", "Travel", "Shopping", "Utilities"]
                  .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
                  .toList(),
              onChanged: (val) {
                setState(() => category = val.toString());
              },
              decoration: InputDecoration(labelText: "Category"),
            ),

            SizedBox(height: 20),

            controller.isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {

                final data = {
                  "title": titleController.text,
                  "amount": double.tryParse(amountController.text) ?? 0,
                  "category": category,
                };

                bool success;

                //  UPDATE
                if (widget.expense != null) {
                  success = await controller.updateExpense(
                    widget.expense!["id"],
                    data,
                  );
                }
                // ➕ ADD
                else {
                  success = await controller.addExpense(data);
                }

                if (success) {
                  Navigator.pop(context);
                }
              },
              child: Text(widget.expense == null
                  ? "Add Expense"
                  : "Update Expense"),
            )
          ],
        ),
      ),
    );
  }
}
