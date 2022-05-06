// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/after_login_caretaker.dart';
import 'package:flutter_application_mj/views/patient_personal_info.dart';
import 'package:flutter_application_mj/views/patient_pictures.dart';
import 'package:flutter_application_mj/views/patient_remindars.dart';
import 'package:flutter_application_mj/views/splash.dart';
import '../controllers/utilites.dart';

//mybutton widget

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  String text;
  double? textSize = 12;
  FontWeight? fontWeight = FontWeight.w600;
  VoidCallback onTap;
  MyButton(
      {Key? key,
      required this.text,
      this.textSize,
      this.fontWeight,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          width: Utilities.getSize(context).width * 0.5,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white)),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// My Background

// ignore: must_be_immutable
class MyBackground extends StatefulWidget {
  Widget child;
  MyBackground({Key? key, required this.child}) : super(key: key);

  @override
  State<MyBackground> createState() => _MyBackgroundState();
}

class _MyBackgroundState extends State<MyBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      height: Utilities.getSize(context).height,
      width: Utilities.getSize(context).width,
      child: widget.child,
      // color: Colors.deepPurple,
      decoration: const BoxDecoration(
          //color: Colors.teal,
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage("assets/images/background_image.png"),
      )),
    );
  }
}

//myinputfield

// ignore: must_be_immutable
class MyInputField extends StatefulWidget {
  TextEditingController controller;
  String hint;
  MyInputField({Key? key, required this.controller, required this.hint})
      : super(key: key);

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(15),
      //   border: Border.all(width: 1,color: Colors.white),
      // ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: TextField(
            controller: widget.controller,
            style: const TextStyle(fontSize: 20, color: Colors.white60),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
              ),
              hintText: widget.hint,
              hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white54
                  ),
            )),
      ),
    );
  }
}

//mypasswordinput field

// ignore: must_be_immutable
class MyPasswordInputField extends StatefulWidget {
  TextEditingController controller;
  String hint;
  MyPasswordInputField({Key? key, required this.controller, required this.hint})
      : super(key: key);

  @override
  State<MyPasswordInputField> createState() => _MyPasswordInputFieldState();
}

class _MyPasswordInputFieldState extends State<MyPasswordInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: TextField(
            controller: widget.controller,
            obscureText: true,
            obscuringCharacter: '✤',
            style: const TextStyle(fontSize: 20, color: Colors.white60),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
              ),
              hintText: widget.hint,
              hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white54),
            )),
      ),
    );
  }
}

// drawer widget

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Container(
          color: Colors.blueAccent,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/mainlogo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Memory Jogger",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    )),
              ],
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text("Home",
              style: TextStyle(
                fontSize: 16,
              )),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AfterLoginCaretaker()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text("Personal Information",
              style: TextStyle(
                fontSize: 16,
              )),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientPersonalInfo()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.picture_in_picture_sharp),
          title: const Text("Pictures",
              style: TextStyle(
                fontSize: 16,
              )),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientPictures()),
            );
          },
        ),
        // ListTile(
        //   leading: Icon(Icons.notification_important),
        //   title: const Text("Remindars",
        //       style: TextStyle(
        //         fontSize: 16,
        //       )),
        //   onTap: () {
        //    Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) =>  PatientRemindars()),
        //   );
        //   },
        // ),
        ListTile(
          leading: Icon(Icons.logout_outlined),
          title: Text("Logout",
              style: TextStyle(
                fontSize: 16,
              )),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Splash()),
            );
          },
        ),
      ],
    ));
  }
}


//circular avatar
