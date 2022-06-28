import 'dart:convert';

import 'package:mj_app/controllers/utilites.dart';
import 'package:http/http.dart' as http;
import 'package:mj_app/models/reminderModel.dart';

class ReminderController {
  static Future<List<ReminderModel>> getReminders() async {
    List<ReminderModel> reminders = [];
    try {
      String url =
          Utilities.baseurl + "/memoryjogger/api/reminder/allreminders";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        for (var item in json) {
          reminders.add(ReminderModel.fromJson(item));
        }
      }
    } catch (ex) {
      print(ex);
    }
    return reminders;
  }

  static Future<List<ReminderModel>> specificreminder() async {
    List<ReminderModel> reminder = [];
    var now = DateTime.now();
    var day = now.day < 10 ? "0${now.day}" : now.day.toString();
    var month = now.month < 10 ? "0${now.month}" : now.month.toString();
    var date = "${now.year}-$month-$day";
    try {
      String url = Utilities.baseurl +
          "/memoryjogger/api/reminder/specificreminder?date=" +
          date.toString();
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        for (var item in json) {
          reminder.add(ReminderModel.fromJson(item));
        }
      }
    } catch (ex) {
      print(ex);
    }
    return reminder;
  }
}
