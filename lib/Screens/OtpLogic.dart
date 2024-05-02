import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String _phoneNumber = '';
  String _verificationId = '';

  Future<void> verifyPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      // Automatically sign in the user when verification is done using auto-retrieved credentials.
      await FirebaseAuth.instance.signInWithCredential(credential);
      // Navigate to the next screen or perform other actions.
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      // Handle verification failed error.
      print('Verification Failed: ${e.message}');
    };

    final PhoneCodeSent codeSent =
        (String verificationId, int? resendToken) {
      // Save the verification ID for later use.
      setState(() {
        _verificationId = verificationId;
      });
      // Navigate to OTP input screen.
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      // Auto-retrieval timeout callback.
      // Handle timeouts here.
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      timeout: const Duration(seconds: 60),
      // Set a timeout of 60 seconds.
      verificationId: _verificationId,
      // Pass the verification ID to auto-retrieve OTP on re-authentication.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _phoneNumber = value;
                });
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                verifyPhoneNumber();
              },
              child: Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OTPScreen(),
  ));
}