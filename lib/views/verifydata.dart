// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/models/getstartedmodel.dart';
import 'package:flutter_application_mj/views/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart' as ap;
import '../../controllers/utilites.dart';
import 'package:just_audio/just_audio.dart';

import '../models/picturesmodel.dart';

class VerifyData extends StatefulWidget {
  const VerifyData({Key? key}) : super(key: key);

  @override
  State<VerifyData> createState() => _VerifyDataState();
}

class _VerifyDataState extends State<VerifyData> {
  MaterialBanner _showMaterialBanner(BuildContext context) {
    return MaterialBanner(
        content: Text('Data verified Successfully!'),
        leading: Icon(
          Icons.warning,
          color: Colors.deepPurple,
        ),
        padding: EdgeInsets.all(2),
        backgroundColor: Colors.white,
        contentTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Container(
              //color: Colors.deepPurple,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.deepPurple,
              ),

              padding:
                  EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 10),
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ]);
  }

  var pagecont = PageController();
  int currentpage = 0;
  @override
  void initState() {
    super.initState();
    pagecont.addListener(() {
      setState(() {});
      currentpage = pagecont.page!.toInt();
      setState(() {});
    });
  }

  ap.AudioPlayer player = ap.AudioPlayer();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text("Verify Data"),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_rounded),
          ),
          backgroundColor: Colors.deepPurple,
          transitionBetweenRoutes: true,
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
                  future: getpictures(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CupertinoActivityIndicator(
                          radius: 25,
                          color: Colors.deepPurple,
                        ),
                      );
                    } else {
                      return PageView.builder(
                          controller: pagecont,
                          itemCount: Utilities.pictureslist.length,
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
                                            blurRadius: 5)
                                      ]),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Container(
                                            height: 45,
                                            width: 45,
                                            color: Colors.deepPurple,
                                            child: Center(
                                              child: Text(
                                                "${currentpage + 1}/" +
                                                    Utilities
                                                        .pictureslist.length
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 15,
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
                                                              Utilities
                                                                  .pictureslist[
                                                                      index]
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
                                                            .withOpacity(0.6)
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter)),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional
                                                  .bottomEnd,
                                              child: InkWell(
                                                onTap: () async {
                                                  try {
                                                    await player.setAudioSource(
                                                        AudioSource.uri(
                                                            Uri.parse(Utilities
                                                                    .baseurl +
                                                                Utilities
                                                                    .pictureslist[
                                                                        index]
                                                                    .memorydecaudiofile
                                                                    .toString())));
                                                    player.play();
                                                  } catch (ex) {
                                                    print(ex);
                                                  }
                                                },
                                                child: Container(
                                                    height: 45,
                                                    width: 45,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10,
                                                            right: 10),
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              blurRadius: 10)
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: Colors.white),
                                                    child:
                                                        Icon(Icons.play_arrow)),
                                              ),
                                            )
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
                                                  "Memory Description: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Text(Utilities
                                                    .pictureslist[index]
                                                    .memorydec
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
                                                  "Memory Date: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Text(Utilities
                                                    .pictureslist[index].pdate
                                                    .toString()
                                                    .split(' ')[0]),
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
                                                  "Memory Type: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Text(Utilities
                                                    .pictureslist[index]
                                                    .memorytype
                                                    .toString()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          OutlinedButton.icon(
                                              onPressed: () {
                                                Utilities.pictureid = Utilities
                                                    .pictureslist[index]
                                                    .pictureid;
                                                Utilities.dfeedback = "Ok";
                                                Utilities.dfeedbackdes = "Ok";
                                                verifydata();
                                              },
                                              icon: Icon(Icons
                                                  .arrow_circle_up_outlined),
                                              label: Text("Accept")),
                                          OutlinedButton.icon(
                                              onPressed: () {
                                                Utilities.pictureid = Utilities
                                                    .pictureslist[index]
                                                    .pictureid;
                                                Utilities.dfeedback =
                                                    "Rejected";
                                                Utilities.dfeedbackdes =
                                                    "Rejected";
                                                verifydata();
                                              },
                                              icon:
                                                  Icon(Icons.coronavirus_sharp),
                                              label: Text("Reject")),
                                        ],
                                      ),
                                      Center(
                                          child: OutlinedButton.icon(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.mobiledata_off_rounded),
                                              label: Text("Modify"))),
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

  Future<void> verifydata() async {
    var request = http.Request(
        'POST',
        Uri.parse(Utilities.baseurl +
            '/memoryjogger/api/pictures/updatedes?pid=' +
            Utilities.pictureid.toString() +
            "&dfeed=" +
            Utilities.dfeedback +
            "&dfeeddes=" +
            Utilities.dfeedbackdes));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      ScaffoldMessenger.of(context)
          .showMaterialBanner(_showMaterialBanner(context));
    } else {
      print(response.reasonPhrase);
    }
  }
}
