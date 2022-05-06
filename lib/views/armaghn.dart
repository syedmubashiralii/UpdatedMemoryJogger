// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class armaghan extends StatefulWidget {
  const armaghan({ Key? key }) : super(key: key);

  @override
  State<armaghan> createState() => _armaghanState();
}

class _armaghanState extends State<armaghan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(child: Text("Case Title")),
                SizedBox(width: 25,),
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(top: 20),
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                 color: Colors.purple,border: Border.all(color: Colors.black, width: 2)),
      child: TextField(
        
          style: const TextStyle(fontSize: 16, color: Colors.black),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
              
            ),
            
            hintText: "CAse",
            hintStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          ),
                )
              ],
            ),




            
            SizedBox(height: 15,),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.purple,border: Border.all(color: Colors.black, width: 2)),
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.add))
              ],
            )
          ],
        ),
      ),
      
    );
  }
}