import 'package:flutter/material.dart';
import 'package:Deshatan/MyProfile.dart';
import 'package:Deshatan/Profile.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
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
  Future<List<Map<String, dynamic>>> getUserProfilesByEmail(String email) async {
    try {
      CollectionReference usersCollection = _firestore.collection('userdata');
      QuerySnapshot snapshot = await usersCollection.where('email', isEqualTo: email).get();

      return snapshot.docs.map((doc) {
        return {
          'phonenumber': doc['phoneNumber'],
          'description': doc['description'],
        };
      }).toList();
    } catch (e) {
      print('Error getting user profiles: $e');
      return []; // Return an empty list or handle the error appropriately
    }
  }


  Future<void> updateUserProfile(String email, String phoneNumber, String description) async {
    try {
      CollectionReference usersCollection = _firestore.collection('userdata');
      QuerySnapshot snapshot = await usersCollection.where('email', isEqualTo: email).get();

      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = snapshot.docs.first;
        String docId = userDoc.id;

        await usersCollection.doc(docId).update({
          'phoneNumber': phoneNumber,
          'description': description,
        });

        print('User profile updated successfully.');
      } else {
        print('User with the specified email not found.');
      }
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

}

class EditProfile extends StatefulWidget {
  final String email;

  EditProfile({required this.email});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String firstName = ' ';
  String lastName = ' ';
  String phonenumber = "Enter Phone Number";
  String Description = "Enter Description";
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        
        backgroundColor: Color(0xFF023436),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Cover Photo',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 155.0,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    'images/girl.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to a different screen here
                  // Example:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfile(email : widget.email)),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Photo',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Icon(
                      Icons.camera_alt,
                      size: 24.0,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Profile Photo',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                height: 94,
                width: 94,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(47),
                  child: Image.asset(
                    'images/OIP.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to a different screen here
                  // Example:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfile(email: widget.email)),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Photo',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Icon(
                      Icons.camera_alt,
                      size: 24.0,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              ExpansionTile(
                title: Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: firstName+" "+lastName,
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    
                  ),
                ],
              ),
        

              ExpansionTile(
                title: Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      filled: false,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    controller: TextEditingController(),
                  ),
                ],
              ),

              // Add more ExpansionTile widgets for additional fields
              ExpansionTile(
                title: Text(
                  'E-mail',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: widget.email,
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    controller: TextEditingController(),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Description',
                      filled: false,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    controller: TextEditingController(),
                  ),
                ],
              ),
              // Add more ExpansionTile widgets as needed

              SizedBox(height: 16.0),
              ElevatedButton(
  onPressed: () {
    // Save the form data
    DatabaseHelper().updateUserProfile(widget.email,phonenumber,Description);

    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfile(email : widget.email)),
                    );
  },
  style: ElevatedButton.styleFrom(
    primary: Color(0xFF023436), // Specify the desired button color
    minimumSize: Size(double.infinity, 50), // Set the button width to match the parent
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Set the border radius to 30
    ),

  ),
  child: Text('Save Changes'),
),

            ],
          ),
        ),
      ),
    );
  }
}

