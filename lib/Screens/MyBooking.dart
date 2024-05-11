import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Screens/Bottom.dart';
import 'package:project/Screens/Header.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  bool _isSwitched = false;
  late String? userId;

  @override
  void initState() {
    super.initState();
    getCurrentUserId().then((id) {
      setState(() {
        userId = id;
      });
    });
  }

  Future<String?> getCurrentUserId() async {
    // Get the current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;
    // Return the user's ID or null if user is not logged in
    return user?.uid;
  }

  Stream<List<Map<String, dynamic>>> getBookingStreamMock() {
    return FirebaseFirestore.instance
        .collection('appointments')
        .where('userId', isEqualTo: userId) // Filter by userId
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return {
          'serviceId': data['serviceId'],
          'userId': data['userId'],
          'start': data['start'],
          'end': data['end'],
        };
      }).toList();
    });
  }
  Future<String?> getStationName(String serviceId) async {
  try {
    // Get the document snapshot from the Stations collection using the serviceId
    DocumentSnapshot stationSnapshot = await FirebaseFirestore.instance
        .collection('Stations')
        .doc(serviceId)
        .get();

    // Check if the document exists and contains the station_name field
    if (stationSnapshot.exists && stationSnapshot.data() != null) {
      // Cast the dynamic data to Map<String, dynamic>
      Map<String, dynamic> data = stationSnapshot.data()! as Map<String, dynamic>;
      
      // Access the station_name field from the document data
      return data['station_name'] as String?;
    } else {
      // Document doesn't exist or doesn't contain station_name field
      return null;
    }
  } catch (e) {
    print('Error getting station name: $e');
    return null;
  }
}


  
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
                  StreamBuilder<List<Map<String, dynamic>>>(
                    stream: getBookingStreamMock(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        List<Map<String, dynamic>> bookings = snapshot.data ?? [];
                        return ListView.builder(
                          itemCount: bookings.length,
                          itemBuilder: (context, index) {
  Map<String, dynamic> booking = bookings[index];
  return FutureBuilder<String?>(
    future: getStationName(booking['serviceId']), // Get the station name asynchronously
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator(); // Show loading indicator while fetching station name
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}'); // Show error if fetching station name fails
      } else {
        String? stationName = snapshot.data; // Get the fetched station name
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                  DateFormat('dd MMM yyyy  HH:mm ').format(booking['start'].toDate()),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                Divider(color: const Color.fromARGB(255, 205, 205, 205)),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on, color: Colors.orange),
                    SizedBox(width: 8),
                    Text(
                      stationName ?? 'Station Name Not Found', // Display the station name or a default message
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: size.width * 0.35),
                  ],
                ),
                SizedBox(height: 10),
                Divider(color: const Color.fromARGB(255, 205, 205, 205)),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    height: size.height * 0.06,
                    width: size.width * 0.35,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Cancel Booking',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 0, 0),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                'Are you sure you want to cancel this booking?',
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                      color: Color(0xFFFBAA1B),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: Color(0xFFFBAA1B),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        "Cancel Booking",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Color.fromARGB(255, 255, 0, 0);
                            }
                            return Color(0xFFFBAA1B);
                          },
                        ),
                        foregroundColor: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Color(0xFFFBAA1B);
                            }
                            return Color.fromARGB(255, 255, 0, 0);
                          },
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    },
  );
},

                        );
                      }
                    },
                  ),
                  Container(),
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
