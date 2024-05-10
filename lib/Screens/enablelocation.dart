import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:project/Screens/HomePage.dart';


class enableLocation extends StatefulWidget {
  const enableLocation({super.key});

  @override
  State<enableLocation> createState() => _enableLocationState();
}

class _enableLocationState extends State<enableLocation> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/screen.png",
              width: size.width,
              height: size.height,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.7,
                  height: size.height * 0.6,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 208, 202, 202),
                    border: Border.all(
                      color: Color(0xFF06094C),
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(size.height * 0.05),
                      child: Column(children: [
                        Image.asset("assets/enable-location.png"),
                        Text(
                          "Enable Location",
                          style: TextStyle(
                            color: Color(0xFFFBAA1B),
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.06,
                          ),
                        ),
                        Text(
                          "We need to access your location to find EV charging stations around you.",
                          style: TextStyle(
                            fontSize: size.width * 0.02,
                            color: Color.fromARGB(255, 106, 108, 110),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height * .05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () => {},
                                child: Text(
                                  "Later",
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.hovered)) {
                                        return Color(0xFF06094C);
                                      }
                                      return Colors.white;
                                    },
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.resolveWith(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.hovered)) {
                                        return Colors.white;
                                      }
                                      return Color(0xFF06094C);
                                    },
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: BorderSide(
                                          color: Color(0xFF06094C),
                                        )),
                                  ),
                                  minimumSize:
                                      MaterialStateProperty.resolveWith<Size>(
                                    (Set<MaterialState> states) {
                                      return Size(
                                          size.width * 0.2, size.height * 0.07);
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.03),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    Location location = new Location();

                                    bool _serviceEnabled;
                                    PermissionStatus _permissionGranted;
                                    LocationData _locationData;

                                    _serviceEnabled =
                                        await location.serviceEnabled();
                                    if (!_serviceEnabled) {
                                      _serviceEnabled =
                                          await location.requestService();
                                      if (!_serviceEnabled) {
                                        return;
                                      }
                                    }

                                    _permissionGranted =
                                        await location.hasPermission();
                                    if (_permissionGranted ==
                                        PermissionStatus.denied) {
                                      _permissionGranted =
                                          await location.requestPermission();
                                      if (_permissionGranted !=
                                          PermissionStatus.granted) {
                                        return;
                                      }
                                    }

                                    _locationData =
                                        await location.getLocation();

                                    if (_serviceEnabled &&
                                        _permissionGranted ==
                                            PermissionStatus.granted) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Enable",
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.hovered)) {
                                          return Color(0xFFFBAA1B);
                                        }
                                        return Color(0xFF06094C);
                                      },
                                    ),
                                    foregroundColor:
                                        MaterialStateProperty.resolveWith(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.hovered)) {
                                          return Color(0xFF06094C);
                                        }
                                        return Color(0xFFFBAA1B);
                                      },
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          side: BorderSide(
                                            color: Color(0xFF06094C),
                                          )
                                          // Adjust the radius as needed
                                          ),
                                    ),
                                    minimumSize:
                                        MaterialStateProperty.resolveWith<Size>(
                                      (Set<MaterialState> states) {
                                        return Size(size.width * 0.2,
                                            size.height * 0.07);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
