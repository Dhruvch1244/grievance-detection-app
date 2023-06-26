import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'loginpage.dart';
import 'index.dart';
import 'signup.dart';
import 'Dashboard.dart';
import 'upload.dart';
import 'Profile.dart';
import 'MyProfile.dart';
import 'EditProfile.dart';
import 'Grevience.dart';
import 'News.dart';
import 'Report.dart';
import 'changepassword.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

// This is the main function that runs the Flutter application.
// It initializes Firebase and starts the app by running the MyApp widget.
Future<void> main() async {
  // Ensure that the Flutter binding is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase using the default options for the current platform.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the MyApp widget as the root of the Flutter app.
  runApp(const MyApp());
}

// The MyApp widget is the root of the Flutter application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set the system UI overlay style, making the status bar transparent.
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    // Return the MaterialApp widget, which configures the app's theme,
    // title, initial route, and route mappings.
    return MaterialApp(
      // Set the app's theme data, including the font family.
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),

      // Set the app's title.
      title: 'Deshatan',

      // Set the initial route of the app and define route mappings.
      initialRoute: '/',
      routes: {
        '/': (context) => const IndexPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/dashboard': (context) => dashboard(email: 'Advika@gmail.com'),
        '/upload': (context) => Upload(email: '12'),
        '/profile': (context) => ProfilePage(username: 'Advika'),
        '/MyProfile': (context) => MyProfile(email: '12'),
        '/EditProfile': (context) => const EditProfile(email: '12'),
        '/Grevience': (context) => Grievance(),
        '/News': (context) => News(),
        '/Report': (context) => ReportIncidentScreen(),
        '/changep': (context) => ChangePasswordScreen(),
      },
    );
  }
}
