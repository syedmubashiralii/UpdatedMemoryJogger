// ignore_for_file: prefer_const_constructors
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/widgets.dart';
import 'package:image_picker/image_picker.dart';


class PatientRemindars extends StatefulWidget {
  const PatientRemindars({Key? key}) : super(key: key);

  @override
  State<PatientRemindars> createState() => _PatientRemindarsState();
}

class _PatientRemindarsState extends State<PatientRemindars> {
  var remindartype = TextEditingController();
  var remindardescription = TextEditingController();
  var date = TextEditingController();
  var time = TextEditingController();

  // ignore: unused_field
  //final _dropdownvalue='Memory';

  dropdowncallback(String? selectedValue) {
    // ignore: unused_local_variable
    String _dropdownvalue = 'interest';
    if (selectedValue is String) {
      setState(() {
        _dropdownvalue = selectedValue;
      });
    }
  }

  final ImagePicker _picker = ImagePicker();
  var _imageFile;
  //File file;
 void takePhoto(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: source, imageQuality: 50);
    setState(() {
      _imageFile = io.File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Remindars'),),
        drawer: const MainDrawer(),
        body: MyBackground(
            child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Visibility(visible: file != null, child: Image.file(file)),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                const SizedBox(
                  height: 30,
                ),
                imageProfile(context),
                MyInputField(controller: remindartype, hint: "Remindar Type"),
                MyInputField(
                    controller: remindardescription,
                    hint: "Remindar Description"),
                MyInputField(controller: date, hint: "Date"),
                MyInputField(controller: time, hint: "Time"),
          
                const SizedBox(
                  height: 10,
                ),
                MyButton(text: "Next", onTap: () {}),
              ],
            ),
          ),
        )));
  }
  Widget imageProfile(context) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            // ignore: unnecessary_null_comparison
            backgroundImage: _imageFile == null
                ? AssetImage('assets/images/reminder.png') as ImageProvider
                : FileImage(io.File(_imageFile!.path)),
          ),
          Positioned(
              right: 25.0,
              bottom: 0.0,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet(context)),
                  );
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.blue,
                  size: 28.0,
                ),
              ))
        ],
      ),
    );
  }

  Widget bottomSheet(context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(children: <Widget>[
        Text(
          "Choose photo",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              icon: Icon(Icons.camera_alt),
              label: Text("camera"),
            ),
            SizedBox(
              width: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              icon: Icon(Icons.image),
              label: Text("Gallery"),
            )
          ],
        )
      ]),
    );
  }
}
