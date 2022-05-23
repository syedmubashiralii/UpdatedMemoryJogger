// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unused_import

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/patientrecord.dart';
import 'package:flutter_application_mj/views/widgets.dart';
import 'package:http/http.dart' as http;
import '../controllers/utilites.dart';
import '../models/caretakermodel.dart';

class ListOfCaretaker extends StatefulWidget {
  const ListOfCaretaker({Key? key}) : super(key: key);

  @override
  State<ListOfCaretaker> createState() => _ListOfCaretakerState();
}

class _ListOfCaretakerState extends State<ListOfCaretaker> {
  final TextStyle dropdownmenuitem =
      TextStyle(color: Colors.black, fontSize: 19);
  final primary = Color(0xFF5E35B1);
  final secondary = Color.fromARGB(255, 135, 128, 151);
  List<CaretakerModel> caretakerlist = [];

  Future<List<CaretakerModel>> getallcaretakers() async {
    final response = await http.get(Uri.parse(
        Utilities.baseurl + '/memoryjogger/api/caretaker/allcaretakers'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      caretakerlist.clear();
      for (Map<String, dynamic> i in data) {
        caretakerlist.add(CaretakerModel.fromJson(i));
      }
      return caretakerlist;
    } else {
      return caretakerlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: getallcaretakers(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CupertinoActivityIndicator(
                    radius: 25,
                    color: Colors.deepPurple,
                  ));
                } else {
                  return Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 145),
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        child: ListView.builder(
                            itemCount: caretakerlist.length,
                            itemBuilder: (BuildContext context, int index) {
                              return buildList(context, index);
                            }),
                      ),
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Caretakers",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.filter_list,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 110,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Material(
                                elevation: 5.0,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                child: TextField(
                                  // controller: TextEditingController(text: locations[0]),
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: dropdownmenuitem,
                                  decoration: InputDecoration(
                                      hintText: "Search caretaker",
                                      hintStyle: TextStyle(
                                          color: Colors.black38, fontSize: 16),
                                      prefixIcon: Material(
                                        elevation: 0.0,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        child: Icon(Icons.search),
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 13)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 110,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: InkWell(
        onTap: () {
          Utilities.id = caretakerlist[index].caretakerid.toInt();
          print(Utilities.id);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PatientRecord()));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 90,
              height: 90,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 2, color: secondary),
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    Utilities.baseurl + caretakerlist[index].pic.toString()),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    caretakerlist[index].cname,
                    style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.email_outlined,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(caretakerlist[index].cemail.toString(),
                          style: TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        CupertinoIcons.person_badge_plus,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(caretakerlist[index].crelation,
                          style: TextStyle(
                              color: primary, fontSize: 13, letterSpacing: .3)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
