import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    // Open/create the database at a given path
    // Create your database tables here
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Deshatsan.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, email TEXT, password TEXT)');
    });
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    Database? dbClient = await db;
    return await dbClient!.insert('users', user);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database? dbClient = await db;
    return await dbClient!.query('users');
  }

  Future<Map<String, dynamic>> getUserByEmail(String email) async {
    Database? dbClient = await db;
    List<Map<String, dynamic>> users = await dbClient!.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (users.isNotEmpty) {
      return users.first;
    }
    return {};
  }
}
