// To parse this JSON data, do
//
//     final notificationmodel = notificationmodelFromMap(jsonString);

import 'dart:convert';

Notificationmodel notificationmodelFromMap(String str) => Notificationmodel.fromMap(json.decode(str));

String notificationmodelToMap(Notificationmodel data) => json.encode(data.toMap());

class Notificationmodel {
    Notificationmodel({
        required this.docfeedbackdec,
        required this.docfeedback,
        required this.caretakerid,
    });

    String docfeedbackdec;
    String docfeedback;
    int caretakerid;

    factory Notificationmodel.fromMap(Map<String, dynamic> json) => Notificationmodel(
        docfeedbackdec: json["docfeedbackdec"],
        docfeedback: json["docfeedback"],
        caretakerid: json["caretakerid"],
    );

    Map<String, dynamic> toMap() => {
        "docfeedbackdec": docfeedbackdec,
        "docfeedback": docfeedback,
        "caretakerid": caretakerid,
    };
}
