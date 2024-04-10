import 'package:sqflite/sqflite.dart';

import '../../data/models/expences.dart';

class ExpenseRepository {
  final Database _database;

  ExpenseRepository(this._database);


  Future<List<Expense>> getAllExpenses() async {

    try {
      final List<Map<String, dynamic>> maps = await _database.query('expenses');
      return List.generate(maps.length, (i) {
        return Expense(
          id: maps[i]['id'],
          amount: maps[i]['amount'],
          description: maps[i]['description'],
          date: DateTime.parse(maps[i]['date']),
        );
      });
    } on Exception catch (e) {
      return [];
      // TODO
    }
  }


  Future<List<Expense>> getFilteredExpenses(String filter) async {
    String query = 'SELECT * FROM expenses WHERE 1=1';

    try {
      if (filter.isNotEmpty) {
        if (filter == 'Day') {
          query += ' AND date >= date("now", "start of day")';
        } else if (filter == 'Week') {
          query += ' AND date >= date("now", "weekday 0", "-7 days")';
        } else if (filter == 'Month') {
          query += ' AND date >= date("now", "start of month")';
        }
      }
      final List<Map<String, dynamic>> maps = await _database.rawQuery(query);
      return List.generate(maps.length, (i) {
        return Expense(
          id: maps[i]['id'],
          amount: maps[i]['amount'],
          description: maps[i]['description'],
          date: DateTime.parse(maps[i]['date']),
        );
      });
    } on Exception catch (e) {
      return [];
      // TODO
    }
  }

  Future<double> getTotalExpenses(DateTime startDate, DateTime endDate) async {
    try {
      final List<Map<String, dynamic>> maps = await _database.rawQuery(
          'SELECT SUM(amount) AS total FROM expenses WHERE date BETWEEN ? AND ?',
          [startDate.toIso8601String(), endDate.toIso8601String()]);

      double total = maps.first['total'] ?? 0.0;
      return total;
    } on Exception catch (e) {
      return 0;
      // TODO
    }
  }

  Future<void> addExpense(Expense expense) async {
    await _database.insert(
      'expenses',
      expense.toJson(includeId: false),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateExpense(Expense expense) async {
    print("Update ${expense.toJson()}");
    await _database.update(
      'expenses',
      expense.toJson(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<void> deleteExpense(int id) async {
    await _database.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
