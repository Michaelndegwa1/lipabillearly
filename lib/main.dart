import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'exports.dart';

void main() async {
  // Initializes the Firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Runs the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Your app code here
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}
