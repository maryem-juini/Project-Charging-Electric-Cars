import 'package:flutter/material.dart';

class SetPasswordPage extends StatefulWidget {
  const SetPasswordPage({super.key});

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    FocusNode _focusNode1 = FocusNode();
    bool _isFocused1 = false;
    FocusNode _focusNode2 = FocusNode();
    bool _isFocused2 = false;
    bool _isChecked = false;
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

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                'Set Your Password',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF06094C),
                    fontSize: 25),
              ),
              backgroundColor: Colors.white,
              leading: InkWell(
                child: Icon(Icons.arrow_back_ios, color: Color(0xFF06094C)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Container(
                margin: EdgeInsets.all(40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo-dark.png',
                        width: size.width * .35,
                        height: size.height * .35,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        obscureText: true,
                        focusNode: _focusNode1,
                        cursorColor: Color(0xFFFBAA1B),
                        decoration: InputDecoration(
                          labelText: 'Your Password',
                          labelStyle: TextStyle(
                            color:
                                _isFocused1 ? Color(0xFFFBAA1B) : Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        obscureText: true,
                        focusNode: _focusNode2,
                        cursorColor: Color(0xFFFBAA1B),
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                            color:
                                _isFocused2 ? Color(0xFFFBAA1B) : Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .1,
                      ),
                      ElevatedButton(
                    onPressed: () {},
                    child: Text("Next",
                        style: TextStyle(
                          fontSize: size.height * 0.03,
                        )),
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
                    ]))));
  }
}
