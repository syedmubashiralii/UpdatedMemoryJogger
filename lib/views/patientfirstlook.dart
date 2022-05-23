// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter_application_mj/controllers/utilites.dart';
import 'package:flutter_application_mj/views/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientFirstLook extends StatefulWidget {
  const PatientFirstLook({Key? key}) : super(key: key);

  @override
  State<PatientFirstLook> createState() => _PatientFirstLookState();
}

class _PatientFirstLookState extends State<PatientFirstLook> {
  String text = 'IKRAM';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyBackground(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Text(
                    'Hi Mr. $text',
                    style: GoogleFonts.bebasNeue(fontSize: 32),
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.deepPurple.withOpacity(0.5),
                            blurRadius: 10)
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60.0,
                      // backgroundColor: Colors.grey[400],
                      backgroundImage: AssetImage('assets/images/patient.jpg')
                          as ImageProvider,
                    ),
                  ),
                ),
                SizedBox(height: 80),
                MyButton(
                    onTap: () {
                      Navigator.pushNamed(context, '/getstarted');
                      Utilities.getstarted = "general";
                      print(Utilities.getstarted);
                    },
                    text: "General"),
                MyButton(
                    onTap: () {
                      Navigator.pushNamed(context, '/getstarted');
                      Utilities.getstarted = "Education";
                      print(Utilities.getstarted);
                    },
                    text: "Education"),
                MyButton(
                    onTap: () {
                      Navigator.pushNamed(context, '/getstarted');
                      Utilities.getstarted = "people";
                      print(Utilities.getstarted);
                    },
                    text: "People"),
                MyButton(
                    onTap: () {
                      Navigator.pushNamed(context, '/getstarted');
                      Utilities.getstarted = "interests";
                      print(Utilities.getstarted);
                    },
                    text: "interests"),
                MyButton(
                    onTap: () {
                      Navigator.pushNamed(context, '/getstarted');
                      Utilities.getstarted = "profession";
                      print(Utilities.getstarted);
                    },
                    text: "Profession")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
