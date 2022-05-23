// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/getstarted/getstarted.dart';
import 'package:flutter_application_mj/views/login_signup/caretaker_login.dart';
import 'package:flutter_application_mj/views/login_signup/doctor_login.dart';
import 'package:flutter_application_mj/views/patientfirstlook.dart';
import 'package:flutter_application_mj/views/AppStart.dart';
import 'package:flutter_application_mj/views/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/utilites.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Color(0xFFFFFF);
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(18),
            height: Utilities.getSize(context).height,
            width: Utilities.getSize(context).width,
            color: Colors.deepPurple,
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            blurRadius: 25)
                      ],
                    ),
                    child: Text(
                      "WelCome TO Memory Jogger!",
                      style: GoogleFonts.bebasNeue(fontSize: 52),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ButtonPurple(
                      text: "Get Started",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientFirstLook()),
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonPurple(
                      text: "Caretaker Panel",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CaretakerLogin()),
                        );
                      }),
                  ButtonPurple(
                      text: "Doctor Panel",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorLogin()),
                        );
                      }),
                  SizedBox(
                    height: 200,
                  ),
                  CupertinoActivityIndicator(
                    radius: 22,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
