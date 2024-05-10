import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Provider/UserProvider.dart';
import 'package:project/Screens/HomePage.dart';
import 'package:project/Screens/SignUp.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  FocusNode _focusNode1 = FocusNode();
  bool _isFocused1 = false;
  FocusNode _focusNode2 = FocusNode();
  bool _isFocused2 = false;
  bool _isChecked = false;
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {
        _isFocused1 = _focusNode1.hasFocus;
      });
    });
    _focusNode2.addListener(() {
      setState(() {
        _isFocused2 = _focusNode2.hasFocus;
      });
    });
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> logIn() async {
    String email = _emailController.text;
    print(email);
    String password = _passwordController.text;

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('Mail_Address', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        String storedPassword = documentSnapshot['Password'];
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        String uid = documentSnapshot['Id_User'];
        Provider.of<UserProvider>(context, listen: false).setUserId(uid);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        print('No user found with the provided email');
      }
    } catch (e) {
      print('Failed to log in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo-dark.png',
              width: size.width * .35,
              height: size.height * .35,
            ),
            TextField(
              controller: _emailController,
              focusNode: _focusNode1,
              cursorColor: Color(0xFFFBAA1B),
              decoration: InputDecoration(
                labelText: 'Mail Adress',
                labelStyle: TextStyle(
                  color: _isFocused1
                      ? Color(0xFFFBAA1B)
                      : Colors.grey, // Change these to your desired colors
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              focusNode: _focusNode2,
              cursorColor: Color(0xFFFBAA1B),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: _isFocused2 ? Color(0xFFFBAA1B) : Colors.grey,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                child: Text('Forgot Password?',
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Checkbox(
                value: _isChecked,
                activeColor: Color(0xFFFBAA1B),
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
              ),
              Text(
                "Remember Me",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ]),
            SizedBox(
              height: 20,
            ),
            Container(
              width: size.width * .35,
              height: size.height * .06,
              child: ElevatedButton(
                onPressed: logIn,
                child: Text("Log In"),
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
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account ?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 146, 149, 154),
                    fontSize: size.width * 0.03,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Signup(),
                    ),
                  ),
                  child: Text(
                    "Sign Up",
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
