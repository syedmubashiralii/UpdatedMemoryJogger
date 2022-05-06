// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/widgets.dart';
class ListOfNotification extends StatefulWidget {
  const ListOfNotification({Key? key}) : super(key: key);

  @override
  State<ListOfNotification> createState() => _ListOfNotificationState();
}

class _ListOfNotificationState extends State<ListOfNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyBackground(
          child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 90),
                Text('Notifications',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 40,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child: Text(
                          'Changes suggested by doctor in patient interest memory')),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child:
                          Text('Changes suggested by doctor in patient data')),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
