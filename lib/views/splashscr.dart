// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            decoration: BoxDecoration(color: Colors.blueAccent),
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
                        radius: 50,
                        // ignore: prefer_const_constructors
                        child: Icon(
                          CupertinoIcons.memories,
                          color: Colors.green,
                          size: 50.0,
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Text(
                        'Memory Jogger',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      )
                    ]),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    color: Colors.green,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  Text('Lets Jogg Your Memory...',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold))
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
