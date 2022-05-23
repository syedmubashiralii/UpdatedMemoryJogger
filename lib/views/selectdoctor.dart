// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_constructors_in_immutables
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/patient_personal_info.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../controllers/utilites.dart';
import 'package:http/http.dart' as http;

import '../models/doctormodel.dart';

class SelectDoctor extends StatefulWidget {
  const SelectDoctor({Key? key}) : super(key: key);

  @override
  State<SelectDoctor> createState() => _SelectDoctorState();
}

class _SelectDoctorState extends State<SelectDoctor> {
  final TextStyle dropdownmenuitem =
      TextStyle(color: Colors.black, fontSize: 19);
  final primary = Color(0xFF5E35B1);
  final secondary = Color.fromARGB(255, 135, 128, 151);
  //List<DoctorModel> doctorlist = [];

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
      backgroundColor: Color(0xfff0f0f0),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: getalldoctors(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CupertinoActivityIndicator(
                      radius: 25,
                      color: Colors.deepPurple,
                    ),
                  );
                } else {
                  return Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 145),
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        child: ListView.builder(
                            itemCount: Utilities.doctorlist.length,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                "Doctors",
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
                                      hintText: "Search Doctor",
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
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  DoctorOnTap(doctor: Utilities.doctorlist[index])));
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
                backgroundImage: NetworkImage(Utilities.baseurl +
                    Utilities.doctorlist[index].pic.toString()),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Text(
                  Utilities.doctorlist[index].dname,
                  style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DoctorOnTap extends StatefulWidget {
  final DoctorModel doctor;
  DoctorOnTap({Key? key, required this.doctor}) : super(key: key);

  @override
  State<DoctorOnTap> createState() => _DoctorOnTapState();
}

class _DoctorOnTapState extends State<DoctorOnTap> {
  final primary = Color(0xFF5E35B1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                    'Details',
                    style: TextStyle(color: Colors.white, fontSize: 22),
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
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 13),
            child: Column(
              children: [
                Container(
                  width: Utilities.getSize(context).width,
                  height: Utilities.getSize(context).height * 0.33,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      image: DecorationImage(
                          image: NetworkImage(
                              Utilities.baseurl + widget.doctor.pic.toString()),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: Utilities.getSize(context).width,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3), blurRadius: 5)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            "Doctor Name: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            child: Text(widget.doctor.dname.toString())),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Utilities.getSize(context).width,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3), blurRadius: 5)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            "Doctor Email: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            child: Text(widget.doctor.demail.toString())),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Utilities.getSize(context).width,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3), blurRadius: 5)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            "Doctor Education: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            child: Text(widget.doctor.dedu.toString())),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Utilities.getSize(context).width,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3), blurRadius: 5)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            "Doctor Description: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(widget.doctor.ddes.toString()),
                        ),
                      ),
                    ],
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
                Utilities.doctorid = widget.doctor.doctorid.toInt();
                UpdateDoctorid();
              },
              icon: Icon(Icons.self_improvement),
              label: Text("Select")),
        ],
      ),
    );
  }

  Future<void> UpdateDoctorid() async {
    EasyLoading.show();
    var request = await http.post(Uri.parse(Utilities.baseurl +
        "/memoryjogger/api/caretaker/Updatedid?cid=" +
        Utilities.caretakerid.toString() +
        "&did=" +
        Utilities.doctorid.toString()));

    if (request.statusCode == 200) {
      print('OK Call');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
              "You Selected ${widget.doctor.dname.toString()} as your instructor!")));
      EasyLoading.dismiss();
      Navigator.pushNamed(context, '/patient_personal_info');
    } else {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text("Oops!Something went wrong")));
    }
  }
}
