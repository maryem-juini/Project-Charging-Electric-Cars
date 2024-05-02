import 'package:flutter/material.dart';

class EnterCarDetailsPage extends StatefulWidget {
  @override
  _EnterCarDetailsPageState createState() => _EnterCarDetailsPageState();
}

class _EnterCarDetailsPageState extends State<EnterCarDetailsPage> {
  int? _selectedValue;
  FocusNode _focusNode1 = FocusNode();
  bool _isFocused1 = false;
  FocusNode _focusNode2 = FocusNode();
  bool _isFocused2 = false;

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {
        _isFocused1 = _focusNode1.hasFocus;
      });
    });
    _focusNode2.addListener(() {
      setState(() {
        _isFocused2 = _focusNode2.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                'Select Your Car ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF06094C),
                    fontSize: 25),
              ),
              backgroundColor: Colors.white,
              leading: InkWell(
                child: Icon(Icons.arrow_back_ios, color: Color(0xFF06094C)),
                onTap: () {},
              ),
            ),
            body:SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            focusNode: _focusNode1,
                            cursorColor: Color(0xFFFBAA1B),
                            decoration: InputDecoration(
                              labelText: 'Chassis Number',
                              labelStyle: TextStyle(
                                color: _isFocused1
                                    ? Color(0xFFFBAA1B)
                                    : Colors
                                        .grey, // Change these to your desired colors
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.warning_rounded,
                                size: 20,
                                color: Color.fromARGB(255, 146, 149, 154),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Please enter a valid input ! (17 Characters )",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 146, 149, 154),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 16),
                          TextField(
                            focusNode: _focusNode2,
                            cursorColor: Color(0xFFFBAA1B),
                            decoration: InputDecoration(
                              labelText: 'Licence Plate Number',
                              labelStyle: TextStyle(
                                color: _isFocused2
                                    ? Color(0xFFFBAA1B)
                                    : Colors
                                        .grey,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Icon(
                                Icons.warning_rounded,
                                size: 20,
                                color: Color.fromARGB(255, 146, 149, 154),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Please enter a valid input  ! (10 Characters )",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 146, 149, 154),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 40),
                          Text('Select Your Charger Type',style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF06094C)),
                          ),
                          Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.03),
                  child: Column(
                    children: List.generate(5, (index) {
                      return Container(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            Transform.scale(
                              scale: 1,
                              child: Radio<int>(
                                value: index,
                                groupValue: _selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue = value;
                                  });
                                },
                                activeColor: Color(0xFFFBAA1B),
                              ),
                            ),
                            Text(
                                    'Charger Type ${index + 1}',
                                    style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        ),
                                  ),
                                  SizedBox(width: size.width*0.15,),
                                  Container(
                                    width: 1,
                                    height: 30,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    '50Kw',
                                    style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        ),
                                  ),

                          ],
                        ),
                      );
                    }),
                  ),
                ),
                Container(
                                  margin: EdgeInsets.only(top: size.height * .05),
            
                  child: Container(
                    width: size.width*0.3,
                    height: size.height*0.07,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Finish",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: size.height*0.03,
                        )
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
                                5.0), // Adjust the radius as needed
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
              ],
                      ),
                        ]),
              ),
            )));
    //
  }
}
