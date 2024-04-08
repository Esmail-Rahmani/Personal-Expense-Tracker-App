class Expense {
  final int id;
  final double amount;
  final DateTime date;
  final String description;
  final String category; // Optional category for the expense

  Expense({
    required this.amount,
    required this.date,
    required this.description,
    this.category = '',
    this.id = 0, // For database handling (might be auto-generated)
  });

  // Additional methods
  Map<String, Object> toJson() => {
    'id': id,
    'amount': amount,
    'date': date.toIso8601String(), // Convert DateTime to ISO 8601 format
    'description': description,
    'category': category,
  };

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    id: json['id'] as int,
    amount: json['amount'] as double,
    date: DateTime.parse(json['date'] as String), // Parse ISO 8601 string back to DateTime
    description: json['description'] as String,
    category: json['category'] as String,
  );


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Expense &&
              amount == other.amount &&
              date == other.date &&
              description == other.description &&
              category == other.category;

  @override
  int get hashCode =>
      amount.hashCode ^ date.hashCode ^ description.hashCode ^ category.hashCode;
}
