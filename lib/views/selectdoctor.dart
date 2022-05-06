// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/widgets.dart';
import '../controllers/utilites.dart';
import 'package:http/http.dart' as http;

import '../models/doctormodel.dart';

class SelectDoctor extends StatefulWidget {
  const SelectDoctor({Key? key}) : super(key: key);

  @override
  State<SelectDoctor> createState() => _SelectDoctorState();
}

class _SelectDoctorState extends State<SelectDoctor> {
  // List<DoctorModel> doctorlist = [];

  Future<List<DoctorModel>> getalldoctors() async {
    final response = await http.get(
        Uri.parse(Utilities.baseurl + '/memoryjogger/api/doctor/alldoctors'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      Utilities.doctorlist.clear();
      for (Map<String, dynamic> i in data) {
        Utilities.doctorlist.add(DoctorModel.fromJson(i));
      }
      return Utilities.doctorlist;
    } else {
      return Utilities.doctorlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('L i s t   OF   D o c t o r s')),
        body: MyBackground(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: FutureBuilder(
                      future: getalldoctors(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.blueAccent,
                              backgroundColor: Colors.grey,
                              value: 0.8,
                            ),
                          );
                        } else {
                          return ListView.builder(
                              itemCount: Utilities.doctorlist.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 15),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            blurRadius: 20)
                                      ],
                                      borderRadius: BorderRadius.circular(18),
                                      color: Colors.white70),
                                  child: ListTile(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => DoctorOnTap(
                                      //             doctor: Utilities.doctorlist[index])));
                                      Utilities.doctorid = int.parse(Utilities
                                          .doctorlist[index].doctorid
                                          .toString());
                                      print(Utilities.doctorid);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("You Selected  " +
                                                  Utilities
                                                      .doctorlist[index].dname
                                                      .toString() +
                                                  " as your Instructor")));
                                    },
                                    leading: Hero(
                                      tag: Utilities.doctorlist[index].doctorid,
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            Utilities.baseurl +
                                                Utilities.doctorlist[index].pic
                                                    .toString()),
                                      ),
                                    ),
                                    title: Text(
                                      Utilities.doctorlist[index].dname
                                          .toUpperCase(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    subtitle: Text(
                                      Utilities.doctorlist[index].ddes
                                          .toString(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    trailing: Text(
                                      Utilities.doctorlist[index].dedu
                                          .toUpperCase(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              });
                        }
                      }),
                )
              ],
            ),
          ),
        ));
  }
}

// class DoctorOnTap extends StatefulWidget {
//   dynamic doctor;
//   DoctorOnTap({Key? key, required this.doctor}) : super(key: key);

//   @override
//   State<DoctorOnTap> createState() => _DoctorOnTapState();
// }

// class _DoctorOnTapState extends State<DoctorOnTap> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.doctor("dname").toString()),
//         ),
//       body: Column(
//         children: [
//           Hero(
//               tag: widget.doctor('doctorid'),
//               child: Image(
//                   image: NetworkImage(widget.doctor('pic')[0].toString()))),
//           Text(widget.doctor['dname'].toString()),
//         ],
//       ),
//     );
//   }
//}
