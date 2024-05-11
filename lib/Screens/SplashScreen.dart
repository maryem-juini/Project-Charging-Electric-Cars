import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:project/Screens/login.dart';
import 'package:project/Screens/signup.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.gif(
          useImmersiveMode: true,
          gifPath: 'assets/logo-white.png',
          gifWidth: 269,
          gifHeight: 474,
          nextScreen: const LogInPage(),
          duration: const Duration(milliseconds: 3000),
          backgroundColor: Color(0xFF06094C),
        );
  }
}
