import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String _phoneNumber = '';

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
        (String verificationId, int? resendToken) async {
      // Save the verification ID for later use.
      // Navigate to OTP input screen.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPInputScreen(verificationId),
        ),
      );
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

class OTPInputScreen extends StatefulWidget {
  final String verificationId;

  OTPInputScreen(this.verificationId);

  @override
  _OTPInputScreenState createState() => _OTPInputScreenState();
}

class _OTPInputScreenState extends State<OTPInputScreen> {
  String _otp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _otp = value;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call function to verify OTP
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}


