//import 'dart:io';
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/listofnotifications.dart';
import 'package:flutter_application_mj/views/patient_personal_info.dart';
import 'package:flutter_application_mj/views/patient_pictures.dart';
import 'package:flutter_application_mj/views/picturebasedactivity.dart';
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
        appBar: CupertinoNavigationBar(
          middle: Text("DashBoard"),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_rounded)),
          trailing: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListOfNotification()),
                );
              },
              child: Icon(Icons.notifications)),
          backgroundColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        body: SingleChildScrollView(
          child: MyBackground(
              child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 210),
                MyButton(
                    text: 'Add Memory',
                    onTap: () {
                      //Navigator.pushNamed(context, '/patient_personal_info');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientPictures()),
                      );
                    }),
                MyButton(
                    text: "Set Activity",
                    onTap: () {
                      //Navigator.pushNamed(context, '/activityscreenI');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PictureBasedActivity()),
                      );
                    }),
                MyButton(
                    text: "Update Memory",
                    onTap: () {
                      //Navigator.pushNamed(context, '/patient_personal_info');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientPictures()),
                      );
                    }),
                MyButton(
                    text: "Change Doctor",
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
          )),
        ));
  }
}
