import 'package:flutter/material.dart';

class HeaderPage extends StatelessWidget implements PreferredSizeWidget {
  const HeaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppBar(
      title: Image.asset('assets/logo-dark-large.png',
          width: size.width * 0.3, height: size.height * 0.3),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); 
}