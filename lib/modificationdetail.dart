// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/widgets.dart';

class ModificationDetail extends StatelessWidget {
  const ModificationDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("Modification Detail"),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_rounded),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: MyBackground(child: 
      Column(
        children: [
          Container(

          ),
        ],
      )),
    );
  }
}
