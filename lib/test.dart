// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mj_app/controllers/utilites.dart';
// import 'package:mj_app/local_Notifications.dart';
// import 'package:mj_app/views/caretakerpanel/SetActivity/picturebasedactivity.dart';
// import 'package:mj_app/views/caretakerpanel/listofnotifications.dart';
// import 'package:mj_app/views/caretakerpanel/patient_pictures.dart';
// import 'package:mj_app/views/caretakerpanel/patient_remindars.dart';
// import 'package:mj_app/views/caretakerpanel/selectdoctor.dart';
// import 'package:mj_app/views/widgets.dart';
// import 'package:http/http.dart' as http;

// class MakeDashboardItems extends StatefulWidget {
//   const MakeDashboardItems({Key? key}) : super(key: key);

//   @override
//   _MakeDashboardItemsState createState() => _MakeDashboardItemsState();
// }

// class _MakeDashboardItemsState extends State<MakeDashboardItems> {
//   Card makeDashboardItem(String title, String img, int index) {
//     return Card(
//       elevation: 2,
//       margin: EdgeInsets.all(8),
//       child: Container(
//         decoration: index == 0 || index == 3
//             ? BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//                 gradient: LinearGradient(
//                   begin: FractionalOffset(0.0, 0.0),
//                   end: FractionalOffset(3.0, -1.0),
//                   colors: [
//                     Color(0xFF004B8D),
//                     Color(0xFFffffff),
//                   ],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.white,
//                     blurRadius: 3,
//                     offset: Offset(2, 2),
//                   )
//                 ],
//               )
//             : BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//                 gradient: LinearGradient(
//                   begin: FractionalOffset(0.0, 0.0),
//                   end: FractionalOffset(3.0, -1.0),
//                   colors: [
//                     Colors.cyan,
//                     Colors.amber,
//                   ],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.white,
//                     blurRadius: 3,
//                     offset: Offset(2, 2),
//                   )
//                 ],
//               ),
//         child: InkWell(
//           onTap: () {
//             if (index == 0) {
//               getpatientid(context);
//               print(Utilities.doctorid);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PatientPictures()),
//               );
//             }
//             if (index == 1) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PictureBasedActivity()),
//               );
//             }
//             if (index == 2) {
//               getpatientid(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PatientRemindars()),
//               );
//             }
//             if (index == 3) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SelectDoctor()),
//               );
//             }
//           },
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisSize: MainAxisSize.min,
//             verticalDirection: VerticalDirection.down,
//             children: [
//               SizedBox(height: 30),
//               Center(
//                   child: index == 0
//                       ? Icon(Icons.image)
//                       : index == 1
//                           ? Icon(Icons.local_activity)
//                           : index == 2
//                               ? Icon(Icons.alarm)
//                               : Icon(Icons.person)
                              
//                               ),
//               SizedBox(height: 30),
//               Center(
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                       fontSize: 19,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   initState() {
//     if (Utilities.notificationlist.isNotEmpty) {
//       MJNotification.notify("Alert!",
//           "You have Some notifications ,go check them out!!", "basic_channel");
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CupertinoNavigationBar(
//         middle: Text("DashBoard"),
//         leading: InkWell(
//             onTap: () {
//               Navigator.of(context).pushNamedAndRemoveUntil(
//                   '/caretaker_login', (Route<dynamic> route) => false);
//             },
//             child: Icon(Icons.arrow_back_rounded)),
//         trailing: InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ListOfNotification()),
//               );
//             },
//             child: Icon(
//               Icons.notifications,
//               color: Utilities.notificationlist.isNotEmpty
//                   ? Colors.green
//                   : Colors.black,
//             )),
//         backgroundColor: Colors.deepPurple,
//         brightness: Brightness.light,
//       ),
//       body: SingleChildScrollView(
//         child: MyBackground(
//           child: SafeArea(
//             child: Column(
//               children: [
//                 SizedBox(height: 100),
//                 Padding(
//                   padding: EdgeInsets.only(left: 16, right: 16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         "Flutter  Dashboard",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Expanded(
//                   child: GridView.count(
//                     crossAxisCount: 2,
//                     padding: EdgeInsets.all(2),
//                     children: [
//                       makeDashboardItem(
//                           "Pictures", "assets/images/reminder.png", 0),
//                       makeDashboardItem(
//                           "Activity", "assets/images/reminder.png", 1),
//                       makeDashboardItem(
//                           "Reminders", "assets/images/reminder.png", 2),
//                       makeDashboardItem(
//                           "Change Doctor", "assets/images/reminder.png", 3),
//                       // makeDashboardItem("Todo", "assets/images/reminder.png", 4),
//                       // makeDashboardItem(
//                       //     "Settings", "assets/images/reminder.png", 5),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> getpatientid(context) async {
//     print(Utilities.caretakerid.toString());
//     var response = await http.get(
//       Uri.parse(Utilities.baseurl +
//           "/memoryjogger/api/caretaker/getpatientid?cid=" +
//           Utilities.caretakerid.toString()),
//     );
//     if (response.statusCode == 200) {
//       Utilities.patientid = int.parse(response.body.toString());
//       print(Utilities.patientid);
//     } else {}
//   }
// }
