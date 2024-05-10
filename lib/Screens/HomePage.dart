import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:project/DataBase/firebase_options.dart';
import 'package:project/Screens/Bottom.dart';
import 'package:project/Screens/Header.dart';
import 'package:project/Screens/station.dart';

class Stations {
  final String name;
  final double latitude;
  final double longitude;

  Stations({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LocationData _locationData;
  late Future<void> _locationFuture; // Future for fetching location data

  @override
  void initState() {
    super.initState();
    _locationFuture = fetchLocationData();
  }

  Future<List<String>> calculateDistances(LocationData currentLocation) async {
    List<Stations> stations = await getAllStations();
    List<String> distances = [];

    stations.forEach((stations) {
      int distance = calculateDistance(stations.latitude, stations.longitude,
          currentLocation.latitude!, currentLocation.longitude!);
      distances.add('${stations.name}: $distance');
    });

    // Sort distances in ascending order
    distances.sort((a, b) {
      int distanceA = int.parse(
          a.split(': ')[1].replaceAll('km', '').replaceAll('miles', '').trim());
      int distanceB = int.parse(
          b.split(': ')[1].replaceAll('km', '').replaceAll('miles', '').trim());
      return distanceA.compareTo(distanceB);
    });

    // Take only the first 5 distances
    distances = distances.take(5).toList();

    return distances;
  }

  int calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371;

    double lat1Rad = degreesToRadians(lat1);
    double lon1Rad = degreesToRadians(lon1);
    double lat2Rad = degreesToRadians(lat2);
    double lon2Rad = degreesToRadians(lon2);

    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    double a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance.round();
  }

// Function to convert degrees to radians
  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  Future<List<Stations>> getAllStations() async {
    List<Stations> stations = [];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('Stations').get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        Map<String, dynamic>? address = doc.data()['address'];
        if (address != null) {
          double? latitude = address['latitude'];
          double? longitude = address['longitude'];
          if (latitude != null && longitude != null) {
            String stationName = doc.data()['station_name'];
            stations.add(Stations(
              name: stationName,
              latitude: latitude,
              longitude: longitude,
            ));
          }
        }
      }

      return stations;
    } catch (e) {
      print('Error retrieving stations: $e');
      return [];
    }
  }

  Future<void> fetchLocationData() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData);

    if (_serviceEnabled && _permissionGranted == PermissionStatus.granted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: HeaderPage(),
        bottomNavigationBar: BottomPage(selectedIndex: 0),
        body: FutureBuilder<void>(
            future: _locationFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return Center(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Column(children: [
                          Text('Hello There !',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E232C),
                              )),
                          SizedBox(height: 10),
                          Image.asset('assets/home.png',
                              width: size.width * 0.45,
                              height: size.height * 0.25,
                              fit: BoxFit.contain),
                          SizedBox(height: 10),
                          Text('“ Plan Your Power, Drive Your Way “',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF06094C),
                              )),
                          SizedBox(height: 15),
                          Text(
                            'Welcome to ViaVolt, where booking your electric car charging is just a tap away.',
                            style: TextStyle(color: Colors.grey),
                          )
                        ]),
                        SizedBox(
                            height:
                                20), // Add some space between the header and the list
                        Expanded(
                          child: FutureBuilder<List<String>>(
                            future: _locationData != null
                                ? calculateDistances(_locationData)
                                : Future.value([]),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return StationInfoCard(
                                        distanceInfo: snapshot.data![index]);
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}

class StationInfoCard extends StatelessWidget {
  final String distanceInfo;

  const StationInfoCard({required this.distanceInfo});

  @override
  Widget build(BuildContext context) {
    // Split the distanceInfo into stationName and distance
    final List<String> parts = distanceInfo.split(': ');
    final String stationName = parts[0];
    final String distance = parts[1];

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Station(
              stationName: stationName,
              distance: distance,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 232, 232, 232),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
              ),
            ],
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: Color(0xFFFBAA1B),
                size: 40,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stationName, // Use the stationName variable here
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text(
                        '$distance KM ', // Use the distance variable here
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF009D22),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
