import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../data/models/expences.dart';

class ExpenseProvider extends ChangeNotifier {
  late Database _database;

  ExpenseProvider() {
    _initDatabase();
  }
  Future<void> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'expense_tracker.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE expenses(id INTEGER PRIMARY KEY, amount REAL, description TEXT, date TEXT, category TEXT)',
        );
      },
    );
  }
  Future<List<Expense>> getExpenses() async {
    final List<Map<String, dynamic>> maps = await _database.query('expenses');
    return List.generate(maps.length, (i) {
      return Expense(
        id: maps[i]['id'],
        amount: maps[i]['amount'],
        description: maps[i]['description'],
        date: maps[i]['date'],
        category: maps[i]['category'],
      );
    });
  }

  Future<void> addExpense(Expense expense) async {
    await _database.insert(
      'expenses',
      expense.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<void> updateExpense(Expense expense) async {
    await _database.update(
      'expenses',
      expense.toJson(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
    notifyListeners();
  }

  Future<void> deleteExpense(int id) async {
    await _database.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }
}
