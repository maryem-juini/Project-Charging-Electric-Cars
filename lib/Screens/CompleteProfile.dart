import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/Provider/UserProvider.dart';
import 'package:project/Screens/ReadyCharge.dart';
import 'package:provider/provider.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({Key? key}) : super(key: key);

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    FocusNode _focusNode1 = FocusNode();
    bool _isFocused1 = false;
    FocusNode _focusNode2 = FocusNode();
    bool _isFocused2 = false;
    FocusNode _focusNode3 = FocusNode();
    bool _isFocused3 = false;
    FocusNode _focusNode4 = FocusNode();
    bool _isFocused4 = false;
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
      _focusNode3.addListener(() {
        setState(() {
          _isFocused1 = _focusNode1.hasFocus;
        });
      });
      _focusNode4.addListener(() {
        setState(() {
          _isFocused1 = _focusNode1.hasFocus;
        });
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Complete Your Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF06094C),
              fontSize: 25,
            ),
          ),
          backgroundColor: Colors.white,
          leading: InkWell(
            child: Icon(Icons.arrow_back_ios, color: Color(0xFF06094C)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo-dark.png',
                width: size.width * .25,
                height: size.height * .25,
              ),
              TextField(
                controller: _fullNameController,
                 focusNode: _focusNode4,
                        cursorColor: Color(0xFFFBAA1B),
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                            color:
                                _isFocused4 ? Color(0xFFFBAA1B) : Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                          ),
                        ),

              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                 focusNode: _focusNode3,
                        cursorColor: Color(0xFFFBAA1B),
                        decoration: InputDecoration(
                          labelText: 'Mail Address',
                          labelStyle: TextStyle(
                            color:
                                _isFocused3 ? Color(0xFFFBAA1B) : Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                          ),
                        ),

              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                controller: _passwordController,
                 focusNode: _focusNode2,
                        cursorColor: Color(0xFFFBAA1B),
                        decoration: InputDecoration(
                          labelText: 'Your Password',
                          labelStyle: TextStyle(
                            color:
                                _isFocused2 ? Color(0xFFFBAA1B) : Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                          ),
                        ),

              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                controller: _confirmPasswordController,
                 focusNode: _focusNode1,
                        cursorColor: Color(0xFFFBAA1B),
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                            color:
                                _isFocused1 ? Color(0xFFFBAA1B) : Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                          ),
                        ),

              ),
              SizedBox(height: size.height * .1),
              ElevatedButton(
                onPressed: () async {
                  // Check if passwords match
                  if (_passwordController.text !=
                      _confirmPasswordController.text) {
                    // Passwords don't match, show error message
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Password Mismatch'),
                          content: Text('The passwords do not match.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }

                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    String? userId =
                        Provider.of<UserProvider>(context, listen: false)
                            .userId;
                    String uid = userCredential.user!.uid;
                    Provider.of<UserProvider>(context, listen: false)
                        .setUserId(uid);

                    try {
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(userId)
                          .update({
                        'Full_Name': _fullNameController.text,
                        'Mail_Address': _emailController.text,
                        'Password': _passwordController.text,
                        'Id_User': uid,

                      });
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReadyCharge(),
                          ),
                        );
                    } catch (e) {
                      // Error occurred while updating profile information, show error message
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Profile Update Failed'),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }

                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Sign-up Failed'),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: size.height * 0.03,
                  ),
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
