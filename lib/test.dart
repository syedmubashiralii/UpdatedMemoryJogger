// ignore_for_file: prefer_const_constructors

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mj_app/models/doctormodel.dart';

import 'controllers/utilites.dart';


class SectionSearchScreen extends StatefulWidget {
  const SectionSearchScreen({Key? key}) : super(key: key);

  @override
  _SectionSearchScreenState createState() => _SectionSearchScreenState();
}

class _SectionSearchScreenState extends State<SectionSearchScreen> {
  // FOR TEXT STYLE
  var textstyle = TextStyle(fontFamily: 'Montserrat Regular',fontSize: 14,color: Color.fromRGBO(63, 63, 63, 1));
  // FOR SEARCH ANIMATION
  bool _folded = true;
  // FOR TEXT EDITING CONTROLLER
  TextEditingController? _textEditingController = TextEditingController(); 

  // FOR LOAD DATA ON SCREEN SHOW //
  void initState(){
   super.initState();
    getalldoctors();
  }


  // FOR HANDLE SECTION SEARCH RESULT
  List<DoctorModel> sectionListOnSearch = [];
  // FETCH TEACHER FROM API //
  List<DoctorModel> sectionTable=[];
  // DISTICT LIST //

  Future<List<DoctorModel>> getalldoctors() async {
    final response = await http.get(
        Uri.parse(Utilities.baseurl + '/memoryjogger/api/doctor/alldoctors'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      sectionTable.clear();
      for (Map<String, dynamic> i in data) {
        sectionTable.add(DoctorModel.fromJson(i));
      }
      return sectionTable;
    } else {
      return sectionTable;
    }
  }


  // Future<void> ShowOnlySections(String sname) async{
  //   var response=await http.get(Uri.parse('http://192.168.56.1/meyepro/api/TimeTableOverall/getOnlySection?sname='+sname));
  //   if(response.statusCode==200)
  //   {
  //     //return json.decode(response.body)['response'];
  //     print("Successfull Show Record");
  //     //print(response.body);

  //     Iterable listt = jsonDecode(response.body);
  //     sectionTable = listt.map((e) => TimeTableOverall.fromJson(e)).toList();
  //     // final uniqueJsonList = sectionTable.toSet().toList();
  //     setState(() {

  //     });
  //     //var res=json.decode(response.body);
  //     //return res.map<student>((json)=>student.fromJson(json)).toList();
  //   }
  //   else
  //     throw Exception('Failed to load data');

  // }

  @override
  Widget build(BuildContext context) {

    var seen = Set<String>();
    List<DoctorModel> uniquelist = sectionTable.where((s) => seen.add(s.dname)).toList();

    return Scaffold(
     


      
      body: RefreshIndicator(
        onRefresh: getalldoctors,
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 15,),
                AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  width: _folded ? 56 : 300,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white,
                    boxShadow: kElevationToShadow[6],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 16),
                          child: !_folded ? TextField(
                            onChanged: (value){
                              setState(() {
                                sectionListOnSearch = uniquelist.where((element) => element.dname.toLowerCase().contains(value.toLowerCase())).toList();
                              });
                            },
      
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              hintText: 'Search Section',
                              hintStyle: TextStyle(color: Colors.blue),
                              border: InputBorder.none,
                            ),
                          ) : null,
                        ),
                      ),
      
                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        child: Material(
                          type:  MaterialType.transparency,
                          child: InkWell(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(_folded ? 32 : 0),
                              topRight: Radius.circular(32),
                              bottomLeft: Radius.circular(_folded ? 32 : 0),
                              bottomRight: Radius.circular(32),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(
                                _folded ? Icons.search : Icons.close,
                                color: Colors.blue,
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                _folded = !_folded;
                                sectionListOnSearch.clear();
                                _textEditingController!.clear();
                                _textEditingController!.text = '';
                              });
                            },
                          ),
                        ),
                      ),
      
                      // LIST VIEW FOR SEARCH
                    ],
                  ),
                ),
      
                Expanded(
                  child: _textEditingController!.text.isNotEmpty && sectionListOnSearch.isEmpty?
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off,size: 50,color: Colors.blue,),
                        Text('No Result Found',style: textstyle,),
                      ],
                    ),
                  ) :
                  ListView.builder(
                  itemCount: _textEditingController!.text.isNotEmpty ? sectionListOnSearch.length : uniquelist.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Icon(Icons.account_circle),
                            ),
                            SizedBox(width: 5,),
                            Text(_textEditingController!.text.isNotEmpty ? sectionListOnSearch[index].dname : uniquelist[index].dname,style: textstyle,),
                          ],
                        ),
                      ),
                      onTap: (){
                        String sectionname=uniquelist[index].dname;
                        
                        List<DoctorModel> data=[];
                        for(int i=0;i<sectionTable.length;i++)
                        {
                          if(sectionTable[i].dname==sectionname)
                          data.add(sectionTable[i]);
                        }
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => SectionOnClick(overall: uniquelist[index],sectiontimetable:data,)));
                        },
                    ); 
                  },
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}