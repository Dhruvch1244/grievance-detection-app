import 'package:Deshatan/Grevience.dart';
import 'package:Deshatan/News.dart';
import 'package:flutter/material.dart';
import 'package:Deshatan/MyProfile.dart';
import 'Profile.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'upload.dart';
enum MenuOption {
  myProfile,
  grievances,
  news,
  reports,
  settings,
  report,
}

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
Future<void> updatePost(Map<String, dynamic> post) async {
    await initializeDatabase(); // Ensure the database is initialized
    final db = _database;

    await db.update(
      'posts',
      post,
      where: 'id = ?',
      whereArgs: [post['id']],
    );
  }


Future<Map<String, dynamic>> getUserByEmail(String email) async {
    Database? dbClient = await _database;
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


class dashboard extends StatefulWidget {
  final String email;

  dashboard({required this.email});

  @override
  _dashboardState createState() => _dashboardState();
}


class _dashboardState extends State<dashboard> {
  MenuOption _selectedOption = MenuOption.myProfile;
String firstName = 'JohnDoe';
  String lastName = '1234';

  @override
  void initState() {
    super.initState();
    fetchUserProfile('12');
  }
  Future<void> fetchUserProfile(email) async {
    Map<String, dynamic> user = await DatabaseHelper().getUserByEmail(email);
    if (user.isNotEmpty) {
      setState(() {
        firstName = user['firstName'];
        lastName = user['lastName'];
        print(firstName);
      });
    }
    else{
      print("NOT FOUND");
    }
  }
    @override

  Widget build(BuildContext context) {
    // Access the email using widget.email
    String email = widget.email;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF023436), // Custom color #023436
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            showMenuOptions(context);
          },
        ),
        title: Row(
          children: [
            SizedBox(width: 5),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigation logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfile(email : email)),
                );
              },
              child: CircleAvatar(
                backgroundImage: AssetImage('images/OIP.jpeg'),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    // Handle location icon click
                    // Add your logic here
                  },
                  child: Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Noida, UP',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
                    Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
  future: DatabaseHelper().getPosts(), // Create an instance of DatabaseHelper and call getPosts()
  builder: (context, snapshot) {

    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else if (snapshot.hasData) {
      final posts = snapshot.data!;

      return ListView(
  children: [
    for (int i = posts.length - 1; i >= 0; i--)
      Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF023436).withOpacity(1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        
        child: Post(
          
          title: posts[i]['title'],
          author: posts[i]['email'], // Assuming the email field stores the author name
          content: posts[i]['content'],
          upvotes: posts[i]['upvotes'],
        ),
      ),
  ],
);

    } else {
      return Text('No posts available.');
    }
  },
),

          ),
       
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to other page
          // Add your logic here
          Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Upload(email : widget.email)),
    );
        },
        backgroundColor: Colors.green, // Set the background color to green
        child: Icon(
          Icons.add,
          size: 48, // Increase the size of the icon
        ),
      ),
      
    );
  }

  void showMenuOptions(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Menu'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Profile'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = MenuOption.myProfile;
                  
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfile(email : widget.email)),
                    );
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.error),
              title: Text('Grievances'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = MenuOption.grievances;
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Grievance()),
                    );
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.article),
              title: Text('News'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = MenuOption.news;
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => News()),
                    );
                });
              },
            ),
            
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = MenuOption.settings;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.report),
              title: Text('Report'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = MenuOption.report;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}
}
class Post extends StatefulWidget {
  final String title;
  final String author;
  final String content;
  int upvotes;

  Post({
    required this.title,
    required this.author,
    required this.content,
    required this.upvotes,
  });

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  bool _isUpvoted = false;

  void _toggleUpvote() {
    setState(() {
      if (_isUpvoted) {
        widget.upvotes--;
      } else {
        widget.upvotes++;
      }
      _isUpvoted = !_isUpvoted;
    });

    // Update the upvote value in the database
    Map<String, dynamic> post = {
      'title': widget.title,
      'email': widget.author,
      'content': widget.content,
      'upvotes': widget.upvotes,
    };

    DatabaseHelper databaseHelper = DatabaseHelper();
    databaseHelper.updatePost(post);
  }

  @override
  Widget build(BuildContext context) {
    // Widget implementation

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage(username : widget.author)),
    );
  },
  child: Text(
    'Posted by u/${widget.author}',
    style: TextStyle(
      color: Colors.grey,
      fontStyle: FontStyle.italic,
    ),
  ),
),



          SizedBox(height: 8),
          Text(widget.content),
          SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                onTap: _toggleUpvote,
                child: Icon(
                  Icons.arrow_upward,
                  size: 20,
                  color: _isUpvoted ? Colors.green : null,
                ),
              ),
              SizedBox(width: 4),
              Text(widget.upvotes.toString()),
            ],
          ),
        ],
      ),
    );
  }
}