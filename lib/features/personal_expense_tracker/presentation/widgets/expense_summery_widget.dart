import 'package:flutter/material.dart';

class ExpenseSummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expense Summary',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Category 1: \$500'),
          Text('Category 2: \$300'),
          Text('Category 3: \$200'),
          // Add more categories as needed
        ],
      ),
    );
  }
}
