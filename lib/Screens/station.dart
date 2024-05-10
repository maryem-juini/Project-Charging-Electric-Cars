import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:project/Screens/Bottom.dart';
import 'package:project/Screens/Header.dart';
import 'package:project/Screens/MyBooking.dart';
import 'package:project/Screens/bookPage.dart';

class Station extends StatefulWidget {
  final String stationName;
  final String distance;

  const Station({
    required this.stationName,
    required this.distance,
    Key? key,
  }) : super(key: key);

  @override
  State<Station> createState() => _StationState();
}

class _StationState extends State<Station> {
  late String _stationId;

  @override
  void initState() {
    super.initState();
    // Call the method to search for the station ID when the widget initializes
    searchStationId(widget.stationName);
  }

  Future<void> searchStationId(String stationName) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Stations')
          .where('station_name', isEqualTo: stationName)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // If the station is found, retrieve its ID
        setState(() {
          _stationId = snapshot.docs.first.id;
        });
      } else {
        // If the station is not found, set the ID to an empty string
        setState(() {
          _stationId = '';
        });
      }
    } catch (e) {
      // Handle errors if any
      print('Error retrieving station ID: $e');
    }
    print(_stationId);
  }

  String estimateTravelTime(double distance, double averageSpeed) {
    // Convert distance to kilometers if not already
    // Assume averageSpeed is in kilometers per hour
    double distanceInKm =
        distance; // Assuming distance is already in kilometers

    // Calculate travel time
    double travelTimeInHours = distanceInKm / averageSpeed;

    // Convert travel time to minutes for better readability
    int travelTimeInMinutes = (travelTimeInHours * 60).round();

    return '${travelTimeInMinutes} minutes';
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: HeaderPage(),
        bottomNavigationBar: BottomPage(selectedIndex: 0),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/station2.png',
                  width: size.width * 1,
                  fit: BoxFit.contain,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.02),
                  child: Column(
                    children: [
                      Text(
                        widget.stationName,
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text("Avenu eeeee",
                      //     style: TextStyle(
                      //       fontSize: size.width * 0.02,
                      //       color: Color.fromARGB(255, 146, 149, 154),
                      //     )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.086,
                  ),
                  child: AnimatedRatingStars(
                    initialRating: 3,
                    minRating: 0.0,
                    maxRating: 5.0,
                    filledColor: Colors.amber,
                    emptyColor: Colors.grey,
                    filledIcon: Icons.star,
                    halfFilledIcon: Icons.star_half,
                    emptyIcon: Icons.star_border,
                    onChanged: (double rating) {
                      // Handle the rating change here
                      print('Rating: $rating');
                    },
                    displayRatingValue: true,
                    interactiveTooltips: true,
                    customFilledIcon: Icons.star,
                    customHalfFilledIcon: Icons.star,
                    customEmptyIcon: Icons.star_border,
                    starSize: size.width * 0.025,
                    animationDuration: Duration(milliseconds: 300),
                    animationCurve: Curves.easeInOut,
                    readOnly: false,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: size.height * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width * .2,
                        height: size.height * .05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Color(0xFF0C5700),
                        ),
                        child: Center(
                          child: Text(
                            "Available",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: size.width * 0.08, top: size.height * 0.01),
                        child: Icon(
                          Icons.location_on_outlined,
                          color: Color(0xFFFBAA1B),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.02),
                        child: Row(
                          children: [
                            Text(widget.distance,
                                style: TextStyle(
                                  fontSize: size.width * 0.02,
                                  color: Color.fromARGB(255, 146, 149, 154),
                                )),
                            Text("KM",
                                style: TextStyle(
                                  fontSize: size.width * 0.02,
                                  color: Color.fromARGB(255, 146, 149, 154),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: size.width * 0.08, top: size.height * 0.01),
                        child: Icon(
                          Icons.directions_car_rounded,
                          color: Color(0xFFFBAA1B),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.02),
                        child: Text(
                          estimateTravelTime(
                              double.parse(
                                  widget.distance.replaceAll(' KM', '')),
                              60),
                          style: TextStyle(
                            fontSize: size.width * 0.02,
                            color: Color.fromARGB(255, 146, 149, 154),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: size.width * 0.7,
                    child: Divider(
                      color: Color.fromARGB(255, 146, 149, 154),
                      thickness: 0.8,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                        vertical: size.height * 0.04),
                    child: Text(
                        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.")),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BookingCalendarDemoApp(stationId: _stationId)),
                      );
                    },
                    child: Text(
                      "Book",
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Color(0xFFFBAA1B);
                          }
                          return Color(0xFF06094C);
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Color(0xFF06094C);
                          }
                          return Color(0xFFFBAA1B);
                        },
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0), // Adjust the radius as needed
                        ),
                      ),
                      minimumSize: MaterialStateProperty.resolveWith<Size>(
                        (Set<MaterialState> states) {
                          return Size(size.width * 0.5, size.height * 0.07);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.08,
                )
              ]),
        ),
      ),
    );
  }
}
