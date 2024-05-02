import 'package:flutter/material.dart';
import 'package:project/Screens/Bottom.dart';
import 'package:project/Screens/Header.dart';
import 'package:project/Screens/calendar.dart';
import 'package:project/Screens/station.dart';

class Book extends StatefulWidget {
  const Book({super.key});

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SingleChildScrollView(
          child: Scaffold(
            appBar: HeaderPage(),
            bottomNavigationBar: BottomPage(selectedIndex: 0),
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.02),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () { 
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Station()));
                         },
                        icon:  Icon(
                          Icons.arrow_back,
                          color: Color(0xFF06094C),
                          
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: size.width * .04),
                        child: Text(
                          "Booking",
                          style: TextStyle(
                            color: Color(0xFF06094C),
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                    
                  ),
                ),
                Expanded(
                  child: Container(
                    child: BookingCalendarDemoApp(),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
