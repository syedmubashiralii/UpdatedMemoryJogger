// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, unnecessary_cast

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            decoration: BoxDecoration(color: Colors.deepPurple),
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
                      Text(
                        'Memory Jogger',
                        style: GoogleFonts.bebasNeue(fontSize: 40),
                      )
                    ]),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CupertinoActivityIndicator(
                    radius: 25,
                    color: Colors.black,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  Text(
                    'Lets Jogg Your Memory...',
                    style: GoogleFonts.bebasNeue(fontSize: 22),
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
