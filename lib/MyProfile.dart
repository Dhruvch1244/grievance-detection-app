import 'package:flutter/material.dart';
import 'package:Deshatan/EditProfile.dart';
import 'package:Deshatan/upload.dart';
import 'package:Deshatan/Settings.dart';
import 'package:Deshatan/Dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      return;
    }
  }
  Future<List<Map<String, dynamic>>> getPostsByEmail(String email) async {
    try {
      CollectionReference postsCollection = _firestore.collection('posts');
      QuerySnapshot snapshot = await postsCollection.where('email', isEqualTo: email).get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      return []; // Return an empty list or handle the error appropriately
    }
  }

}

class MyProfile extends StatefulWidget {
  final String email;

  const MyProfile({super.key, required this.email});

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
      });
    }
  }
  @override

  Widget build(BuildContext context) {
    String email = widget.email;
    return Scaffold(

      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: const Color(0xFF023436),
      ),
      body: Center(
        child: Column(
          children: [
                  const SizedBox(height: 40),

            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                      const SizedBox(height: 10),
                              Text(
                                firstName,
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => EditProfile(email: email)),
                                  );
                                },
                              ),
                                 ],
                          ),

                      const SizedBox(height: 10),
                      Text(
                        email,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Upload(email : widget.email)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF023436),
                ),
                child: const Text('Add Grievance'),
              ),

                    ],
                  ),
                        const SizedBox(width: 10),
                        Container(
                          margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                          width: 72,
                          height: 72,
                          decoration: const BoxDecoration(
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
                                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),

                                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: const BoxDecoration(
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

                                icon: const Icon(Icons.arrow_upward_outlined),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => dashboard(email: email)),
                                  );
                                },
                                iconSize: 45,
                                padding: const EdgeInsets.all(0),
                                constraints: const BoxConstraints(),
                                visualDensity: VisualDensity.compact,
                                alignment: Alignment.center,
                                splashRadius: 45,
                                highlightColor: Colors.transparent,
                                color: Colors.black,
                                splashColor: Colors.transparent,
                                enableFeedback: true,
                                tooltip: 'Upvote',
                              ),

                                  const Text('Upvotes'),
                                    ],
                                  ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.notifications),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                                    );
                                  },
                                  iconSize: 45,
                                  padding: const EdgeInsets.all(0),
                                  constraints: const BoxConstraints(),
                                  visualDensity: VisualDensity.compact,
                                  alignment: Alignment.center,
                                  splashRadius: 45,
                                  highlightColor: Colors.transparent,
                                  color: Colors.black,
                                  splashColor: Colors.transparent,
                                  enableFeedback: true,
                                  tooltip: 'Notifications',
                                ),

                            const Text('Notifications'),
                              ],
                            ),
                                  Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                                icon: const Icon(Icons.settings),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                                                  );
                                    },
                                    iconSize: 45,
                                    padding: const EdgeInsets.all(0),
                                    constraints: const BoxConstraints(),
                                    visualDensity: VisualDensity.compact,
                                    alignment: Alignment.center,
                                    splashRadius: 45,
                                    highlightColor: Colors.transparent,
                                    color: Colors.black,
                                    splashColor: Colors.transparent,
                                    enableFeedback: true,
                                    tooltip: 'Settings',
                                  ),

                                        const Text('Settings'),
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
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final posts = snapshot.data!;

                    return ListView(
                      children: [
                        for (int i = posts.length - 1; i >= 0; i--)
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF023436).withOpacity(1),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
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
                    return const Text('No posts available.');
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {

            },
            child: Text(
              'Posted by u/${widget.author}',
              style: const TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),



          const SizedBox(height: 8),
          Text(widget.content),
          const SizedBox(height: 8),
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
              const SizedBox(width: 4),
              Text(widget.upvotes.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
