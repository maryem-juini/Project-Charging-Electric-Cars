import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:project/Screens/Bottom.dart';
import 'package:project/Screens/Header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LocationData _locationData;

  @override
  void initState() {
    super.initState();
    fetchLocationData();
  }

  Future<void> fetchLocationData() async {
    Location location = new Location();

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
        body: Center(
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Text('Most Popular',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E232C),
                          )),
                      SizedBox(height: 20),
                      Container(
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
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Color(0xFFFBAA1B),
                                size: 40,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Taffela - Sousse',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(height: 5),
                                  Text('Charge type 1 - Charge type 2',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      )),
                                ],
                              ),
                              SizedBox(
                                width: size.width * 0.35,
                              ),
                              Text('5 Km',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF009D22),
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
