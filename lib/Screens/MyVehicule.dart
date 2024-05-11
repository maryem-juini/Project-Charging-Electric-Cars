import 'package:flutter/material.dart';
import 'package:project/Screens/Bottom.dart';
import 'package:project/Screens/Header.dart';

class MyVehicule extends StatefulWidget {
  const MyVehicule({super.key});

  @override
  State<MyVehicule> createState() => _MyVehiculeState();
}

class _MyVehiculeState extends State<MyVehicule> {


  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: HeaderPage(),
        bottomNavigationBar: BottomPage(selectedIndex: 3),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(25, 15, 25, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_back, color: Color(0xFF06094C), size: 30),
                    Text('My Vehicule',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF06094C),
                        )),
                    SizedBox(width: size.width * 0.4),
                    Icon(Icons.add, color: Color(0xFF06094C), size: 30),
                  ],
                ),
              ),
              Image.asset("assets/vitesse.png"),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(
                    vertical: size.height * 0.08, horizontal: size.width * 0.07),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 230, 229, 229),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                padding: EdgeInsets.only(top: size.height*0.03),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: size.width * 0.03),
                                    child: Text(
                                      "Tesla",
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "model S",
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xFF999999)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.03,
                                        right: size.width * 0.02,
                                        top: size.height * 0.01),
                                    child: Text(
                                      "10KW",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Max Power",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(222, 153, 153, 153)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.06,
                                        top: size.height * 0.01),
                                    child: Text(
                                      "Tesla(Plug)",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.2, right: size.width * 0.05),
                            child: Container(
                              height: size.height * 0.09,
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: Color(0xFFFBAA1B),
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Image.asset(
                            "assets/karhba_safra.png",
                            width: size.width * 0.2,
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * .05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Modify",
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.hovered)) {
                                      return Colors.white;
                                    }
                                    return Color(0xFFFBAA1B);
                                  },
                                ),
                                foregroundColor: MaterialStateProperty.resolveWith(
                                  (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.hovered)) {
                                      return Color(0xFFFBAA1B);
                                    }
                                    return Colors.white;
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
                             Padding(
                               padding: EdgeInsets.only(left : size.width*0.03),
                               child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Delete",
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.hovered)) {
                                        return Colors.red;
                                      }
                                      return Color(0xFFFBAA1B);
                                    },
                                  ),
                                  foregroundColor: MaterialStateProperty.resolveWith(
                                    (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.hovered)) {
                                        return Color(0xFFFBAA1B);
                                      }
                                      return Colors.red;
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
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
