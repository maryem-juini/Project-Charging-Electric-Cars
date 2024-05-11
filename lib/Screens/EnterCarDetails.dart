import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Screens/SelectCar.dart';
import 'package:project/Screens/enablelocation.dart';

class EnterCarDetailsPage extends StatefulWidget {
  final String make;
  final String model;

  EnterCarDetailsPage({required this.make, required this.model});

  @override
  _EnterCarDetailsPageState createState() => _EnterCarDetailsPageState();
}

class _EnterCarDetailsPageState extends State<EnterCarDetailsPage> {
  int? _selectedValue;
  FocusNode _focusNode1 = FocusNode();
  bool _isFocused1 = false;
  FocusNode _focusNode2 = FocusNode();
  bool _isFocused2 = false;
    late String? userId;
     late TextEditingController _chassisNumberController;
  late TextEditingController _licensePlateNumberController;

  Future<String?> getCurrentUserId() async {
    // Get the current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;
    // Return the user's ID or null if user is not logged in
    return user?.uid;
  }

  @override
  void initState() {
    super.initState();
     getCurrentUserId().then((id) {
      setState(() {
        userId = id;
      });
    });
    _chassisNumberController = TextEditingController(); // Initialize chassis number controller
    _licensePlateNumberController = TextEditingController();
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

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _chassisNumberController.dispose(); // Dispose chassis number controller
    _licensePlateNumberController.dispose(); 
    super.dispose();
  }
  void _saveCarDetails() async {
  try {
    // Get the current user ID
    String? userId = await getCurrentUserId();

    if (userId != null) {
      // Add the car details to Firestore
  
      await FirebaseFirestore.instance.collection('MyCar').add({
        'userId': userId,
        'make': widget.make,
        'model': widget.model,
        'chassisNumber': _chassisNumberController.text,
        'licensePlateNumber': _licensePlateNumberController.text,
        // Add more fields as needed
      });

      // Navigate back or show a success message
    } else {
      // Handle the case when the user is not logged in
    }
  } catch (error) {
    print('Error saving car details: $error');
    // Handle the error
  }
}


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

  
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Enter Your Car Details',
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
             Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Select(),
                          ),
                        );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container( 
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/booking-success.png',width: size.width*0.35,height: size.height*0.35,),
              TextField(
                controller: _chassisNumberController,
                focusNode: _focusNode1,
                cursorColor: Color(0xFFFBAA1B),
                decoration: InputDecoration(
                  labelText: 'Chassis Number',
                  labelStyle: TextStyle(
                    color: _isFocused1 ? Color(0xFFFBAA1B) : Colors.grey,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.warning_rounded,
                    size: 20,
                    color: Color.fromARGB(255, 146, 149, 154),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Please enter a valid input ! (17 Characters )",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 146, 149, 154),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              TextField(
                controller: _licensePlateNumberController,
                focusNode: _focusNode2,
                cursorColor: Color(0xFFFBAA1B),
                decoration: InputDecoration(
                  labelText: 'Licence Plate Number',
                  labelStyle: TextStyle(
                    color: _isFocused2 ? Color(0xFFFBAA1B) : Colors.grey,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.warning_rounded,
                    size: 20,
                    color: Color.fromARGB(255, 146, 149, 154),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Please enter a valid input  ! (10 Characters )",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 146, 149, 154),
                    ),
                  )
                ],
              ),
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(top: size.height * .05),
                child: Container(
                  width: size.width * 0.3,
                  height: size.height * 0.07,
                  child: ElevatedButton(
                    onPressed: (){_saveCarDetails; 
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => enableLocation(),
                          ),
                        );
                    },
                    child: Text(
                      "Finish",
                      style: TextStyle(
                        fontFamily: 'Poppins',
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
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
