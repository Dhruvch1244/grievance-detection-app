import 'package:flutter/material.dart';
import 'package:Deshatan/EditProfile.dart';
import 'package:Deshatan/upload.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:Deshatan/Settings.dart';
import 'package:Deshatan/Dashboard.dart';

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

class MyProfile extends StatefulWidget {
  final String email;

  MyProfile({required this.email});

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  String name = 'John Doe';
  String firstName = 'JohnDoe';
  String lastName = '1234';

  List<String> grievances = [];


  void addGrievance(String grievance) {
    setState(() {
      grievances.add(grievance);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }
  Future<void> fetchUserProfile() async {
    Map<String, dynamic> user = await DatabaseHelper().getUserByEmail(widget.email);
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
    String email = widget.email;
    print(email);
    return Scaffold(

      appBar: AppBar(
        title: Text('My Profile'),
        backgroundColor: Color(0xFF023436),
      ),
      body: Center(
        child: Column(
          children: [
                  SizedBox(height: 40),

            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                      SizedBox(height: 10),
                              Text(
                                '$firstName',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => EditProfile(email: email)),
                                  );
                                },
                              ),
                                 ],
                          ),

                      SizedBox(height: 10),
                      Text(
                        '$email',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Upload(email : widget.email)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF023436),
                ),
                child: Text('Add Grievance'),
              ),

                    ],
                  ),
                        SizedBox(width: 10),
                        Container(
                          margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('images/OIP.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                      Container(
                                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),

                                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                                border: Border(
                              top: BorderSide(width: 1,color: Colors.grey),
                              bottom: BorderSide(width: 1,color: Colors.grey),
                            ),
                          ),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(

                                icon: Icon(Icons.arrow_upward_outlined),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => dashboard(email: email)),
                                  );
                                },
                                iconSize: 45,
                                padding: EdgeInsets.all(0),
                                constraints: BoxConstraints(),
                                visualDensity: VisualDensity.compact,
                                alignment: Alignment.center,
                                splashRadius: 45,
                                highlightColor: Colors.transparent,
                                color: Colors.black,
                                splashColor: Colors.transparent,
                                enableFeedback: true,
                                tooltip: 'Upvote',
                              ),

                                  Text('Upvotes'),
                                    ],
                                  ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.notifications),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                                    );
                                  },
                                  iconSize: 45,
                                  padding: EdgeInsets.all(0),
                                  constraints: BoxConstraints(),
                                  visualDensity: VisualDensity.compact,
                                  alignment: Alignment.center,
                                  splashRadius: 45,
                                  highlightColor: Colors.transparent,
                                  color: Colors.black,
                                  splashColor: Colors.transparent,
                                  enableFeedback: true,
                                  tooltip: 'Notifications',
                                ),

                            Text('Notifications'),
                              ],
                            ),
                                  Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                                icon: Icon(Icons.settings),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                                                  );
                                    },
                                    iconSize: 45,
                                    padding: EdgeInsets.all(0),
                                    constraints: BoxConstraints(),
                                    visualDensity: VisualDensity.compact,
                                    alignment: Alignment.center,
                                    splashRadius: 45,
                                    highlightColor: Colors.transparent,
                                    color: Colors.black,
                                    splashColor: Colors.transparent,
                                    enableFeedback: true,
                                    tooltip: 'Settings',
                                  ),

                                        Text('Settings'),
                                  ],
                                ),
                  ],
                ),
              ),
  Expanded(
            child: ListView(
              children: [
                Container(

          margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
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
                    title: 'Streetlight Broken',
                    author: 'JohnDoe123',
                    content: 'The court in front of Silver Hall is poorly lit due to multiple incidents of broken lights',
                    upvotes: 42,
                  ),
                ),
                Container(
          margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
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
                    title: 'Roadblock',
                    author: 'JaneSmith',
                    content: 'An ongoing construction has rendered the road leading to the Okhla Bird Sanctuary unusable',
                    upvotes: 75,
                  ),
                ),
                Container(
          margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
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
                    title: 'Security Risk',
                    author: 'DevDebate',
                    content: 'Many cases of mugging reported in Sector 74, extra caution is essential',
                    upvotes: 53,
                  ),
                ),
                Container(
          margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
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
                    title: 'Water Supply Problem',
                    author: 'SupDhru',
                    content: 'Water is being cut for 3 hours in afternoon daily.',
                    upvotes: 53,
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
      ),
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
  }

  @override
  Widget build(BuildContext context) {
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
          Text(
            'Posted by u/${widget.author}',
            style: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
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
