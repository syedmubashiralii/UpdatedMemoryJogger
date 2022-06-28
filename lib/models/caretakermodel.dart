// To parse this JSON data, do
//
//     final caretakerModel = caretakerModelFromJson(jsonString);

import 'dart:convert';

CaretakerModel caretakerModelFromJson(String str) =>
    CaretakerModel.fromJson(json.decode(str));

String caretakerModelToJson(CaretakerModel data) => json.encode(data.toJson());

class CaretakerModel {
  CaretakerModel({
    required this.caretakerid,
    required this.pic,
    required this.cname,
    required this.cemail,
    required this.cpassword,
    required this.crelation,
    required this.doctorid,
  });

  int caretakerid;
  String pic;
  String cname;
  String cemail;
  String cpassword;
  String crelation;
  int doctorid;

  factory CaretakerModel.fromJson(Map<String, dynamic> json) => CaretakerModel(
        caretakerid: json["caretakerid"],
        pic: json["pic"],
        cname: json["cname"],
        cemail: json["cemail"],
        cpassword: json["cpassword"],
        crelation: json["crelation"],
        doctorid: json["doctorid"],
      );

  Map<String, dynamic> toJson() => {
        "caretakerid": caretakerid,
        "pic": pic,
        "cname": cname,
        "cemail": cemail,
        "cpassword": cpassword,
        "crelation": crelation,
        "doctorid": doctorid,
      };
}
