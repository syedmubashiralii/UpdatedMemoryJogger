// ignore_for_file: prefer_const_constructors
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../controllers/utilites.dart';
import '../widgets.dart';
//import 'package:permission_handler/permission_handler.dart';

class DoctorSignup extends StatefulWidget {
  const DoctorSignup({Key? key}) : super(key: key);

  @override
  State<DoctorSignup> createState() => _DoctorSignupState();
}

class _DoctorSignupState extends State<DoctorSignup> {
  var fullname = TextEditingController();
  var email = TextEditingController();
  var des = TextEditingController();
  var education = TextEditingController();
  var password = TextEditingController();
  var _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('                Doctor'),
          backgroundColor: Colors.deepPurple,
        ),
        body: MyBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  //
                  imageProfile(context),
                  const SizedBox(
                    height: 20,
                  ),
                  MyInputField(
                    controller: fullname,
                    hint: "Name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyInputField(
                    controller: email,
                    hint: "Email",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyInputField(
                    controller: des,
                    hint: "Doctor Description",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyInputField(
                    controller: education,
                    hint: "Education",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyPasswordInputField(
                    controller: password,
                    hint: "Password",
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  MyButton(
                      text: "Signup",
                      onTap: () async {
                        if (_imageFile == null ||
                            fullname.text == "" ||
                            email.text == "" ||
                            education.text == "" ||
                            des.text == "" ||
                            password.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text("Please enter complete data!")));
                          //return;
                        } else {
                          await uploadFileDoc(_imageFile);
                        }
                      }),
                ],
              ),
            ),
          ),
        ));
  }

  Widget imageProfile(context) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            // ignore: unnecessary_null_comparison
            backgroundImage: _imageFile == null
                ? AssetImage('assets/images/imrankhan.jpg') as ImageProvider
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

  Future<void> uploadFileDoc(io.File f) async {
    print('Image path ' + f.path);
    EasyLoading.show();
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(Utilities.baseurl +
            "/memoryjogger/api/doctor/Uploaddoc?name=" +
            fullname.text +
            "&email=" +
            email.text +
            "&des=" +
            des.text +
            "&edu=" +
            education.text +
            "&password=" +
            password.text));
    request.files.add(await http.MultipartFile.fromPath('photo', f.path));

    request.headers.addAll({'Content-type': 'multipart/formdata'});
    print('sending request...');

    var res = await request.send();
    print('response received....');
    if (res.statusCode == 200) {
      print('OK Call');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text("Doctor Added Successfully!")));
      EasyLoading.dismiss();
      Navigator.pushNamed(context, '/doctor_login');
    } else {
      print('Not Uploaded');
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text("Oops!Something went wrong")));
    }
  }
}
