// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
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
      appBar: CupertinoNavigationBar(
        middle: Text("Activity Type"),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_rounded),
        ),
        backgroundColor: Colors.deepPurple,
        transitionBetweenRoutes: true,
      ),
      body: MyBackground(
          child: Column(
        children: [
          SizedBox(height: 250),
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
