import 'package:estatepay/screens/AuthenticationScreens/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          _signOut();
        },
        child: Text("log out"),
      )),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Fluttertoast.showToast(msg: "Logout Succesfully");
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => SignInPage()));
  }
}
