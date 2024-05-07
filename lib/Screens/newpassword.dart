import 'package:flutter/material.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  FocusNode _focusNode1 = FocusNode();
  bool _isFocused1 = false;
  FocusNode _focusNode2 = FocusNode();
  bool _isFocused2 = false;
  FocusNode _focusNode3 = FocusNode();
  bool _isFocused3 = false;

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
     _focusNode2.addListener(() {
      setState(() {
        _isFocused3 = _focusNode3.hasFocus;
      });
    });
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
              'Add Car Details ',
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
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * .08, bottom: size.height * 0.05),
                  child: Image.asset("assets/change-password.png"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size.height*0.03),
                  child: SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      obscureText: true,
                      focusNode: _focusNode1,
                      cursorColor: Color(0xFFFBAA1B),
                      decoration: InputDecoration(
                        labelText: 'Old Password',
                        labelStyle: TextStyle(
                          color: _isFocused1 ? Color(0xFFFBAA1B) : Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: size.height*0.03),
                  child: SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      obscureText: true,
                      focusNode: _focusNode2,
                      cursorColor: Color(0xFFFBAA1B),
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        labelStyle: TextStyle(
                          color: _isFocused2 ? Color(0xFFFBAA1B) : Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextField(
                    obscureText: true,
                    focusNode: _focusNode3,
                    cursorColor: Color(0xFFFBAA1B),
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                        color: _isFocused3 ? Color(0xFFFBAA1B) : Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height*0.06),
                  child: Container(
                    width: size.width*0.3,
                    height: size.height*0.06,
                    child: ElevatedButton(
                      
                          onPressed:
                          () {
                          
                          },
                        
                        child: Text("Change",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: size.height * 0.03)),
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
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
