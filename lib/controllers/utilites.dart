// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mj_app/models/PictureActivity.dart';
import 'package:mj_app/models/activitydetailmodel.dart';
import 'package:mj_app/models/notificationmodel.dart';
import 'package:mj_app/models/pastmemoriesmodel.dart';
import 'package:mj_app/models/patientmodel.dart';
import 'package:mj_app/models/reminderModel.dart';

import '../models/doctormodel.dart';
import '../models/picturesmodel.dart';
import '../models/getstartedmodel.dart';

class Utilities {
  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static bool isloading = false;
  static List<dynamic> data = [];
  static var baseurl = "http://192.168.43.24";
  static var textstyle = TextStyle(
      fontFamily: 'Montserrat Regular', fontSize: 18, color: Colors.red);
  static String dfeedback = "";
  static String dfeedbackdes = "";
  static int caretakerid = 0;
  static int doctorid = 0;
  static int activityid = 0;
  static int questionid = 0;
  static int pictureid = 0;
  static int hasid = 0;
  static int patientid = 0;
  static String Patientname = "Robert Patricia";
  static String patientpic =
      "/memoryjogger/Content/Uploads/scaled_image_picker5289255936800318378.png";
  static String audiopath = "";
  static String imgpath = "";
  static List<ReminderModel> reminderlist = [];
  static List<DoctorModel> doctorlist = [];
  static List<ReminderModel> upcomingeventslist = [];
  static List<PastMemoriesModel> pastmemorieslist = [];
  static List<DoctorModel> searchlist = [];
  static List<Notificationmodel> notificationlist = [];
  static List<Getstartedmodel> getstartedlist = [];
  static List<Picturesmodel> pictureslist = [];
  static List<Patientmodel> patientlist = [];
  static List<Activtydetailmodel> activitydetaillist = [];
  static String getstarted = "";
  static int id = 0;
  static bool state = false;
  static List<PictureBasedActivity> picactivitylist = [];
  static Map<String, String> requestHeaders = {};
}
