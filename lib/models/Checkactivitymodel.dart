// To parse this JSON data, do
//
//     final checkactivitymodel = checkactivitymodelFromMap(jsonString);

import 'dart:convert';

Checkactivitymodel checkactivitymodelFromMap(String str) => Checkactivitymodel.fromMap(json.decode(str));

String checkactivitymodelToMap(Checkactivitymodel data) => json.encode(data.toMap());

class Checkactivitymodel {
    Checkactivitymodel({
        required this.activtyid,
        required this.aresult,
        required this.patientid,
        required this.caretakerid,
        required this.doctorid,
        required this.status,
        this.docstatus,
    });

    int activtyid;
    String aresult;
    int patientid;
    int caretakerid;
    int doctorid;
    String status;
    dynamic docstatus;

    factory Checkactivitymodel.fromMap(Map<String, dynamic> json) => Checkactivitymodel(
        activtyid: json["activtyid"],
        aresult: json["aresult"],
        patientid: json["patientid"],
        caretakerid: json["caretakerid"],
        doctorid: json["doctorid"],
        status: json["status"],
        docstatus: json["docstatus"],
    );

    Map<String, dynamic> toMap() => {
        "activtyid": activtyid,
        "aresult": aresult,
        "patientid": patientid,
        "caretakerid": caretakerid,
        "doctorid": doctorid,
        "status": status,
        "docstatus": docstatus,
    };
}
