import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/Screens/EnterCarDetails.dart';

class Select extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SelectCar(),
      ),
    );
  }
}

class SelectCar extends StatefulWidget {
  @override
  _SelectCarState createState() => _SelectCarState();
}

class _SelectCarState extends State<SelectCar> {
  String? _selectedCar;

  late List<Map<String, dynamic>> carDataList = [];

  @override
  void initState() {
    super.initState();
    fetchCarData();
  }

  void fetchCarData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Cars').get();

      if (querySnapshot != null) {
        setState(() {
          carDataList.clear();

          querySnapshot.docs.forEach((doc) {
            var data = doc.data() as Map<String, dynamic>?;
            if (data != null &&
                data.containsKey('make') &&
                data.containsKey('model')) {
              bool exists = carDataList.any((element) =>
                  element['make'] == data['make'] &&
                  element['model'] == data['model']);

              if (!exists) {
                carDataList.add({
                  'make': data['make'],
                  'model': data['model'],
                });
              }
            }
          });
        });
      } else {
        print('Query snapshot is null');
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

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
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: size.height * 0.03),
                child: Column(
                  children: List.generate(carDataList.length, (index) {
                    final car = carDataList[index];
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
                                  '${car["make"]} ${car["model"]}',
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Radio<String>(
                            value: '${car["make"]} ${car["model"]}',
                            groupValue: _selectedCar,
                            onChanged: (value) {
                              setState(() {
                                _selectedCar = value;
                                print(_selectedCar);
                              });
                            },
                            activeColor: Color(0xFFFBAA1B),
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
                  width: size.width * 0.3,
                  height: size.height * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedCar != null) {
                        // Split the selected car into make and model
                        List<String> carDetails = _selectedCar!.split(' ');
                        String make = carDetails[0];
                        String model = carDetails[1];

                        // Navigate to EnterCarDetailsPage and pass the make and model as arguments
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EnterCarDetailsPage(
                              make: make,
                              model: model,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select a car.'),
                          ),
                        );
                      }
                    },
                    child: Text("Next",
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
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
