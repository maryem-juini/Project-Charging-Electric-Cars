import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/Screens/EnterCarDetails.dart';
import 'package:project/Screens/OtpLogic.dart';
import 'package:project/Screens/SelectCar.dart';
import 'package:project/Screens/bookingSuccess.dart';
import 'package:project/Screens/database.dart';
import 'package:project/Screens/enablelocation.dart';
import 'package:project/Screens/forgetPassword.dart';
import 'package:project/Screens/newpassword.dart';
import 'package:project/Screens/signup.dart';
import 'package:project/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 

    await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
      );
  
  
  runApp(MyApp());
}

