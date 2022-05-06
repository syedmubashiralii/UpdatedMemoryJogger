// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/widgets.dart';

class ActivityScreenI extends StatefulWidget {
  const ActivityScreenI({Key? key}) : super(key: key);

  @override
  State<ActivityScreenI> createState() => _ActivityScreenIState();
}

class _ActivityScreenIState extends State<ActivityScreenI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ACTIVITY TYPE',
          textAlign: TextAlign.center,
        ),
        // backgroundColor: Colors.white,
        // foregroundColor: Colors.blue ,
      ),
      body: MyBackground(
          child: Column(
        children: [
          SizedBox(height: 20),
          MyButton(
            text: 'Picture Based',
            onTap: () {
              Navigator.pushNamed(context, '/picturebasedactivity');
            },
            fontWeight: FontWeight.bold,
          ),
          MyButton(
            text: 'Text Based',
            onTap: () {
              Navigator.pushNamed(context, '/textbasedactivity');
            },
            fontWeight: FontWeight.bold,
          ),
        ],
      )),
    );
  }
}
