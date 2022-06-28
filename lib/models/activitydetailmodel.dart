// To parse this JSON data, do
//
//     final activtydetailmodel = activtydetailmodelFromMap(jsonString);

import 'dart:convert';

Activtydetailmodel activtydetailmodelFromMap(String str) => Activtydetailmodel.fromMap(json.decode(str));

String activtydetailmodelToMap(Activtydetailmodel data) => json.encode(data.toMap());

class Activtydetailmodel {
    Activtydetailmodel({
        required this.hid,
        required this.corevalue,
        required this.selectedoption,
        required this.activityid,
        required this.questionid,
        required this.aresult,
        required this.op1,
        required this.op2,
        required this.op3,
        required this.op4,
        this.picdata,
        required this.quedata,
        required this.memorytype,
    });

    int hid;
    String corevalue;
    String selectedoption;
    int activityid;
    int questionid;
    String aresult;
    String op1;
    String op2;
    String op3;
    String op4;
    dynamic picdata;
    String quedata;
    String memorytype;

    factory Activtydetailmodel.fromMap(Map<String, dynamic> json) => Activtydetailmodel(
        hid: json["hid"],
        corevalue: json["corevalue"],
        selectedoption: json["selectedoption"],
        activityid: json["activityid"],
        questionid: json["questionid"],
        aresult: json["aresult"],
        op1: json["op1"],
        op2: json["op2"],
        op3: json["op3"],
        op4: json["op4"],
        picdata: json["picdata"],
        quedata: json["quedata"],
        memorytype: json["memorytype"],
    );

    Map<String, dynamic> toMap() => {
        "hid": hid,
        "corevalue": corevalue,
        "selectedoption": selectedoption,
        "activityid": activityid,
        "questionid": questionid,
        "aresult": aresult,
        "op1": op1,
        "op2": op2,
        "op3": op3,
        "op4": op4,
        "picdata": picdata,
        "quedata": quedata,
        "memorytype": memorytype,
    };
}
