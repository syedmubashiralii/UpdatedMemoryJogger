// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/activityscreenI.dart';
import 'package:flutter_application_mj/views/after_login_caretaker.dart';
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
import 'package:flutter_application_mj/views/textbasedactivity.dart';
import 'package:flutter_application_mj/views/viewtopatient.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MaterialApp(
    builder: EasyLoading.init(),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => PictureBasedActivity(),
      '/aftersplash': (context) => Splash(),
      '/caretaker_login': (context) => CaretakerLogin(),
      '/caretaker_signup': (context) => CaretakerSignup(),
      '/doctor_login': (context) => DoctorLogin(),
      '/doctor_signup': (context) => DoctorSignup(),
      '/after_login_caretaker': (context) => AfterLoginCaretaker(),
      '/patient_personal_info': (context) => PatientPersonalInfo(),
      '/patient_pictures': (context) => PatientPictures(),
      '/activityscreenI': (context) => ActivityScreenI(),
      '/patientfirstlook': (context) => PatientFirstLook(),
      '/viewtopatient': (context) => ViewToPatient(),
      '/patient_remindars': (context) => PatientRemindars(),
      '/picturebasedactivity': (context) => PictureBasedActivity(),
      '/textbasedactivity': (context) => TextBasedActivity(),
      '/selectdoctor': (context) => SelectDoctor(),
      '/listofcaretaker': (context) => ListOfCaretaker(),
      '/listofnotification': (context) => ListOfNotification(),
    },
  ));
}
