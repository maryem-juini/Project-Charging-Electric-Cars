import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/Provider/UserProvider.dart';
import 'package:project/Screens/CompleteProfile.dart';
import 'package:project/Screens/EnterCarDetails.dart';
import 'package:project/Screens/LogIn.dart';
import 'package:project/Screens/ReadyCharge.dart';
import 'package:project/Screens/SelectCar.dart';
import 'package:project/Screens/SplashScreen.dart';
import 'package:project/Screens/bookPage.dart';
import 'package:project/Screens/enablelocation.dart';
import 'package:provider/provider.dart';
import 'package:project/Screens/SignUp.dart';
import 'package:project/DataBase/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 

    await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
      );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home:CompleteProfilePage(),
       // home:ReadyCharge(),
       home: SplashScreen(),
      // home:Signup(),
      ),
    );
  }
}