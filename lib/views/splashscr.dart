// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, unnecessary_cast
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: camel_case_types
class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

// ignore: camel_case_types
class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4),
        () => Navigator.pushNamed(context, '/aftersplash'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
                //color: Colors.grey[300],
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/walk-4966242_1920.jpg"))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                // ignore: prefer_const_literals_to_create_immutables, duplicate_ignore
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ignore: prefer_const_constructors
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        // ignore: prefer_const_constructors
                        backgroundImage: AssetImage('assets/images/newlogo.jpg')
                            as ImageProvider,
                      ),
                      // ignore: prefer_const_constructors
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 17,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          'Memory Jogger',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 28,
                              letterSpacing: 3.0,
                              textStyle: TextStyle(color: Colors.black)),
                        ),
                      )
                    ]),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Container(
                  //   decoration: BoxDecoration(
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.white.withOpacity(0.5),
                  //         spreadRadius: 5,
                  //         blurRadius: 37,
                  //         offset: Offset(0, 3), // changes position of shadow
                  //       ),
                  //     ],
                  //   ),
                  //   child: CupertinoActivityIndicator(
                  //     radius: 25,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  SpinKitRotatingCircle(
                    color: Colors.white,
                    size: 50.0,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 27,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text(
                      'Lets Jogg Your Memory...',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 24,
                          letterSpacing: 3.0,
                          textStyle: TextStyle(color: Colors.black)),
                    ),
                  )
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
