// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_mj/modificationdetail.dart';
import 'package:flutter_application_mj/views/after_login_caretaker.dart';
import 'package:flutter_application_mj/views/getstarted/getstarted.dart';
import 'package:flutter_application_mj/views/listofcaretaker.dart';
import 'package:flutter_application_mj/views/listofnotifications.dart';
import 'package:flutter_application_mj/views/login_signup/caretaker_login.dart';
import 'package:flutter_application_mj/views/login_signup/caretaker_signup.dart';
import 'package:flutter_application_mj/views/login_signup/doctor_login.dart';
import 'package:flutter_application_mj/views/login_signup/doctor_signup.dart';
import 'package:flutter_application_mj/views/patient_personal_info.dart';
import 'package:flutter_application_mj/views/patient_pictures.dart';
import 'package:flutter_application_mj/views/patient_remindars.dart';
import 'package:flutter_application_mj/views/patientfirstlook.dart';
import 'package:flutter_application_mj/views/picturebasedactivity.dart';
import 'package:flutter_application_mj/views/selectdoctor.dart';
import 'package:flutter_application_mj/views/splash.dart';
import 'package:flutter_application_mj/views/splashscr.dart';
import 'package:flutter_application_mj/views/AppStart.dart';
import 'package:flutter_application_mj/views/textbasedactivity.dart';
import 'package:flutter_application_mj/views/verifydata.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MaterialApp(
    builder: EasyLoading.init(),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => splashscreen(),
      '/aftersplash': (context) => AppStart(),
      '/caretaker_login': (context) => CaretakerLogin(),
      '/caretaker_signup': (context) => CaretakerSignup(),
      '/doctor_login': (context) => DoctorLogin(),
      '/doctor_signup': (context) => DoctorSignup(),
      '/after_login_caretaker': (context) => AfterLoginCaretaker(),
      '/patient_personal_info': (context) => PatientPersonalInfo(),
      '/patient_pictures': (context) => PatientPictures(),
      '/patientfirstlook': (context) => PatientFirstLook(),
      '/patient_remindars': (context) => PatientRemindars(),
      '/picturebasedactivity': (context) => PictureBasedActivity(),
      '/textbasedactivity': (context) => TextBasedActivity(),
      '/selectdoctor': (context) => SelectDoctor(),
      '/listofcaretaker': (context) => ListOfCaretaker(),
      '/listofnotification': (context) => ListOfNotification(),
      '/getstarted': (context) => GetStartedData(),
      '/verifydata': (context) => VerifyData(),
    },
  ));
}



// git remote add origin https://github.com/syedmubashiralii/FYP.git
// git branch -M main
// git push -u origin main