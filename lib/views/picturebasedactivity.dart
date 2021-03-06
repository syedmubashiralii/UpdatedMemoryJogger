// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_cast, prefer_typing_uninitialized_variables, unused_import, avoid_print
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/controllers/utilites.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_mj/views/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PictureBasedActivity extends StatefulWidget {
  const PictureBasedActivity({Key? key}) : super(key: key);

  @override
  State<PictureBasedActivity> createState() => _PictureBasedActivityState();
}

class _PictureBasedActivityState extends State<PictureBasedActivity> {
  var prompt = TextEditingController();
  var corevalue = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var _imageFile;
  var _imageFile1;
  var _imageFile2;
  var _imageFile3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("Picture Based Activity"),
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
        child: SafeArea(
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
                        "Text Based Activity",
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
                            Navigator.pushNamed(context, '/textbasedactivity');
                            //Utilities.state = false;
                          });
                        },
                        trackColor: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
                MyInputField(
                  controller: prompt,
                  hint: 'Enter Prompt',
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    imageProfile(context),
                    imageProfile1(context),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    imageProfile2(context),
                    imageProfile3(context),
                  ],
                ),
                SizedBox(height: 25),
                MyInputField(
                  controller: corevalue,
                  hint: 'Core Value(Option 1/2/3/4)',
                ),
                SizedBox(height: 35),
                MyButton(
                    text: 'ADD ',
                    onTap: () async {
                      if (prompt.text == "" ||
                          corevalue.text == "" ||
                          _imageFile == null ||
                          _imageFile1 == null ||
                          _imageFile2 == null ||
                          _imageFile3 == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text("Please enter complete data!")));
                        //return;
                      } else {
                        await uploadFile(
                            _imageFile, _imageFile1, _imageFile2, _imageFile3);
                      }
                    }),
              ],
            ),
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
                ? AssetImage('assets/images/1.png') as ImageProvider
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
                    color: Colors.deepPurple,
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
                Colors.deepPurple;
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
                Colors.deepPurple;
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

  //op2
  Widget imageProfile1(context) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            // ignore: unnecessary_null_comparison
            backgroundImage: _imageFile1 == null
                ? AssetImage('assets/images/2.png') as ImageProvider
                : FileImage(io.File(_imageFile1!.path)),
          ),
          Positioned(
              right: 25.0,
              bottom: 0.0,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet1(context)),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.deepPurple,
                    size: 28.0,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget bottomSheet1(context) {
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
                Colors.deepPurple;
                takePhoto1(ImageSource.camera);
              },
              icon: Icon(Icons.camera_alt),
              label: Text("camera"),
            ),
            SizedBox(
              width: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Colors.deepPurple;
                takePhoto1(ImageSource.gallery);
              },
              icon: Icon(Icons.image),
              label: Text("Gallery"),
            )
          ],
        )
      ]),
    );
  }

  void takePhoto1(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: source, imageQuality: 50);

    setState(() {
      _imageFile1 = io.File(pickedFile!.path);
    });
  }

  //op3
  Widget imageProfile2(context) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            // ignore: unnecessary_null_comparison
            backgroundImage: _imageFile2 == null
                ? AssetImage('assets/images/3.png') as ImageProvider
                : FileImage(io.File(_imageFile2!.path)),
          ),
          Positioned(
              right: 25.0,
              bottom: 0.0,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet2(context)),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.deepPurple,
                    size: 28.0,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget bottomSheet2(context) {
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
                Colors.deepPurple;
                takePhoto2(ImageSource.camera);
              },
              icon: Icon(Icons.camera_alt),
              label: Text("camera"),
            ),
            SizedBox(
              width: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Colors.deepPurple;
                takePhoto2(ImageSource.gallery);
              },
              icon: Icon(Icons.image),
              label: Text("Gallery"),
            )
          ],
        )
      ]),
    );
  }

  void takePhoto2(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: source, imageQuality: 50);

    setState(() {
      _imageFile2 = io.File(pickedFile!.path);
    });
  }

  //op4
  Widget imageProfile3(context) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            // ignore: unnecessary_null_comparison
            backgroundImage: _imageFile3 == null
                ? AssetImage('assets/images/4.png') as ImageProvider
                : FileImage(io.File(_imageFile3!.path)),
          ),
          Positioned(
              right: 25.0,
              bottom: 0.0,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet3(context)),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.deepPurple,
                    size: 28.0,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget bottomSheet3(context) {
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
                Colors.deepPurple;
                takePhoto3(ImageSource.camera);
              },
              icon: Icon(Icons.camera_alt),
              label: Text("camera"),
            ),
            SizedBox(
              width: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Colors.deepPurple;
                takePhoto3(ImageSource.gallery);
              },
              icon: Icon(Icons.image),
              label: Text("Gallery"),
            )
          ],
        )
      ]),
    );
  }

  void takePhoto3(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: source, imageQuality: 50);

    setState(() {
      _imageFile3 = io.File(pickedFile!.path);
    });
  }

  Future<void> uploadFile(io.File f, io.File f1, io.File f2, io.File f3) async {
    EasyLoading.show();
    print('Image path ' + f.path);
    print('Image path ' + f1.path);
    print('Image path ' + f2.path);
    print('Image path ' + f3.path);

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(Utilities.baseurl +
            "/memoryjogger/api/Activity/picturebasedactivity?question=" +
            prompt.text +
            "&corevalue=" +
            corevalue.text));
    request.files.add(await http.MultipartFile.fromPath('photo', f.path));
    request.files.add(await http.MultipartFile.fromPath('photoo', f1.path));
    request.files.add(await http.MultipartFile.fromPath('photooo', f2.path));
    request.files.add(await http.MultipartFile.fromPath('photoooo', f3.path));
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
