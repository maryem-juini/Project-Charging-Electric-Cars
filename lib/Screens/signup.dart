import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_intl_phone_field/phone_number.dart';
import 'package:project/Screens/LogIn.dart';
import 'package:project/Screens/ReadyCharge.dart';
import 'package:project/Screens/OTP.dart'; 

void main() {
  runApp(MaterialApp(
    home: Signup(),
  ));
}

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late PhoneNumber _phoneNumber = PhoneNumber(
      countryISOCode: 'TN',
      countryCode: '216',
      number: '0',
    );
  String _verificationId = '';

  Future<void> sendVerificationCode() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneNumber.completeNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReadyCharge()),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Verification Failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) async {
          setState(() {
            _verificationId = verificationId;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTP(verificationId: _verificationId, phoneNumber: _phoneNumber,), // Pass verification ID to OTP screen
            ),
          );
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print('Failed to verify phone number: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo-dark.png',
              width: size.width * .4,
              height: size.height * .4,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            SizedBox(
              width: size.width * .7,
              child: IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  setState(() {
                    _phoneNumber = phone;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: size.width * .05,
                vertical: size.height * .01,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_rounded,
                    semanticLabel:
                        "Please enter your phone number to receive a verification code for account access.",
                    size: size.width * 0.03,
                    color: Color.fromARGB(255, 146, 149, 154),
                  ),
                  Flexible(
                    child: Text(
                      "Please enter your phone number to receive a verification code for account access.",
                      style: TextStyle(
                        fontSize: size.width * 0.02,
                        color: Color.fromARGB(255, 146, 149, 154),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: size.width * .35,
              height: size.height * .06,
              margin: EdgeInsets.symmetric(vertical: size.height * .09),
              child: ElevatedButton(
                onPressed: () => sendVerificationCode(),
                child: Text("Send Code"),
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
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You have an account ?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 146, 149, 154),
                    fontSize: size.width * 0.03,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LogInPage(),
                    ),
                  ),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Color(0xFFFBAA1B),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
