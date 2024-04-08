
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../widgets/add_expense_widget.dart';
import '../widgets/expense_summery_widget.dart';
import '../widgets/view_expense_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Your Expenses',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: 60.h,
                child: ViewExpensesWidget()),
            ExpenseSummaryWidget(),
          ],
        ),
      ),
    );
  }


  static void showAddExpensePopup(BuildContext context, void Function(double amount, String description, DateTime date, String category) onAdd) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    String selectedCategory = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Expense'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Amount'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  readOnly: true,
                  onTap: () {
                    _selectDate(context).then((selectedDate) {
                      if (selectedDate != null) {
                        // Handle selected date
                      }
                    });
                  },
                  decoration: InputDecoration(labelText: 'Date'),
                ),
                TextField(
                  onChanged: (value) {
                    selectedCategory = value;
                  },
                  decoration: InputDecoration(labelText: 'Category'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                double amount = double.tryParse(amountController.text) ?? 0.0;
                String description = descriptionController.text;
                // Add more validation as needed
                if (amount > 0 && description.isNotEmpty && selectedCategory.isNotEmpty) {
                  onAdd(amount, description, DateTime.now(), selectedCategory);
                  Navigator.of(context).pop();
                } else {
                  // Show error message or handle invalid input
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  static Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    return pickedDate;
  }
}
