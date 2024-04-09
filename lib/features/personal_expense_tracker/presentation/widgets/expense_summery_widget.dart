import 'package:flutter/material.dart';

class ExpenseSummaryWidget extends StatelessWidget {
  final double dailyExpenses,  weeklyExpenses,  monthlyExpenses;
  ExpenseSummaryWidget(this.dailyExpenses, this.weeklyExpenses, this.monthlyExpenses);

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
          Row(
            children: [
              Column(
                children: [
                  Text('Daily'),
                  Text("${dailyExpenses}"),
                ],
              ),
              Column(
                children: [
                  Text('weekly'),
                  Text("${weeklyExpenses}"),
                ],
              ),
              Column(
                children: [
                  Text('monthly'),
                  Text("${monthlyExpenses}"),
                ],
              ),
            ],
          ),

          // Add more categories as needed
        ],
      ),
    );
  }
}
