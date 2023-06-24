import 'package:flutter/material.dart';
import 'package:Deshatan/MyProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  DatabaseHelper.internal();
  Future<Map<String, dynamic>> getUserByEmail(String email) async {
    final CollectionReference usersRef = FirebaseFirestore.instance.collection('userdata');

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
  Future<String> getPhoneByEmail(String email) async {
    final CollectionReference usersRef = FirebaseFirestore.instance.collection('userdata');

    QuerySnapshot usersSnapshot = await usersRef.where('email', isEqualTo: email).limit(1).get();

    if (usersSnapshot.docs.isNotEmpty) {
      // Get the first document from the snapshot
      QueryDocumentSnapshot userDoc = usersSnapshot.docs.first;

      // Retrieve the phone number from the document data
      String phoneNumber = userDoc['phoneNumber'] ?? '';

      return phoneNumber;
    }

    return '';
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

      }
    } catch (e) {
      return;
    }
  }

}

class EditProfile extends StatefulWidget {
  final String email;

  const EditProfile({super.key, required this.email});

  @override
  _EditProfileState createState() {
    return _EditProfileState();
  }
}

class _EditProfileState extends State<EditProfile> {
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String description = '';
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    Map<String, dynamic> user = await DatabaseHelper().getUserByEmail(widget.email);
    if (user.isNotEmpty) {
      setState(() {
        firstName = user['name'];
        phoneNumber = user['phoneNumber'] ?? ''; // Set the initial value of phoneNumber
        description = user['description'] ?? ''; // Set the initial value of description
        phoneNumberController.text = phoneNumber; // Set the text in the phoneNumberController
        descriptionController.text = description; // Set the text in the descriptionController
      });
    }
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

    @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        
        backgroundColor: const Color(0xFF023436),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Cover Photo',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
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
                child: const Row(
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
              const SizedBox(height: 16.0),
              const Text(
                'Profile Photo',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
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
                child: const Row(
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
              const SizedBox(height: 16.0),
              ExpansionTile(
                title: const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  const SizedBox(height: 8.0),
                  Text(
                    "$firstName $lastName",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              ExpansionTile(
                title: const Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  const SizedBox(height: 8.0),
                  Text(
                    phoneNumber,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Edit Phone Number',
                      filled: false,
                      fillColor: Colors.grey[200],
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    controller: phoneNumberController,
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = value; // Update the phoneNumber variable
                      });
                    },
                  ),
                ],
              ),

              ExpansionTile(
                title: const Text(
                  'E-mail',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  const SizedBox(height: 8.0),
                  Text(
                    widget.email,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              ExpansionTile(
                title: const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  const SizedBox(height: 8.0),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Description',
                      filled: false,
                      fillColor: Colors.grey[200],
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    controller: descriptionController,
                    onChanged: (value) {
                      setState(() {
                        description = value; // Update the description variable
                      });
                    },
                  ),
                ],
              ),
              // Add more ExpansionTile widgets as needed

              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Save the form data
                  DatabaseHelper().updateUserProfile(widget.email, phoneNumber, description);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyProfile(email : widget.email)),
                  );
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF023436), // Specify the desired button color
                minimumSize: const Size(double.infinity, 50), // Set the button width to match the parent
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Set the border radius to 30
                ),

                ),
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

