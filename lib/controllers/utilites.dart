import 'package:flutter/material.dart';
import 'package:flutter_application_mj/models/doctormodel.dart';

class Utilities {
  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static bool isloading = false;
  static List<dynamic> data = [];
  static var baseurl = "http://192.168.43.24";
  static int caretakerid=0;
  static int doctorid = 0;
  static int patientid = 0;
  static String audiopath = "";
  static String imgpath = "";
  static List<DoctorModel> doctorlist = [];
}
