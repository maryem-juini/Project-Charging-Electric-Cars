

import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_intl_phone_field/phone_number.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  PhoneNumber otp = PhoneNumber(countryISOCode: 'TN', countryCode: '216', number: '0') ;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
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
                    otp=phone ; 
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * .05, vertical: size.height * .01),
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
                    ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: size.height * .09),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Send Code",
                    
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Color(0xFFFBAA1B) ;       
                        }
                        return Color(0xFF06094C); 
                      },
                    ),
                   foregroundColor: MaterialStateProperty.resolveWith( 
                     (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Color(0xFF06094C) ;       
                        }
                        return Color(0xFFFBAA1B) ; 
                      }, ),
                 
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            5.0), // Adjust the radius as needed
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
                    // onTap: ()=> Navigator.push(context, ),
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
      ),
    );
  }
}
