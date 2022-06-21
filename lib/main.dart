// ignore_for_file: prefer_const_constructors
import 'package:mj_app/Bloc/appbloc.dart';
import 'package:mj_app/test.dart';
import 'package:mj_app/views/caretakerpanel/SetActivity/activityscreenI.dart';
import 'package:mj_app/views/caretakerpanel/SetActivity/picturebasedactivity.dart';
import 'package:mj_app/views/caretakerpanel/SetActivity/textbasedactivity.dart';
import 'package:mj_app/views/doctorpanel/activitydetail.dart';
import 'package:mj_app/views/doctorpanel/checkactivity.dart';
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
import 'local_Notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    AwesomeNotifications().initialize(null, [
      NotificationChannel(
          channelKey: "basic_channel",
          channelName: "Basic Channel",
          channelDescription: "Channel for send alert to users",
          importance: NotificationImportance.High,
          defaultColor: const Color.fromARGB(255, 0, 0, 0),
          channelShowBadge: true)
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
      '/': (context) => splashscreen(),
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
