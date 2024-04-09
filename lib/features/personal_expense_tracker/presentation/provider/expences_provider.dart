import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/models/expences.dart';
import '../../domain/repositories/expenses_repositories.dart';

class ExpenseProvider extends ChangeNotifier {
  late ExpenseRepository _repository;

  ExpenseProvider(Database database) {
    _repository = ExpenseRepository(database);
  }

  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  Future<void> getAllExpenses() async {
    _expenses = await _repository.getAllExpenses();
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await _repository.addExpense(expense);
    await getAllExpenses(); // Refresh expenses after adding
  }

  Future<void> updateExpense(Expense expense) async {
    await _repository.updateExpense(expense);
    await getAllExpenses(); // Refresh expenses after updating
  }

  Future<void> deleteExpense(int id) async {
    await _repository.deleteExpense(id);
    await getAllExpenses(); // Refresh expenses after deleting
  }

  Future<void> getFilteredExpenses(String filter) async {
    _expenses = await _repository.getFilteredExpenses(filter);
    notifyListeners();
  }



  double _dailyExpenses = 0.0;
  double _weeklyExpenses = 0.0;
  double _monthlyExpenses = 0.0;

  double get dailyExpenses => _dailyExpenses;
  double get weeklyExpenses => _weeklyExpenses;
  double get monthlyExpenses => _monthlyExpenses;

  Future<void> calculateTotalExpenses(DateTime startDate, DateTime endDate) async {
    _dailyExpenses = await _repository.getTotalExpenses(startDate, endDate);

    final DateTime startOfWeek =
    DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    _weeklyExpenses = await _repository.getTotalExpenses(startOfWeek, DateTime.now());

    final DateTime startOfMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    _monthlyExpenses = await _repository.getTotalExpenses(startOfMonth, DateTime.now());

    notifyListeners();
  }
}
