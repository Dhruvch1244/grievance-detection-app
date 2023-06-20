import 'package:Deshatan/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:Deshatan/MyProfile.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  late Database _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal() {
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, 'Deshatan.db');

    // Create the 'posts' table if it doesn't exist
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE posts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            title TEXT,
            content TEXT,
            upvotes INTEGER
          )
        ''');
      },
    );
  }

  Future<int> insertPost(Map<String, dynamic> post) async {
    await initializeDatabase(); // Ensure the database is initialized
    final db = _database;
    return await db.insert('posts', post);
  }

  Future<List<Map<String, dynamic>>> getPosts() async {
    await initializeDatabase(); // Ensure the database is initialized
    final db = _database;
    return await db.query('posts');
  }
}

class Upload extends StatefulWidget {
  final String email;

  Upload({required this.email});

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String subject = '';
  String issue = '';

  Future<void> uploadIssue() async {
    // Implement your database logic here to add an entry with the provided arguments
    // You can use the DatabaseHelper class to interact with the database
    Map<String, dynamic> post = {
      'email': widget.email,
      'title': subject,
      'content': issue,
      'upvotes': 0,
    };
    await DatabaseHelper().insertPost(post);
  }
  Future<void> printPosts() async {
    // Retrieve all posts from the database
    List<Map<String, dynamic>> posts = await DatabaseHelper().getPosts();

    // Print each post
    for (var post in posts) {
      print('Post ID: ${post['id']}');
      print('Email: ${post['email']}');
      print('Title: ${post['title']}');
      print('Content: ${post['content']}');
      print('Upvotes: ${post['upvotes']}');
      print('------------');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Color(0xFF023436),
        title: Text(
          'Raise Issue',
          style: TextStyle(fontSize: 32),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 20),
            SizedBox(height: 20),
            Container(
              color: Color(0xFFF7F3F5),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subject',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  SubjectContainer(
                    onSubjectChanged: (value) {
                      setState(() {
                        subject = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              color: Color(0xFFF7F3F5),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Issue Raised',
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.all(16),
                    child: TextField(
                      maxLines: null,
                      onChanged: (value) {
                        setState(() {
                          issue = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Write your issue...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.1,
              child: ElevatedButton(
                onPressed: () {
                  uploadIssue();
                  printPosts(); // Call the uploadIssue method
                  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => dashboard(email : widget.email)),
    );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF023436),
                  // Set the button color to #023436
                ),
                child: Text('Upload'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class SubjectContainer extends StatelessWidget {
  final Function(String) onSubjectChanged;

  SubjectContainer({required this.onSubjectChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[200],
      child: TextField(
        onChanged: onSubjectChanged,
        decoration: InputDecoration(
          hintText: 'Subject',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

