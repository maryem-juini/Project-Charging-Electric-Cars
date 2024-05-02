import 'package:flutter/material.dart';
import 'package:flutter_verification_code_field/flutter_verification_code_field.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
       appBar :  AppBar(
          elevation: 0,
          title: Text(
            'OTP Verification ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF06094C),
              fontSize: 25
            ),
          ),
          backgroundColor: Colors.white,
          leading: InkWell(
                  child:
                      Icon(Icons.arrow_back_ios, color: Color(0xFF06094C)),
                  onTap: () {},
                ),),
        body: VerificationCodeField(
    
      length: 5,
      onFilled: (value) => print(value),
      size: Size(30, 60),
      spaceBetween: 16,
      matchingPattern: RegExp(r'^\d+$'),
    )
      ) , ) ;
  }
}