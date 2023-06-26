import 'package:Deshatan/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<int> insertPost(Map<String, dynamic> post) async {
    try {
      CollectionReference postsCollection = _firestore.collection('posts');
      DocumentReference docRef = await postsCollection.add(post);
      return 1; // Return the inserted document ID or success indicator
    } catch (e) {
      return 0; // Return an error indicator
    }
  }

  Future<List<Map<String, dynamic>>> getPosts() async {
    try {
      CollectionReference postsCollection = _firestore.collection('posts');
      QuerySnapshot snapshot = await postsCollection.get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      return []; // Return an empty list or handle the error appropriately
    }
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

  Future<Map<String, dynamic>> getUserByEmail(String email) async {
    try {
      CollectionReference usersCollection = _firestore.collection('users');
      QuerySnapshot snapshot =
          await usersCollection.where('email', isEqualTo: email).limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data() as Map<String, dynamic>;
      }
      return {}; // Return an empty map if no user is found
    } catch (e) {
      return {}; // Return an empty map or handle the error appropriately
    }
  }

  Future<void> deleteAllPosts() async {
    try {
      CollectionReference postsCollection = _firestore.collection('posts');
      QuerySnapshot snapshot = await postsCollection.get();
      List<Future<void>> deleteFutures = [];
      for (DocumentSnapshot doc in snapshot.docs) {
        deleteFutures.add(doc.reference.delete());
      }
      await Future.wait(deleteFutures);
    } catch (e) {
      return;
    }
  }
}

class Upload extends StatefulWidget {
  final String email;

  const Upload({required this.email});

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF023436),
        title: const Text(
          'Raise Issue',
          style: TextStyle(fontSize: 32),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Container(
              color: const Color(0xFFF7F3F5),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Subject',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
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
            const SizedBox(height: 20),
            Container(
              color: const Color(0xFFF7F3F5),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Issue Raised',
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      maxLines: null,
                      onChanged: (value) {
                        setState(() {
                          issue = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Write your issue...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.1,
              child: ElevatedButton(
                onPressed: () {
                  uploadIssue();
                  printPosts(); // Call the uploadIssue method
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => dashboard(email: widget.email)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF023436),
                  // Set the button color to #023436
                ),
                child: const Text('Upload'),
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

  const SubjectContainer({super.key, required this.onSubjectChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[200],
      child: TextField(
        onChanged: onSubjectChanged,
        decoration: const InputDecoration(
          hintText: 'Subject',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
