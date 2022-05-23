// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/models/patientmodel.dart';
import 'package:flutter_application_mj/models/picturesmodel.dart';
import 'package:flutter_application_mj/views/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart' as ap;
import '../../controllers/utilites.dart';
import 'package:just_audio/just_audio.dart';

class PatientRecord extends StatefulWidget {
  const PatientRecord({Key? key}) : super(key: key);

  @override
  State<PatientRecord> createState() => _PatientRecordState();
}

class _PatientRecordState extends State<PatientRecord> {
  var pagecont = PageController();
  @override
  void initState() {
    super.initState();
    pagecont.addListener(() {
      // setState(() {});
      // currentpage = pagecont.page!.toInt();
      // setState(() {});
    });
  }

  List<Patientmodel> patientlist = [];

  Future<List<Patientmodel>> getpatient() async {
    final response = await http.get(Uri.parse(Utilities.baseurl +
        '/memoryjogger/api/patient/allpatient?cid=' +
        Utilities.id.toString() +
        ""));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      patientlist.clear();
      for (Map<String, dynamic> i in data) {
        patientlist.add(Patientmodel.fromMap(i));
      }
      return patientlist;
    } else {
      return patientlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text("Patient Detail"),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_rounded),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: MyBackground(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: FutureBuilder(
                  future: getpatient(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: CupertinoActivityIndicator(
                        radius: 25,
                        color: Colors.deepPurple,
                      ));
                    } else {
                      return PageView.builder(
                          controller: pagecont,
                          itemCount: patientlist.length,
                          itemBuilder: ((context, index) {
                            return SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.deepPurple,
                                            blurRadius: 10)
                                      ]),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width: Utilities.getSize(context).width,
                                        height:
                                            Utilities.getSize(context).height *
                                                0.33,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: Utilities.getSize(context)
                                                  .width,
                                              height: Utilities.getSize(context)
                                                      .height *
                                                  0.33,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          Utilities.baseurl +
                                                              patientlist[index]
                                                                  .pic
                                                                  .toString()),
                                                      fit: BoxFit.cover)),
                                            ),
                                            Container(
                                              width: Utilities.getSize(context)
                                                  .width,
                                              height: Utilities.getSize(context)
                                                      .height *
                                                  0.33,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.transparent,
                                                        Colors.black
                                                            .withOpacity(0.4)
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: Utilities.getSize(context).width,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  blurRadius: 5)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                  "Patient Name: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Text(patientlist[index]
                                                    .pname
                                                    .toString()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: Utilities.getSize(context).width,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  blurRadius: 5)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                  "Gender ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Text(patientlist[index]
                                                    .gender
                                                    .toString()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: Utilities.getSize(context).width,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  blurRadius: 5)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                  "Age: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Text(patientlist[index]
                                                    .age
                                                    .toString()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      OutlinedButton.icon(
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  content: Text(
                                                      "Loading Data.....")));
                                          Navigator.pushNamed(
                                              context, '/verifydata');
                                        },
                                        icon: Icon(Icons.data_object_rounded),
                                        label: Text("Verify Data"),
                                        autofocus: true,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      OutlinedButton.icon(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    duration:
                                                        Duration(seconds: 1),
                                                    content: Text(
                                                        "Opening Activity.....")));
                                          },
                                          icon: Icon(Icons.quiz_rounded),
                                          label: Text("Check Activity")),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }));
                    }
                  },
                )),
              ],
            ),
          ),
        ));
  }
}
