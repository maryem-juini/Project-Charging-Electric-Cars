import 'package:flutter/material.dart';

class RadioButtonContainer extends StatefulWidget {
  @override
  _RadioButtonContainerState createState() => _RadioButtonContainerState();
}

class _RadioButtonContainerState extends State<RadioButtonContainer> {
  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Select your car ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF06094C),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {},
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: size.height * 0.03),
                child: Column(
                  children: List.generate(8, (index) {
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
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.06,
                                      vertical: size.height * 0.02),
                                  child: Image.asset(
                                    'assets/karhba_safra.png',
                                  ),
                                ),
                                Text(
                                  'Container ${index + 1}',
                                  style: TextStyle(
                                      fontSize: size.width * 0.04,
                                      fontWeight: FontWeight.bold), // Text color
                                ),
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: 1,
                            child: Radio<int>(
                              value: index, // You can assign any value here
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value;
                                });
                              },
                              activeColor: Color(0xFFFBAA1B),
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
                      "Next",
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
        ),
      ),
    );
  }
}


