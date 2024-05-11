import 'package:flutter/material.dart';
import 'package:project/Screens/Bottom.dart';
import 'package:project/Screens/Header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: HeaderPage(),
        bottomNavigationBar: BottomPage(selectedIndex: 3),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back, color: Color(0xFF06094C), size: 30),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  Text('Account',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF06094C),
                      )),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              ListTile(
                leading: Image.asset(
                  'assets/profile.png',
                  width: 50,
                  height: 50,
                ),
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nesrine Juini',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      Text('+216 27 456 320 ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          )),
                    ]),
                trailing: InkWell(
                  child:
                      Icon(Icons.arrow_forward_ios, color: Color(0xFF06094C)),
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Divider(
                color: Color(0xFFFBAA1B),
                thickness: 1,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              ListTile(
                leading: Icon(
                  Icons.directions_car_rounded,
                  color: Color(0xFF06094C),
                  size: 30,
                ),
                title: Text(
                  'My Vehicle',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: InkWell(
                  child:
                      Icon(Icons.arrow_forward_ios, color: Color(0xFF06094C)),
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              ListTile(
                leading: Icon(Icons.person, color: Color(0xFF06094C), size: 30),
                title: Text(
                  'Personal Info',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: InkWell(
                  child:
                      Icon(Icons.arrow_forward_ios, color: Color(0xFF06094C)),
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              ListTile(
                leading:
                    Icon(Icons.language, color: Color(0xFF06094C), size: 30),
                title: Text(
                  'Language',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: InkWell(
                  child:
                      Icon(Icons.arrow_forward_ios, color: Color(0xFF06094C)),
                  onTap: () {},
                ),
              ),
              Expanded(child: Container()),
              Container(
                width: size.width * 0.3,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    print('User logged out.');
                  },
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 228, 34, 12)), // Set the button color to blue
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
