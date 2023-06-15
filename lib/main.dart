import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'loginpage.dart';
import 'index.dart';
import 'signup.dart';
import 'Dashboard.dart';
import 'upload.dart';
import 'Profile.dart';

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
      title: 'Deshatan',
      initialRoute: '/',
      routes: {
        '/': (context) => IndexPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/dashboard' : (context) =>dashboard(),
        '/upload' : (context) => Upload(),
        '/profile' : (context) => ProfilePage(),
      },
    );
  }
}