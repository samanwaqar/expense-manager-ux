class ExpenseModel {
  final int id;
  final String title;
  final double amount;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
    );
  }
}
