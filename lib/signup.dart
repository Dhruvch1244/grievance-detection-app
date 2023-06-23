import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Import the firebase_app_check plugin
import 'package:firebase_app_check/firebase_app_check.dart';

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

// Add a new document with a generated ID
    _firestore.collection("users").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));

    return await dbClient!.insert('users', user);
  }
  Future<void> insertUserProfile(String firstName, String lastName, String email, String phoneNumber, String description) async {
    try {
      CollectionReference usersCollection = _firestore.collection('userdata');
      Map<String, dynamic> user = {
        'name': '$firstName $lastName',
        'email': email,
        'phoneNumber': phoneNumber,
        'description': description,
      };
      await usersCollection.add(user);
      print('User profile inserted successfully!');
    } catch (e) {
      print('Error inserting user profile: $e');
    }
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
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                  height: MediaQuery.of(context).size.height * 0.75,
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
    await databaseHelper.insertUserProfile(firstName,lastName,email,"Enter Phone Number","Enter Description");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('REGISTERED SUCCESSFULLY'),
          content: Text('REGISTERED SUCCESSFULLY'),
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
    // Registration successful, you can navigate to another page or show a success message.
  } else {
    print("Not Successfull");
    // Show an error message indicating that all fields are required.
  }

  Navigator.pushNamed(context, '/login');
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
}
