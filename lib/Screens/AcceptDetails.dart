import 'package:flutter/material.dart';
import 'package:project/Screens/HomePage.dart';
import 'package:project/Screens/SelectCar.dart';

class AcceptDetails extends StatefulWidget {
  const AcceptDetails({super.key});

  @override
  State<AcceptDetails> createState() => _AcceptDetailsState();
}

class _AcceptDetailsState extends State<AcceptDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
       appBar :  AppBar(
          elevation: 0,
          title: Text(
            'Add Car Details ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF06094C),
              fontSize: 25
            ),
          ),
          backgroundColor: Colors.white,
          leading: InkWell(
                  child:
                      Icon(Icons.arrow_back_ios, color: Color(0xFF06094C)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * .08, bottom: size.height * 0.03),
                child: Image.asset("assets/enter-car-details.png"),
              ),
              Text(
                "Add your car to personalize your experience ",
                style: TextStyle(color: Color(0xFF80807F)),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * .05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      child: Text(
                        "Later",
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Color(0xFFFBAA1B);
                            }
                            return Colors.white;
                          },
                        ),
                        foregroundColor: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Colors.white;
                            }
                            return Color(0xFFFBAA1B);
                          },
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                color: Color(0xFFFBAA1B),
                              )),
                        ),
                        minimumSize: MaterialStateProperty.resolveWith<Size>(
                          (Set<MaterialState> states) {
                            return Size(size.width*0.3,size.height*0.07); 
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.03),
                      child: ElevatedButton(
                        onPressed: () {
                           Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Select(),
                          ),
                        );
                        },
                        child: Text(
                          "Add",
                        ),
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
                                return Colors.white;
                              }
                              return Color(0xFFFBAA1B);
                            },
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: Color(0xFF06094C),
                                )
                                // Adjust the radius as needed
                                ),
                                
                          ),
                           minimumSize: MaterialStateProperty.resolveWith<Size>(
                          (Set<MaterialState> states) {
                            return Size(size.width*0.3,size.height*0.07); 
                          },
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
    );
  }
}
