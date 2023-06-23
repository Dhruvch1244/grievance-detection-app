import 'package:flutter/material.dart';
import 'package:Deshatan/EditProfile.dart';
import 'package:Deshatan/upload.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:Deshatan/Settings.dart';
import 'package:Deshatan/Dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  DatabaseHelper.internal();
  Future<Map<String, dynamic>> getUserByEmail(String email) async {
    final CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

    QuerySnapshot usersSnapshot = await usersRef.where('email', isEqualTo: email).limit(1).get();

    if (usersSnapshot.docs.isNotEmpty) {
      // Get the first document from the snapshot
      QueryDocumentSnapshot userDoc = usersSnapshot.docs.first;

      // Convert the document data to a Map
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      print(userDoc);
      return userData;
    }

    return {};
  }
  Future<void> updatePost(Map<String, dynamic> post) async {
    try {
      CollectionReference postsCollection = _firestore.collection('posts');
      DocumentReference docRef = postsCollection.doc(post['id']);
      await docRef.update(post);
    } catch (e) {
      print('Error updating post: $e');
    }
  }
  Future<List<Map<String, dynamic>>> getPostsByEmail(String email) async {
    try {
      CollectionReference postsCollection = _firestore.collection('posts');
      QuerySnapshot snapshot = await postsCollection.where('email', isEqualTo: email).get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error getting posts: $e');
      return []; // Return an empty list or handle the error appropriately
    }
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
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: DatabaseHelper().getPostsByEmail(widget.email), // Create an instance of DatabaseHelper and call getPosts()
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
