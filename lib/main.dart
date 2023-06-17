import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'loginpage.dart';
import 'index.dart';
import 'signup.dart';
import 'Dashboard.dart'; // Update import statement
import 'upload.dart';
import 'Profile.dart'; // Update import statement
import 'MyProfile.dart';
import 'EditProfile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),

      title: 'Deshatan',
      initialRoute: '/',
      routes: {
        '/': (context) => IndexPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/dashboard': (context) => dashboard(), // Update route name
        '/upload': (context) => Upload(),
        '/profile': (context) => ProfilePage(username: 'Advika'),
        '/MyProfile' : (context) => MyProfile(),
        '/EditProfile' : (context) => EditProfile(),
      },
    );
  }
}
