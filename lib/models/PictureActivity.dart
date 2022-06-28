// To parse this JSON data, do
//
//     final pictureBasedActivity = pictureBasedActivityFromMap(jsonString);

import 'dart:convert';

PictureBasedActivity pictureBasedActivityFromMap(String str) =>
    PictureBasedActivity.fromMap(json.decode(str));

String pictureBasedActivityToMap(PictureBasedActivity data) =>
    json.encode(data.toMap());

class PictureBasedActivity {
  PictureBasedActivity({
    required this.questionid,
    required this.quedata,
    this.picdata,
    required this.op1,
    required this.op2,
    required this.op3,
    required this.op4,
    required this.quetype,
    required this.corevalue,
  });

  int questionid;
  String quedata;
  dynamic picdata;
  String op1;
  String op2;
  String op3;
  String op4;
  String quetype;
  String corevalue;

  factory PictureBasedActivity.fromMap(Map<String, dynamic> json) =>
      PictureBasedActivity(
        questionid: json["questionid"],
        quedata: json["quedata"],
        picdata: json["picdata"],
        op1: json["op1"],
        op2: json["op2"],
        op3: json["op3"],
        op4: json["op4"],
        quetype: json["quetype"],
        corevalue: json["corevalue"],
      );

  Map<String, dynamic> toMap() => {
        "questionid": questionid,
        "quedata": quedata,
        "picdata": picdata,
        "op1": op1,
        "op2": op2,
        "op3": op3,
        "op4": op4,
        "quetype": quetype,
        "corevalue": corevalue,
      };
}
