import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import '../provider/expences_provider.dart';
import '../widgets/expenses_list.dart';
import '../widgets/filter_dropdown.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  late ExpenseProvider expenseProvider;
  String selectedFilter = '';
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    fetchDataFromProvider();
  }

  Future<void> fetchDataFromProvider() async {
    await expenseProvider.getAllExpenses();
    setState(() {

    });
  }

  Future<void> onFilterChanged(String? filter) async {
    selectedFilter = filter ?? "";
    await expenseProvider.getFilteredExpenses(selectedFilter);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: Column(
        children: [
          FilterDropdownsWidget(
            onFilterChanged: onFilterChanged,
          ),
          SizedBox(height: 24,),
          Expanded(
            child: ExpenseListWidget(
              expenses: expenseProvider.expenses,
              onChanged: () {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
