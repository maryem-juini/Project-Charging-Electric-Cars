import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});
  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  XFile? _image;
  String? _downloadUrl;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
      uploadImage(image);
    }
  }

  Future<void> uploadImage(XFile image) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("profile_pictures/${image.name}");
      UploadTask uploadTask = ref.putFile(File(image.path));

      await uploadTask.whenComplete(() async {
        final String downloadUrl = await ref.getDownloadURL();
        setState(() {
          _downloadUrl = downloadUrl;
        });
      });
    } catch (e) {
      print('Failed to upload image: $e');
    }
  }
  FocusNode _focusNode1 = FocusNode();
  bool _isFocused1 = false;
  FocusNode _focusNode2 = FocusNode();
  bool _isFocused2 = false;
  FocusNode _focusNode3 = FocusNode();
  bool _isFocused3 = false;
  
  @override
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
        _isFocused3 = _focusNode3.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
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
                'Complete Your Profile',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF06094C),
                    fontSize: 25)
              ),
              backgroundColor: Colors.white,
              leading: InkWell(
                child: Icon(Icons.arrow_back_ios, color: Color(0xFF06094C)),
                onTap: () {
                  Navigator.pop(context) ; 
                },
              ),
            ),
            body: Container(
              margin: EdgeInsets.all(40),
              child: Column(
                children: [
                  Text(
                    "Don't worry, only you can see your personal data. No one else will be able to see it.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF80807F),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Stack(
                    children: <Widget>[
                      Center(child: Image.asset("assets/profile.png")),
                      Positioned(
                        bottom: 25,
                        right: 180,
                        child: Container(
                          height: 10,
                          width: 10,
                          child:InkWell(
                            onTap: () {
                              pickImage();
                            },
                            child: Icon(Icons.edit_square, color: Color(0xFFFBAA1B), size: 30,),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    focusNode: _focusNode1,
                    cursorColor: Color(0xFFFBAA1B),
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(
                        color: _isFocused1
                            ? Color(0xFFFBAA1B)
                            : Colors
                                .grey, // Change these to your desired colors
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      labelStyle: TextStyle(
                        color: _isFocused3 ? Color(0xFFFBAA1B) : Colors.grey,
                      ),
                    ),
                    items: ['Male', 'Female'].map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize:
                                18, // Change this to your desired font size
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Do something with the selected value
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    focusNode: _focusNode2,
                    cursorColor: Color(0xFFFBAA1B),
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: TextStyle(
                        color: _isFocused2 ? Color(0xFFFBAA1B) : Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Next",
                        style: TextStyle(
                          fontSize: size.height * 0.03,
                        )),
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
                          borderRadius: BorderRadius.circular(
                              30.0), // Adjust the radius as needed
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
            )));
  }
}
