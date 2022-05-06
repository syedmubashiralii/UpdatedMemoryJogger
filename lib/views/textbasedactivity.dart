// ignore_for_file: prefer_const_constructors
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_mj/views/widgets.dart';
import 'package:image_picker/image_picker.dart';

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
      appBar: AppBar(
        title: Text("Text Based Activity"),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Color.fromARGB(144, 41, 105, 165),
      ),
      body: MyBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              MyInputField(controller: prompt, hint: 'Enter Prompt'),
              SizedBox(height: 10),
              imageProfile(context),
              // Center(
              //   child: CircleAvatar(
              //     radius: 70.0,
              //     backgroundImage: AssetImage("assets/images/question.jpg"),
              //   ),
              // ),
              SizedBox(height: 10),
              MyInputField(controller: op1, hint: 'Option 1'),
              SizedBox(height: 10),
              MyInputField(controller: op2, hint: 'Option 2'),
              SizedBox(height: 10),
              MyInputField(controller: op3, hint: 'Option 3'),
              SizedBox(height: 10),
              MyInputField(controller: op4, hint: 'option 4'),
              SizedBox(height: 10),
              MyInputField(controller: corevalue, hint: 'Core Value'),
              SizedBox(height: 10),
              MyButton(text: 'ADD NEW ACIVITY', onTap: () {}),
              MyButton(text: 'EXIT', onTap: () {}),
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
}
