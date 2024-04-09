import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/models/expences.dart';
import '../provider/expences_provider.dart';

class ExpenseListWidget extends StatefulWidget {
  final List<Expense> expenses; // Replace with your actual list of expenses
  final void Function() onChanged;
  final int? length;

  ExpenseListWidget({Key? key, required this.expenses,required this.onChanged, this.length}) : super(key: key);

  @override
  State<ExpenseListWidget> createState() => _ExpenseListWidgetState();
}

class _ExpenseListWidgetState extends State<ExpenseListWidget> {
  DateFormat  dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.length??widget.expenses.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12)
          ),
          child: ListTile(
            // leading: Text("${expenses[index].id}"),
            title: Text(widget.expenses[index].description),
            subtitle: Text('Amount: ${widget.expenses[index].amount} \nDate: ${dateFormat.format(widget.expenses[index].date)}'), // Replace with actual expense details
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    print("test edit");
                    showEditPopup(widget.expenses[index],context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteExpensePopup(widget.expenses[index].id);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  DateTime selectedDate = DateTime.now();

  showEditPopup(Expense expense,context){
    TextEditingController amountController = TextEditingController(text: expense.amount.toString() );
    TextEditingController descriptionController = TextEditingController(text: expense.description);
    selectedDate = expense.date;
    print("not test");
    showDialog(
        context: context,
        builder: (context)
    {
      return AlertDialog(
        title: Text('Update Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            Row(
              children: [
                Text('Date:'),
                SizedBox(width: 16.0),
                TextButton(
                  onPressed: () {
                    _selectDate(context);
                    setState(() {

                    });
                  },
                  child: Text(
                    '${selectedDate.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await updateExpenses(
                  expense.id,
                  amountController.text,
                  descriptionController.text,
                  selectedDate,
                  context
              );
              Navigator.of(context).pop();
            },
            child: Text('Update'),
          ),
        ],
      );
    });
  }

  deleteExpensePopup(int id){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this record?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await deleteExpenses(id);
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      );
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedDate = pickedDate;
      });
  }

  updateExpenses(id,String amount, String description, DateTime dateTime,context) async {
    ExpenseProvider expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    Expense expense = Expense(id:id,amount: double.parse(amount), date: dateTime, description: description);
    await expenseProvider.updateExpense(expense);
    widget.onChanged();
  }
  deleteExpenses(id) async {
    ExpenseProvider expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    await expenseProvider.deleteExpense(id);
    widget.onChanged();

  }
}
