import 'package:flutter/material.dart';
import 'package:Deshatan/MyProfile.dart';
import 'package:Deshatan/Profile.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
class EditProfile extends StatefulWidget {
  final String email;

  EditProfile({required this.email});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
    String firstName = 'JohnDoe';
  String lastName = '1234';

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
              // Add more ExpansionTile widgets as needed

              SizedBox(height: 16.0),
              ElevatedButton(
  onPressed: () {
    // Save the form data
    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfile(email : '12')),
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

