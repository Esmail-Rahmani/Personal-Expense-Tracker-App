import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String _databaseName = 'expense_tracker.db';
  static const int _databaseVersion = 1;

  DatabaseProvider._();
  static final DatabaseProvider instance = DatabaseProvider._();

  static Database? _database;

  Future<Database> get database async {
    print("creating database");

    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: createDatabase,
    );
  }

  Future<void> createDatabase(Database db, int version) async {
    print("creating table");
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY,
        amount REAL,
        description TEXT,
        date TEXT
      )
    ''');
  }
}
