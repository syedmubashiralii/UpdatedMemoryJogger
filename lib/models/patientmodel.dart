// To parse this JSON data, do
//
//     final patientmodel = patientmodelFromMap(jsonString);

import 'dart:convert';

Patientmodel patientmodelFromMap(String str) =>
    Patientmodel.fromMap(json.decode(str));

String patientmodelToMap(Patientmodel data) => json.encode(data.toMap());

class Patientmodel {
  Patientmodel({
    required this.patientid,
    required this.pic,
    required this.pname,
    required this.age,
    required this.gender,
    required this.caretakerid,
  });

  int patientid;
  String pic;
  String pname;
  int age;
  String gender;
  int caretakerid;

  factory Patientmodel.fromMap(Map<String, dynamic> json) => Patientmodel(
        patientid: json["patientid"],
        pic: json["pic"],
        pname: json["pname"],
        age: json["age"],
        gender: json["gender"],
        caretakerid: json["caretakerid"],
      );

  Map<String, dynamic> toMap() => {
        "patientid": patientid,
        "pic": pic,
        "pname": pname,
        "age": age,
        "gender": gender,
        "caretakerid": caretakerid,
      };
}
