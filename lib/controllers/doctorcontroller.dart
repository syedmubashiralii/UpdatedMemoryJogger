import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mj_app/controllers/utilites.dart';
import 'package:http/http.dart' as http;
import 'package:mj_app/models/picturesmodel.dart';
import '../models/doctormodel.dart';
import '../views/constants.dart';

class DoctorController {
  Future<List<Picturesmodel>> getpictures() async {
    final response = await http.get(Uri.parse(
        Utilities.baseurl + '/memoryjogger/api/getstarted/allpictures'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      Utilities.pictureslist.clear();
      for (Map<String, dynamic> i in data) {
        Utilities.pictureslist.add(Picturesmodel.fromMap(i));
      }
      return Utilities.pictureslist;
    } else {
      return Utilities.pictureslist;
    }
  }
}
