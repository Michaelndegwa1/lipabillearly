import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _verificationId;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter your phone number:',
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '+1234567890',
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
              onPressed: _sendOTP,
              child: Text('Send OTP'),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: _smsCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
              onPressed: _signInWithOTP,
              child: Text('Submit'),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(errorMessage, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }

  void _sendOTP() async {
    String phoneNumber = _phoneNumberController.text.trim();
    if (phoneNumber.isNotEmpty) {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          _signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            errorMessage = 'Failed to verify phone number: ${e.message}';
          });
        },
        codeSent: (String verificationId, [int? resendToken]) {
          setState(() {
            _verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } else {
      setState(() {
        errorMessage = 'Please enter a valid phone number.';
      });
    }
  }

  void _signInWithOTP() async {
    String smsCode = _smsCodeController.text.trim();
    if (smsCode.isNotEmpty) {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );
      _signInWithCredential(credential);
    } else {
      setState(() {
        errorMessage = 'Please enter OTP.';
      });
    }
  }

  void _signInWithCredential(PhoneAuthCredential credential) async {
    try {
      final result = await _auth.signInWithCredential(credential);
      final user = result.user;
      if (user != null) {
        // Do something with the signed-in user
        // For example, navigate to home screen
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = 'Failed to sign in: ${e.message}';
      });
    }
  }
}
