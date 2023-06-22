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
import 'Grevience.dart';
import 'News.dart';
import 'Report.dart';
import 'changepassword.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Import the firebase_app_check plugin
import 'package:firebase_app_check/firebase_app_check.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        '/dashboard': (context) => dashboard(email : 'Advika@gmail.com'), // Update route name
        '/upload': (context) => Upload(email : '12'),
        '/profile': (context) => ProfilePage(username: 'Advika'),
        '/MyProfile' : (context) => MyProfile(email : '12'),
        '/EditProfile' : (context) => EditProfile(email : '12'),
        '/Grevience' : (context) => Grievance(),
        '/News' : (context) => News(),
        '/Report' : (context) => ReportIncidentScreen(),
        '/changep' : (context) => ChangePasswordScreen(),
      },
    );
  }
}