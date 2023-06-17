import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
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
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Deshatsan.db');

    // Open/create the database at a given path
    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      // Create your database tables here
      await db.execute('CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, email TEXT, password TEXT)');
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
}

class SignUpPage extends StatelessWidget {
  @override
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
Future<int> insertUser(Map<String, dynamic> user) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    return await databaseHelper.insertUser(user);
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF023436),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                    children: [
                      Text(
                        'Deshatan.',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'The travel gazette',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Register',
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                          ),
                          ),

                      SizedBox(height: 16),
                      TextField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          prefixIcon: Icon(Icons.person),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),

                      SizedBox(height: 16),
                      TextField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          
                          hintText: 'Last Name',
                          prefixIcon: Icon(Icons.person_2),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),

                      SizedBox(height: 16),
                      TextField(
                        controller: _emailController, 
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
  String firstName = _firstNameController.text.trim();
  String lastName = _lastNameController.text.trim();
  String email = _emailController.text.trim();
  String password = _passwordController.text;

  if (firstName.isNotEmpty &&
      lastName.isNotEmpty &&
      email.isNotEmpty &&
      password.isNotEmpty) {
    Map<String, dynamic> user = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };

    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.insertUser(user);
      print("Successfull");
      printUsers();

    // Registration successful, you can navigate to another page or show a success message.
  } else {
    print("Not Successfull");
    // Show an error message indicating that all fields are required.
  }
},

                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF023436),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                  
                      Text(
                        'Already Have an Account?',
                      style: TextStyle(
                      fontSize: 16,
                          ),
                          ),
                          GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, '/login');
                        },
                      child: Text(
                        'Login',
                      style: TextStyle(
                      color: Colors.blue,
                       decoration: TextDecoration.underline,
                        ),
                          ),
                          ),
        
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        ),
        
      );
      
  }
void printUsers() async {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Map<String, dynamic>> users = await databaseHelper.getUsers();

  for (Map<String, dynamic> user in users) {
    print('ID: ${user['id']}');
    print('First Name: ${user['firstName']}');
    print('Last Name: ${user['lastName']}');
    print('Email: ${user['email']}');
    print('Password: ${user['password']}');
    print('------------------------');
  }
}

}
