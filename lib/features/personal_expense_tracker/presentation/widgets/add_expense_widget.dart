import 'package:flutter/material.dart';

class AddExpenseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Description'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Date'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Category'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Add expense logic
            },
            child: Text('Add Expense'),
          ),
        ],
      ),
    );
  }
}
