import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/expences.dart';
import '../provider/expences_provider.dart';



class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  TextEditingController _amountController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Amount'),
              onChanged: (value) {
                // Implement onChanged logic for amount
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                // Implement onChanged logic for description
              },
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Date:'),
                SizedBox(width: 16.0),
                TextButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text(
                    '${_selectedDate.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _submitExpense();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate)
      setState(() {
        _selectedDate = pickedDate;
      });
  }

  void _addExpenses() {
    ExpenseProvider expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    Expense expense = Expense(amount: double.parse(_amountController.text), date: _selectedDate, description: _descriptionController.text);
    expenseProvider.addExpense(expense);

  }
  void _submitExpense() {
    _addExpenses();
    _showSuccessPopup();
    _clearForm();
  }

  void _showSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Expense added successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _clearForm() {
    _amountController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedDate = DateTime.now();
    });
  }
}
