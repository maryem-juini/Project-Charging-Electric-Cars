import 'package:flutter/material.dart';
import 'package:project/Screens/SignUp.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo-dark.png',
              width: size.width * .35,
              height: size.height * .35,
            ),
            TextField(
              focusNode: _focusNode1,
              cursorColor: Color(0xFFFBAA1B),
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(
                  color: _isFocused1
                      ? Color(0xFFFBAA1B)
                      : Colors.grey, // Change these to your desired colors
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
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: _isFocused2 ? Color(0xFFFBAA1B) : Colors.grey,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFBAA1B)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                child: Text('Forgot Password?',
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Checkbox(
                value: _isChecked,
                activeColor: Color(0xFFFBAA1B),
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
              ),
              Text(
                "Remember Me",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),
            ]),
            SizedBox(
              height: 20,
            ),
            Container(
              width: size.width * .35,
              height: size.height * .06,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Log In"),
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
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account ?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 146, 149, 154),
                    fontSize: size.width * 0.03,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Signup(),
                    ),
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color(0xFFFBAA1B),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
