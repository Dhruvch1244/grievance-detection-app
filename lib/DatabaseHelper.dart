import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initializeDatabase();
    return _database;
  }

  DatabaseHelper.internal();

  Future<Database> initializeDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'signup.db');

    // Open/create the database at a given path
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Create the user table
        await db.execute(
          'CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, firstName TEXT, lastName TEXT, email TEXT, password TEXT)',
        );
      },
    );

    return database;
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    Database? db = await database;
    return await db!.insert('users', user);
  }
}
