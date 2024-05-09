import 'package:flutter/material.dart';
import 'package:project/Screens/MyBooking.dart';
import 'package:project/Screens/HomePage.dart';
import 'package:project/Screens/ProfilePage.dart';
import 'package:project/Screens/SearchPage.dart';

class BottomPage extends StatelessWidget {
  
  final int selectedIndex;

  const BottomPage({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Icon(
                Icons.home_rounded,
                size: 35,
                color:
                    selectedIndex == 0 ? Color(0xffFBAA1B) : Color(0xFF06094C),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: Icon(Icons.search,
                  size: 35,
                  color: selectedIndex == 1
                      ? Color(0xffFBAA1B)
                      : Color(0xFF06094C)),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingPage()),
                );
              },
              child: Icon(Icons.book,
                  size: 35,
                  color: selectedIndex == 2
                      ? Color(0xffFBAA1B)
                      : Color(0xFF06094C)),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Icon(Icons.person,
                  size: 35,
                  color: selectedIndex == 3
                      ? Color(0xffFBAA1B)
                      : Color(0xFF06094C)),
            ),
          ],
        ),
      ),
    );
  }
}
