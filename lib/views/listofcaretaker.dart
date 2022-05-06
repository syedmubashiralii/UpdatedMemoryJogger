// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        appBar: AppBar(title: Text('List OF Caretakers'),systemOverlayStyle: SystemUiOverlayStyle.light,backgroundColor: Color.fromARGB(144, 41, 105, 165),),
        body: MyBackground(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: FutureBuilder(
                      future: getallcaretakers(),
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
                              itemCount: caretakerlist.length,
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
                                    onTap: () {},
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(Utilities
                                              .baseurl +
                                          caretakerlist[index].pic.toString()),
                                    ),
                                    title: Text(
                                      caretakerlist[index].cname.toUpperCase(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    subtitle: Text(
                                      caretakerlist[index].cemail.toString(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    trailing: Text(
                                      caretakerlist[index]
                                          .crelation
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
