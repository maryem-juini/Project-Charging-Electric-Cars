import 'package:flutter/material.dart';
import 'package:project/Screens/Bottom.dart';
import 'package:project/Screens/Header.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  bool _isSwitched = false; // Moved to be a member variable

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: HeaderPage(),
        bottomNavigationBar: BottomPage(selectedIndex: 2),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(25, 15, 25, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back, color: Color(0xFF06094C), size: 30),
                  Text('My Bookings',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF06094C),
                      )),
                  SizedBox(width: size.width * 0.4),
                  Icon(Icons.search, color: Color(0xFF06094C), size: 30),
                ],
              ),
            ),
            Expanded(
              child: ContainedTabBarView(
                tabs: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Upcoming',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Completed',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
                views: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                              ),
                            ],
                            color: Color(0xFFE8E8E8), // Background color
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Oct 10, 2024 at 10:00 AM',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SwitchListTile(
                                title: Text('Remind me'),
                                value: _isSwitched,
                                onChanged: (bool value) {
                                  setState(() {
                                    _isSwitched = value;
                                  });
                                },
                              ),
                              SizedBox(height: 10),
                              Divider(
                                color: const Color.fromARGB(255, 205, 205, 205),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.location_on, color: Colors.orange),
                                  SizedBox(width: 8),
                                  Text('Taffela - Sousse',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                      SizedBox(width: size.width*0.35,),
                                  Text('15Km',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF009D22),
                                      )),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(
                                color: const Color.fromARGB(255, 205, 205, 205),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text('Charger:',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF555555),
                                          )),
                                      SizedBox(height: 7,),
                                      Text('Tesla (Plug)'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Max Power:',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF555555),
                                          )),
                                      SizedBox(height: 7,),
                                      Text('100kW'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Duration:',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF555555),
                                          )),
                                      SizedBox(height: 7,),
                                      Text('1 hour'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('Amount:',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF555555),
                                          )),
                                      SizedBox(height: 7,),
                                      Text('30 Dinars'),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Container(
                                  height: size.height * 0.06,
                                  width: size.width * 0.3,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Cancel Booking",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.hovered)) {
                                            return Color.fromARGB(
                                                255, 255, 0, 0);
                                          }
                                          return Color(0xFFFBAA1B);
                                        },
                                      ),
                                      foregroundColor:
                                          MaterialStateProperty.resolveWith(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.hovered)) {
                                            return Color(0xFFFBAA1B);
                                          }
                                          return Color.fromARGB(255, 255, 0, 0);
                                        },
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5.0), // Adjust the radius as needed
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container()
                ],
                onChange: (index) => print(index),
                tabBarProperties: TabBarProperties(
                  indicatorColor: Color.fromARGB(255, 232, 232, 232),
                  labelColor: Color(0xffFBAA1B),
                  unselectedLabelColor: Color(0xff555555),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
