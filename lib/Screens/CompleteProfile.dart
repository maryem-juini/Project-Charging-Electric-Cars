import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/Provider/UserProvider.dart';
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
                decoration: InputDecoration(
                  labelText: 'Full Name',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Mail Address',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Your Password',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
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
                    return; // Exit function early
                  }

                  // Passwords match, proceed with sign-up
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    // Get the user ID from the provider
                    String? userId =
                        Provider.of<UserProvider>(context, listen: false)
                            .userId;

                    // Update the user profile information in Firestore
                    try {
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(userId)
                          .update({
                        'Full_Name': _fullNameController.text,
                        'Mail_Address': _emailController.text,
                        'Password': _passwordController.text,
                        // Add other profile information here if needed
                      });

                      // Successfully updated profile information
                      // You can navigate to the next screen or perform any other actions needed.
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

                    // Successfully signed up, you can navigate to the next screen
                    // or perform any other actions needed after sign-up.
                  } catch (e) {
                    // Error occurred during sign-up, show error message
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
