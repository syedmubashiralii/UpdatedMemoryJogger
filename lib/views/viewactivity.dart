import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../controllers/utilites.dart';
import '../models/patientmodel.dart';

class ViewActivity extends StatefulWidget {
  const ViewActivity({Key? key}) : super(key: key);

  @override
  State<ViewActivity> createState() => _ViewActivityState();
}

class _ViewActivityState extends State<ViewActivity> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  List<Patientmodel> haslist = [];
  Future<List<Patientmodel>> getpatient() async {
    final response = await http.get(Uri.parse(Utilities.baseurl +
        '/memoryjogger/api/patient/allpatient?cid=' +
        Utilities.id.toString() +
        ""));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      haslist.clear();
      for (Map<String, dynamic> i in data) {
        haslist.add(Patientmodel.fromMap(i));
      }
      return haslist;
    } else {
      return haslist;
    }
  }
}
