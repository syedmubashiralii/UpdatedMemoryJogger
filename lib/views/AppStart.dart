// ignore_for_file: file_names, prefer_const_constructors

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../models/datamodel.dart';

class AppStart extends StatefulWidget {
  const AppStart({Key? key}) : super(key: key);

  @override
  _AppStartState createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  Color primaryTextColor = Color(0xFF414C6B);
  Color secondaryTextColor = Colors.deepPurple;
  Color titleTextColor = Colors.white;
  Color contentTextColor = Color(0xff868686);
  Color navigationColor = Color(0xFF6751B5);
  Color gradientStartColor = Color(0xFF0050AC);
  Color gradientEndColor = Color(0xFF9354B9);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(32.0),
                child: Text(
                  'Welcome',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 36,
                    color: Colors.deepPurple[200],
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: 500,
                  padding: const EdgeInsets.only(left: 32),
                  child: Swiper(
                    itemCount: planets.length,
                    // autoplay: true,
                    axisDirection: AxisDirection.right,
                    // duration: 4000,
                    itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                    layout: SwiperLayout.STACK,
                    pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                          activeSize: 20,
                          space: 12,
                          activeColor: Colors.white,
                          color: Colors.deepPurple[300]),
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          // if (planets[index].subname == "Get Started") {
                          //   getpatient();
                          // }
                          Navigator.pushNamed(context, planets[index].url);
                        },
                        child: Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                SizedBox(height: 100),
                                Container(
                                  //elevation: 8,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(32),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              planets[index].iconImage),
                                          fit: BoxFit.cover)),
                                  child: Padding(
                                    padding: EdgeInsets.all(32.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 150),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        SizedBox(height: 52),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, planets[index].url);
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: 6,
                                                    bottom: 6,
                                                    left: 6,
                                                    right: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      planets[index].subname,
                                                      style: TextStyle(
                                                        fontFamily: 'Avenir',
                                                        fontSize: 18,
                                                        color: Colors
                                                            .deepPurple[300],
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward,
                                                      color: secondaryTextColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right: 24,
                              bottom: 60,
                              child: Text(
                                planets[index].position.toString(),
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: 200,
                                  color: primaryTextColor.withOpacity(0.07),
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(36.0),
          ),
          color: Colors.deepPurple[300],
        ),
        padding: const EdgeInsets.all(24),
        child: Text(
          "       Lets Jogg Your memory",
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
