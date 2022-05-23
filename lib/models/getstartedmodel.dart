// To parse this JSON data, do
//
//     final getstartedmodel = getstartedmodelFromJson(jsonString);

import 'dart:convert';

Getstartedmodel getstartedmodelFromJson(String str) => Getstartedmodel.fromJson(json.decode(str));

String getstartedmodelToJson(Getstartedmodel data) => json.encode(data.toJson());

class Getstartedmodel {
    Getstartedmodel({
        required this.pictureid,
        required this.pic,
        required this.memorytype,
        required this.memorydec,
        this.docfeedback,
        this.docfeedbackdec,
        required this.pdate,
        required this.memorydecaudiofile,
        this.doctorid,
        this.patientid,
        this.caretakerid,
        required this.memory,
    });

    int pictureid;
    String pic;
    String memorytype;
    String memorydec;
    dynamic docfeedback;
    dynamic docfeedbackdec;
    DateTime pdate;
    String memorydecaudiofile;
    dynamic doctorid;
    dynamic patientid;
    dynamic caretakerid;
    String memory;

    factory Getstartedmodel.fromJson(Map<String, dynamic> json) => Getstartedmodel(
        pictureid: json["pictureid"],
        pic: json["pic"],
        memorytype: json["memorytype"],
        memorydec: json["memorydec"],
        docfeedback: json["docfeedback"],
        docfeedbackdec: json["docfeedbackdec"],
        pdate: DateTime.parse(json["pdate"]),
        memorydecaudiofile: json["memorydecaudiofile"],
        doctorid: json["doctorid"],
        patientid: json["patientid"],
        caretakerid: json["caretakerid"],
        memory: json["memory"],
    );

    Map<String, dynamic> toJson() => {
        "pictureid": pictureid,
        "pic": pic,
        "memorytype": memorytype,
        "memorydec": memorydec,
        "docfeedback": docfeedback,
        "docfeedbackdec": docfeedbackdec,
        "pdate": pdate.toIso8601String(),
        "memorydecaudiofile": memorydecaudiofile,
        "doctorid": doctorid,
        "patientid": patientid,
        "caretakerid": caretakerid,
        "memory": memory,
    };
}
