import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/login_signup/caretaker_login.dart';
import 'package:flutter_application_mj/views/login_signup/doctor_login.dart';
import 'package:flutter_application_mj/views/patientfirstlook.dart';
import 'package:flutter_application_mj/views/widgets.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MyBackground(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              child: const Text(
                "Welcome to Memory Jogger",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            MyButton(
              text: "Get Started",
              fontWeight: FontWeight.bold,
              textSize: 16,
              onTap: () {
                // Navigator.pushNamed(context, '/patientfirstlook');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientFirstLook()),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              text: "Caretaker Panel",
              onTap: () {
                // Navigator.pushNamed(context, '/caretaker_login');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CaretakerLogin()),
                );
              },
            ),
            MyButton(
              text: "Doctor Panel",
              onTap: () {
                // Navigator.pushNamed(context, '/doctor_login');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorLogin()),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
