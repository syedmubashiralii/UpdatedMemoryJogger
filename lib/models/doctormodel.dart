// To parse this JSON data, do
//
//     final doctorModel = doctorModelFromJson(jsonString);

import 'dart:convert';

DoctorModel doctorModelFromJson(String str) =>
    DoctorModel.fromJson(json.decode(str));

String doctorModelToJson(DoctorModel data) => json.encode(data.toJson());

class DoctorModel {
  DoctorModel({
    required this.doctorid,
    required this.pic,
    required this.dname,
    required this.demail,
    required this.ddes,
    required this.dedu,
    required this.dpassword,
  });

  int doctorid;
  String pic;
  String dname;
  String demail;
  String ddes;
  String dedu;
  String dpassword;

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        doctorid: json["doctorid"],
        pic: json["pic"],
        dname: json["dname"],
        demail: json["demail"],
        ddes: json["ddes"],
        dedu: json["dedu"],
        dpassword: json["dpassword"],
      );

  Map<String, dynamic> toJson() => {
        "doctorid": doctorid,
        "pic": pic,
        "dname": dname,
        "demail": demail,
        "ddes": ddes,
        "dedu": dedu,
        "dpassword": dpassword,
      };
}
