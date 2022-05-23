// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/models/getstartedmodel.dart';
import 'package:flutter_application_mj/views/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart' as ap;
import '../../controllers/utilites.dart';
import 'package:just_audio/just_audio.dart';

class GetStartedData extends StatefulWidget {
  const GetStartedData({Key? key}) : super(key: key);

  @override
  State<GetStartedData> createState() => _GetStartedDataState();
}

class _GetStartedDataState extends State<GetStartedData> {
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
  List<Getstartedmodel> getstartedlist = [];
  Future<List<Getstartedmodel>> getstarted() async {
    final response = await http.get(Uri.parse(Utilities.baseurl +
        '/memoryjogger/api/getstarted/getstarted?memory=' +
        Utilities.getstarted));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      getstartedlist.clear();
      print("===========");
      print(data);
      print("=====");

      for (Map<String, dynamic> i in data) {
        getstartedlist.add(Getstartedmodel.fromJson(i));
      }
      print(getstartedlist.length.toString());
      return getstartedlist;
    } else {
      return getstartedlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SizedBox(
                width: 63,
              ),
              Text(Utilities.getstarted.toUpperCase()),
            ],
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: MyBackground(
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                    child: FutureBuilder(
                  future: getstarted(),
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
                          itemCount: getstartedlist.length,
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
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.deepPurple,
                                            blurRadius: 20)
                                      ]),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Container(
                                            height: 35,
                                            width: 35,
                                            color: Colors.white,
                                            child: Center(
                                              child: Text(
                                                "${currentpage + 1}/" +
                                                    getstartedlist.length
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
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
                                                              getstartedlist[
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
                                                            .withOpacity(0.4)
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
                                                                getstartedlist[
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
                                      SizedBox(
                                        height: 15,
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
                                                child: Text(
                                                    getstartedlist[index]
                                                        .memorytype
                                                        .toString()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
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
                                                child: Text(
                                                    getstartedlist[index]
                                                        .pdate
                                                        .toString()
                                                        .split(' ')[0]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
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
                                                child: Text(
                                                    getstartedlist[index]
                                                        .memorydec
                                                        .toString()),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 80,
                                      ),
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
