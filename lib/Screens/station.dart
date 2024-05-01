import 'package:flutter/material.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';

class Station extends StatefulWidget {
  const Station({super.key});

  @override
  State<Station> createState() => _StationState();
}

class _StationState extends State<Station> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/logo-dark-large.png',
              width: size.width * 0.3, height: size.height * 0.3),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 5,
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.home_rounded,
                      size: 35, color: Color(0xffFBAA1B)),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.search, size: 35, color: Color(0xFF06094C)),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.book, size: 35, color: Color(0xFF06094C)),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.person, size: 35, color: Color(0xFF06094C)),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/station2.png',
                  width: size.width * 1,
                  fit: BoxFit.contain,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.02),
                  child: Column(
                    children: [
                      Text(
                        "Taffela Sousse",
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Avenu eeeee",
                          style: TextStyle(
                            fontSize: size.width * 0.02,
                            color: Color.fromARGB(255, 146, 149, 154),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.086,
                  ),
                  child: AnimatedRatingStars(
                    initialRating: 3,
                    minRating: 0.0,
                    maxRating: 5.0,
                    filledColor: Colors.amber,
                    emptyColor: Colors.grey,
                    filledIcon: Icons.star,
                    halfFilledIcon: Icons.star_half,
                    emptyIcon: Icons.star_border,
                    onChanged: (double rating) {
                      // Handle the rating change here
                      print('Rating: $rating');
                    },
                    displayRatingValue: true,
                    interactiveTooltips: true,
                    customFilledIcon: Icons.star,
                    customHalfFilledIcon: Icons.star,
                    customEmptyIcon: Icons.star_border,
                    starSize: size.width * 0.025,
                    animationDuration: Duration(milliseconds: 300),
                    animationCurve: Curves.easeInOut,
                    readOnly: false,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: size.height * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width * .2,
                        height: size.height * .05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Color(0xFF0C5700),
                        ),
                        child: Center(
                          child: Text(
                            "Available",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: size.width * 0.08, top: size.height * 0.01),
                        child: Icon(
                          Icons.location_on_outlined,
                          color: Color(0xFFFBAA1B),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.02),
                        child: Text("100 Km ",
                            style: TextStyle(
                              fontSize: size.width * 0.02,
                              color: Color.fromARGB(255, 146, 149, 154),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: size.width * 0.08, top: size.height * 0.01),
                        child: Icon(
                          Icons.directions_car_rounded,
                          color: Color(0xFFFBAA1B),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.02),
                        child: Text("1 hour ",
                            style: TextStyle(
                              fontSize: size.width * 0.02,
                              color: Color.fromARGB(255, 146, 149, 154),
                            )),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: size.width * 0.7,
                    child: Divider(
                      color: Color.fromARGB(255, 146, 149, 154),
                      thickness: 0.8,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                        vertical: size.height * 0.04),
                    child: Text(
                        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.")),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Book",
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
                SizedBox(
                  height: size.height * 0.08,   
                )
              ]),
        ),
      ),
    );
  }
}
