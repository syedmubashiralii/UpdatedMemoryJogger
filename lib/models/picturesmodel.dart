// To parse this JSON data, do
//
//     final picturesmodel = picturesmodelFromMap(jsonString);

import 'dart:convert';

Picturesmodel picturesmodelFromMap(String str) => Picturesmodel.fromMap(json.decode(str));

String picturesmodelToMap(Picturesmodel data) => json.encode(data.toMap());

class Picturesmodel {
    Picturesmodel({
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
        required this.caretakerid,
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

    factory Picturesmodel.fromMap(Map<String, dynamic> json) => Picturesmodel(
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

    Map<String, dynamic> toMap() => {
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
