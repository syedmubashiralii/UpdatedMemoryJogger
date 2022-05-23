import 'package:flutter/material.dart';
import 'package:flutter_application_mj/models/doctormodel.dart';
import 'package:flutter_application_mj/models/picturesmodel.dart';

class Utilities {
  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static bool isloading = false;
  static List<dynamic> data = [];
  static var baseurl = "http://192.168.43.24";
  static String dfeedback = "";
  static String dfeedbackdes = "";
  static int caretakerid = 0;
  static int doctorid = 0;
  static int pictureid = 0;
  static int patientid = 0;
  static String audiopath = "";
  static String imgpath = "";
  static List<DoctorModel> doctorlist = [];
  static List<Picturesmodel> pictureslist = [];
  static String getstarted = "";
  static int id = 0;
  static bool state = false;
}
