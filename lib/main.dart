// ignore_for_file: prefer_const_constructors, avoid_print
import 'dart:convert';

import 'package:mj_app/controllers/reminderController.dart';
import 'package:mj_app/controllers/utilites.dart';
import 'package:mj_app/local_Notifications.dart';
import 'package:mj_app/models/reminderModel.dart';
import 'package:mj_app/test.dart';
import 'package:mj_app/views/caretakerpanel/SetActivity/activityscreenI.dart';
import 'package:mj_app/views/caretakerpanel/SetActivity/picturebasedactivity.dart';
import 'package:mj_app/views/caretakerpanel/SetActivity/textbasedactivity.dart';
import 'package:mj_app/views/doctorpanel/activitydetail.dart';
import 'package:mj_app/views/doctorpanel/checkactivity.dart';
import 'package:mj_app/views/getstarted/listofreminders.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mj_app/views/doctorpanel/modificationdetail.dart';
import 'package:mj_app/views/AppStart.dart';
import 'package:mj_app/views/caretakerpanel/after_login_caretaker.dart';
import 'package:mj_app/views/getstarted/Activity/Activity.dart';
import 'package:mj_app/views/getstarted/getstarted.dart';
import 'package:mj_app/views/doctorpanel/listofcaretaker.dart';
import 'package:mj_app/views/caretakerpanel/listofnotifications.dart';
import 'package:mj_app/views/login_signup/caretaker_login.dart';
import 'package:mj_app/views/login_signup/caretaker_signup.dart';
import 'package:mj_app/views/login_signup/doctor_login.dart';
import 'package:mj_app/views/login_signup/doctor_signup.dart';
import 'package:mj_app/views/caretakerpanel/patient_personal_info.dart';
import 'package:mj_app/views/caretakerpanel/patient_pictures.dart';
import 'package:mj_app/views/caretakerpanel/patient_remindars.dart';
import 'package:mj_app/views/getstarted/patientfirstlook.dart';
import 'package:mj_app/views/caretakerpanel/selectdoctor.dart';
import 'package:mj_app/views/splashscr.dart';
import 'package:mj_app/views/doctorpanel/verifydata.dart';

import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  try {
    AwesomeNotifications().initialize(null, [
      NotificationChannel(
          channelKey: "basic_channel",
          channelName: "Basic Channel",
          channelDescription: "Channel for send alert to users",
          importance: NotificationImportance.High,
          defaultColor: Color(0xFF9D50DD),
          channelShowBadge: true),
      NotificationChannel(
          channelGroupKey: 'category_tests',
          channelKey: 'alarm_channel',
          channelName: 'Alarms Channel',
          channelDescription: 'Channel with alarm ringtone',
          defaultColor: Color(0xFF9D50DD),
          importance: NotificationImportance.Max,
          ledColor: Colors.white,
          channelShowBadge: true,
          locked: true,
          defaultRingtoneType: DefaultRingtoneType.Alarm),
    ]);
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    MJNotification.listenMJNotification();
  } catch (ex) {
    print(ex);
  }
  runApp(

      // ChangeNotifierProvider(
      //   create: ((context) => AppBloc()),
      //   child:
      MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
    ),
    builder: EasyLoading.init(),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => ListOfReminders(),
      '/aftersplash': (context) => AppStart(),
      '/caretaker_login': (context) => CaretakerLogin(),
      '/caretaker_signup': (context) => CaretakerSignup(),
      '/doctor_login': (context) => DoctorLogin(),
      '/doctor_signup': (context) => DoctorSignup(),
      '/after_login_caretaker': (context) => AfterLoginCaretaker(),
      '/patient_personal_info': (context) => PatientPersonalInfo(),
      '/patient_pictures': (context) => PatientPictures(),
      '/activityscreenI': (context) => ActivityScreenI(),
      '/patientfirstlook': (context) => PatientFirstLook(),
      '/patient_remindars': (context) => PatientRemindars(),
      '/picturebasedactivity': (context) => PictureBasedActivity(),
      '/textbasedactivity': (context) => TextBasedActivity(),
      '/selectdoctor': (context) => SelectDoctor(),
      '/listofcaretaker': (context) => ListOfCaretaker(),
      '/listofnotification': (context) => ListOfNotification(),
      '/getstarted': (context) => GetStartedData(),
      '/verifydata': (context) => VerifyData(),
      '/modificationdetail': (context) => ModificationDetail(),
      '/checkdata': (context) => CheckActivity(),
    },
  ));
}

// git remote add origin https://github.com/syedmubashiralii/FYP.git
// git branch -M main
// git push -u origin main

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initializeService();
//   runApp(const MyApp());
// }

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');

  return true;
}

void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  //DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  // SharedPreferences preferences = await SharedPreferences.getInstance();
  // await preferences.setString("hello", "world");

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // bring to foreground
  Timer.periodic(const Duration(minutes: 1), (timer) async {
    // final hello = preferences.getString("hello");
    // print(hello);
    var now = DateTime.now();
    if (now.hour == 8 && now.minute == 0) {
      MJNotification.notify(
          "Breakfast Reminder!", "Its breakfast time.", "alarm_channel");
    } else if (now.hour == 14 && now.minute == 0) {
      MJNotification.notify(
          "Lunch Reminder!", "Its Lunck time.", "alarm_channel");
    } else if (now.hour == 21 && now.minute == 0) {
      MJNotification.notify(
          "Dinner Reminder!", "Its Dinner time.", "alarm_channel");
    }
    List<ReminderModel> reminders = await ReminderController.getReminders();
    for (var item in reminders) {
      var now = DateTime.now();
      var day = now.day < 10 ? "0${now.day}" : now.day.toString();
      var month = now.month < 10 ? "0${now.month}" : now.month.toString();
      var date = "${now.year}-$month-$day";
      var minute = now.minute < 10 ? "0${now.minute}" : now.minute.toString();
      print(date);
      var time = "${now.hour}:$minute";
      print(time);
      if (item.rdate == date && item.rtime == time) {
        MJNotification.notify(
            "${item.rtype} Reminder!", item.rdesc.toString(), "alarm_channel");
      }
    }
    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "My App Service",
        content: "Updated at ${DateTime.now()}",
      );
    }

    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

    // test using external plugin
    final deviceInfo = DeviceInfoPlugin();
    String? device;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.model;
    }

    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.model;
    }

    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
        "device": device,
      },
    );
  });
}
