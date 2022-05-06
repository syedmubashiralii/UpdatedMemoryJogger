//import 'dart:io';
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/activityscreenI.dart';
import 'package:flutter_application_mj/views/listofnotifications.dart';
import 'package:flutter_application_mj/views/patient_personal_info.dart';
import 'package:flutter_application_mj/views/selectdoctor.dart';
import 'package:flutter_application_mj/views/widgets.dart';

class AfterLoginCaretaker extends StatefulWidget {
  const AfterLoginCaretaker({Key? key}) : super(key: key);

  @override
  State<AfterLoginCaretaker> createState() => _AfterLoginCaretakerState();
}

class _AfterLoginCaretakerState extends State<AfterLoginCaretaker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MyBackground(
            child: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListOfNotification()),
                    );
                  },
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  )),
            ],
          ),
          SizedBox(height: 30),
          MyButton(
              text: 'Add Patient',
              onTap: () {
                //Navigator.pushNamed(context, '/patient_personal_info');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientPersonalInfo()),
                );
              }),
          MyButton(
              text: "Set Activity",
              onTap: () {
                //Navigator.pushNamed(context, '/activityscreenI');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActivityScreenI()),
                );
              }),
          MyButton(
              text: "Update Patient",
              onTap: () {
                //Navigator.pushNamed(context, '/patient_personal_info');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientPersonalInfo()),
                );
              }),
          MyButton(
              text: "Select Doctor",
              onTap: () {
                //Navigator.pushNamed(context, '/selectdoctor');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectDoctor()),
                );
              }),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    )));
  }
}
