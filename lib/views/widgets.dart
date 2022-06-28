// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member, unused_element, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mj_app/views/AppStart.dart';
import 'package:mj_app/views/caretakerpanel/patient_pictures.dart';
import '../controllers/utilites.dart';
import 'caretakerpanel/after_login_caretaker.dart';
import 'constants.dart';

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
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        width: Utilities.getSize(context).width * 0.9,
        padding: EdgeInsets.only(top: 16, bottom: 16),
        decoration: BoxDecoration(
          color: Colors.deepPurple[300],
          boxShadow: [
            BoxShadow(color: Colors.white.withOpacity(0.4), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
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
      color: Colors.grey[300],
      // decoration: const BoxDecoration(
      //     image: DecorationImage(
      //   fit: BoxFit.cover,
      //   image: AssetImage("assets/images/background_image.png"),
      // )
      // ),
    );
  }
}

class MyBackgroundPurple extends StatefulWidget {
  Widget child;
  MyBackgroundPurple({Key? key, required this.child}) : super(key: key);

  @override
  State<MyBackgroundPurple> createState() => _MyBackgroundPurpleState();
}

class _MyBackgroundPurpleState extends State<MyBackgroundPurple> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      height: Utilities.getSize(context).height,
      width: Utilities.getSize(context).width,
      child: widget.child,
      color: Colors.deepPurple[300],
      // decoration: const BoxDecoration(
      //     image: DecorationImage(
      //   fit: BoxFit.cover,
      //   image: AssetImage("assets/images/background_image.png"),
      // )
      // ),
    );
  }
}

class ButtonPurple extends StatelessWidget {
  String text;
  double? textSize = 12;
  FontWeight? fontWeight = FontWeight.w600;
  VoidCallback onTap;
  ButtonPurple(
      {Key? key,
      required this.text,
      this.textSize,
      this.fontWeight,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        width: Utilities.getSize(context).width * 0.9,
        padding: EdgeInsets.only(top: 16, bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.white.withOpacity(0.4), blurRadius: 10)
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.deepPurple[300],
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
      ),
    );
  }
}

//myinputfield

// ignore: must_be_immutable
class MyInputField extends StatefulWidget {
  TextEditingController controller;
  String hint;
  VoidCallback? onchanged;
  MyInputField({
    Key? key,
    required this.controller,
    required this.hint,
    this.onchanged,
  }) : super(key: key);

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: TextField(
          controller: widget.controller,
          decoration:
              InputDecoration(border: InputBorder.none, hintText: widget.hint),
        ),
      ),
    );
  }
}

MaterialBanner _showMaterialBanner(BuildContext context) {
  String text = "";
  return MaterialBanner(
      content: Text(text),
      leading: Icon(
        Icons.warning,
        color: Colors.deepPurple,
      ),
      padding: EdgeInsets.all(2),
      backgroundColor: Colors.white,
      contentTextStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: Colors.deepPurple),
      actions: [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
          child: Container(
            //color: Colors.deepPurple,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.deepPurple,
            ),

            padding: EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 10),
            child: Text(
              'Ok',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
//mypasswordinput field

// ignore: must_be_immutable
class MyPasswordInputField extends StatefulWidget {
  TextEditingController controller;
  String hint;

  MyPasswordInputField({
    Key? key,
    required this.controller,
    required this.hint,
  }) : super(key: key);

  @override
  State<MyPasswordInputField> createState() => _MyPasswordInputFieldState();
}

class _MyPasswordInputFieldState extends State<MyPasswordInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: TextField(
          controller: widget.controller,
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hint,
          ),
        ),
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
          padding: EdgeInsets.all(20),
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
        // ListTile(
        //   leading: const Icon(Icons.info),
        //   title: const Text("Personal Information",
        //       style: TextStyle(
        //         fontSize: 16,
        //       )),
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => PatientPersonalInfo()),
        //     );
        //   },
        // ),
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
              MaterialPageRoute(builder: (context) => AppStart()),
            );
          },
        ),
      ],
    ));
  }
}

//circularbutton
class CircularButton extends StatelessWidget {
  VoidCallback ontap;
  String text;
  CircularButton({Key? key, required this.ontap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Stack(children: [
        Container(
            height: Utilities.getSize(context).height * 0.15,
            width: Utilities.getSize(context).width * 0.32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 10)
              ],
            ),
            child: Center(
                child: Text(
              text,
              style: GoogleFonts.lato(
                  fontSize: 20,
                  textStyle:
                      TextStyle(color: Colors.deepPurple, letterSpacing: .123)),
            ))),
        Container(
          height: Utilities.getSize(context).height * 0.15,
          width: Utilities.getSize(context).width * 0.32,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  colors: [Colors.black26, Colors.deepPurple.withOpacity(0.8)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight)),
        ),
      ]),
    );
  }
}

class NavBox extends StatefulWidget {
  String buttonText;
  VoidCallback onPress;
  NavBox({Key? key, required this.buttonText, required this.onPress})
      : super(key: key);

  @override
  _NavBoxState createState() => _NavBoxState();
}

class _NavBoxState extends State<NavBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPress,
      child: Container(
        padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
        width: Constants.screenWidth(context),
        decoration: BoxDecoration(
            color: Constants.primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            )),
        child: Text(
          widget.buttonText,
          textAlign: TextAlign.center,
          // style: FontStyle(24, Colors.white, FontWeight.w400),
        ),
      ),
    );
  }
}
