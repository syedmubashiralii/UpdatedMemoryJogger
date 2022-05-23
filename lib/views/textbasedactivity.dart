// ignore_for_file: prefer_const_constructors, avoid_print, prefer_typing_uninitialized_variables
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_mj/views/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/utilites.dart';

class TextBasedActivity extends StatefulWidget {
  const TextBasedActivity({Key? key}) : super(key: key);

  @override
  State<TextBasedActivity> createState() => _TextBasedActivityState();
}

class _TextBasedActivityState extends State<TextBasedActivity> {
  final ImagePicker _picker = ImagePicker();
  var _imageFile;
  var prompt = TextEditingController();
  var op1 = TextEditingController();
  var op2 = TextEditingController();
  var op3 = TextEditingController();
  var op4 = TextEditingController();
  var corevalue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("Text Based Activity"),
        leading: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/after_login_caretaker');
          },
          child: Icon(Icons.arrow_back_rounded),
        ),
        backgroundColor: Colors.deepPurple,
        transitionBetweenRoutes: true,
      ),
      body: MyBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(
                      "Picture Based Activity",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: CupertinoSwitch(
                      value: Utilities.state,
                      onChanged: (value) {
                        Utilities.state = value;
                        setState(() {
                          Navigator.pushNamed(context, '/picturebasedactivity');
                          Utilities.state = false;
                        });
                      },
                      activeColor: Colors.white,
                      thumbColor: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
              MyInputField(
                controller: prompt,
                hint: 'Enter Prompt',
              ),
              SizedBox(height: 10),
              imageProfile(context),
              SizedBox(height: 10),
              MyInputField(
                controller: op1,
                hint: 'Option 1',
              ),
              // SizedBox(height: 10),
              MyInputField(
                controller: op2,
                hint: 'Option 2',
              ),
              // SizedBox(height: 10),
              MyInputField(
                controller: op3,
                hint: 'Option 3',
              ),
              // SizedBox(height: 10),
              MyInputField(
                controller: op4,
                hint: 'option 4',
              ),
              // SizedBox(height: 10),
              MyInputField(
                controller: corevalue,
                hint: 'Core Value',
              ),
              SizedBox(height: 10),
              MyButton(
                  text: 'ADD',
                  onTap: () {
                    if (_imageFile == null ||
                        op1.text == "" ||
                        op2.text == "" ||
                        op3.text == "" ||
                        op4.text == "" ||
                        corevalue.text == "") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please Enter Complete Data!")));
                      return;
                    } else {
                      uploadFile(_imageFile);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  //op1
  Widget imageProfile(context) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            // ignore: unnecessary_null_comparison
            backgroundImage: _imageFile == null
                ? AssetImage('assets/images/question.jpg') as ImageProvider
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
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.blue,
                    size: 28.0,
                  ),
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

  void takePhoto(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: source, imageQuality: 50);

    setState(() {
      _imageFile = io.File(pickedFile!.path);
    });
  }

  Future<void> uploadFile(io.File f) async {
    EasyLoading.show();
    print('Image path ' + f.path);
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(Utilities.baseurl +
            "/memoryjogger/api/TextActivity/textbasedactivity?question=" +
            prompt.text +
            "&op1=" +
            op1.text +
            "&op2=" +
            op2.text +
            "&op3=" +
            op3.text +
            "&op4=" +
            op4.text +
            "&corevalue=" +
            corevalue.text));
    request.files.add(await http.MultipartFile.fromPath('photo', f.path));
    request.headers.addAll({'Content-type': 'multipart/formdata'});
    print('sending request...');
    var res = await request.send();
    print('response received....');
    if (res.statusCode == 200) {
      print('OK Call');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Activity added Successfully!")));
      EasyLoading.dismiss();
      // Navigator.pushNamed(context, '/patient_pictures');
    } else {
      print('Not Uploaded');
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Oops!Something went wrong")));
    }
  }
}
