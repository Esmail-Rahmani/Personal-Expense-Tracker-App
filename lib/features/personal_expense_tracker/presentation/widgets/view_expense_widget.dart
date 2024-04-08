import 'package:flutter/material.dart';

class ViewExpensesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Replace with actual number of expenses
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Expense $index'),
          subtitle: Text('Amount: \$100, Date: 2024-04-08'), // Replace with actual expense details
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Edit expense logic
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Delete expense logic
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

