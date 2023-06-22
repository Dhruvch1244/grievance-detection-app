import 'package:Deshatan/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

class LoginPage extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
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
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
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

SizedBox(
  width: 200,
  height: 50,
  child: ElevatedButton(
    onPressed: () async {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      if (email.isNotEmpty && password.isNotEmpty) {
        DatabaseHelper databaseHelper = DatabaseHelper();
        bool credentialsValid = await databaseHelper.checkCredentials(email, password);

        if (credentialsValid) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('User logged in'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // You can navigate to another page upon successful login
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => dashboard(email : email)),
                    );
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Incorrect username or password'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Email and password are required'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    },
    style: ElevatedButton.styleFrom(
      primary: Color(0xFF023436),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    child: Text(
      'Login',
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
    ),
  ),
),


                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the sign-up page
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        'Don\'t have an account? Sign up',
                        style: TextStyle(
                          fontSize: 16,
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
}
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
  Future<bool> checkCredentials(String email, String password) async {
    try {
      // Query the 'users' collection
      final querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking credentials: $e');
      return false;
    }

  }

}

