import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/phone_number.dart';
import 'package:flutter_verification_code_field/flutter_verification_code_field.dart';
import 'package:project/Provider/UserProvider.dart';
import 'package:project/Screens/CompleteProfile.dart';
import 'package:provider/provider.dart';

class OTP extends StatefulWidget {
  String verificationId;
  PhoneNumber phoneNumber; // Renamed from _phoneNumber
  OTP({Key? key, required this.verificationId, required this.phoneNumber}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  late String _verificationCode = ''; // Initialize verification code
  Future<void> resendCode() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber.completeNumber, // Use _phoneNumber for phone number
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print('Resend Code Failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) async {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Verification code sent.'),
            ),
          );
          // Update verificationId if needed
          setState(() {
            widget.verificationId = verificationId;
          });
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print('Failed to resend code: $e');
    }
  }


  Future<void> verifyCode() async {
    try {

      if (_verificationCode.isNotEmpty) {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: _verificationCode,
        );
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        String uid = userCredential.user!.uid;
        Provider.of<UserProvider>(context, listen: false).setUserId(uid);

        final FirebaseFirestore _firestore = FirebaseFirestore.instance;
        await _firestore.collection('Users').doc(uid).set({
          'Phone_Number': widget.phoneNumber.completeNumber,
        });

        // Navigate to the next screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>CompleteProfilePage()),
        );
      } else {
        // Show error message if verification code is empty
        showAlertDialog('Error', 'Please enter the verification code.');
      }
    } on FirebaseAuthException catch (e) {
      print('Failed to verify code: $e');
      // Handle specific error cases
      if (e.code == 'invalid-verification-code') {
        // Show alert dialog if verification code is invalid
        showAlertDialog(
            'Error', 'Invalid verification code. Please try again.');
      } else {
        // Show alert dialog for other error cases
        showAlertDialog('Error', 'An error occurred while verifying the code.');
      }
    }
  }

  void showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the AlertDialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'OTP Verification ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF06094C),
                  fontSize: 25),
            ),
            backgroundColor: Colors.white,
            leading: InkWell(
              child: Icon(Icons.arrow_back_ios, color: Color(0xFF06094C)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            children: [
              Text(
                'Enter the verification code we just sent to your number.',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              VerificationCodeField(
                length: 6,
                onFilled: (value) {
                  _verificationCode = value; // Update verification code
                },
                size: Size(30, 60),
                spaceBetween: 16,
                matchingPattern: RegExp(r'^\d+$'),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: size.height * .09),
                child: ElevatedButton(
                  onPressed: () {
                    verifyCode();
                  },
                  child: Text("Verify"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Color(0xFFFBAA1B);
                        }
                        return Color(0xFF06094C);
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Color(0xFF06094C);
                        }
                        return Color(0xFFFBAA1B);
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        
                      ),
                    ),
                    minimumSize: MaterialStateProperty.resolveWith<Size>(
                    (Set<MaterialState> states) {
                      return Size(size.width * 0.5, size.height * 0.07);
                    },
                  ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code ?",
                    style: TextStyle(
                      color: Color.fromARGB(255, 146, 149, 154),
                      fontSize: size.width * 0.03,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                    resendCode();
                  },
                    child: Text(
                      "Resend Code",
                      style: TextStyle(
                        color: Color(0xFFFBAA1B),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}