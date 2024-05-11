import 'package:flutter/material.dart';
import 'package:project/Screens/AcceptDetails.dart';
import 'package:project/Screens/CompleteProfile.dart';

class ReadyCharge extends StatefulWidget {
  const ReadyCharge({super.key});

  @override
  State<ReadyCharge> createState() => _ReadyChargeState();
}

class _ReadyChargeState extends State<ReadyCharge> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: InkWell(
              child: Icon(Icons.arrow_back_ios, color: Color(0xFF06094C)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(top: size.height * .15),
              child: Column(
                children: [
                  Image.asset("assets/ready-to-charge.png"),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * .07),
                    child: Image.asset("assets/check.png"),
                  ),
                  Text(
                    "Ready to charge!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * .03),
                    child: Text(
                      "Your account has been created successfully.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF80807F),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * .1),
                    child: ElevatedButton(
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AcceptDetails(),
                          ),
                        );
                      },
                      child: Text("Next",
                          style: TextStyle(
                            fontSize: size.height * 0.03,
                          )),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5.0), // Adjust the radius as needed
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
                ],
              ),
            ),
          ),
        ));
  }
}
