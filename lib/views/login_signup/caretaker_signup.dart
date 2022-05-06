// ignore_for_file: avoid_print, prefer_const_constructors, prefer_typing_uninitialized_variables, annotate_overrides

import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../controllers/utilites.dart';
import '../widgets.dart';

class CaretakerSignup extends StatefulWidget {
  const CaretakerSignup({Key? key}) : super(key: key);
  @override
  State<CaretakerSignup> createState() => _CaretakerSignupState();
}

class _CaretakerSignupState extends State<CaretakerSignup> {
  int id = Utilities.caretakerid + 1;
  var fullname = TextEditingController();
  var email = TextEditingController();
  var relation = TextEditingController();
  var password = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late XFile? photo;
  io.File? imgfile;
  var _imageFile;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Caretaker Signup'),
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
                imageProfile(context),
                MyInputField(controller: fullname, hint: "N A M E"),
                MyInputField(controller: email, hint: "E M A I L"),
                MyInputField(controller: relation, hint: "R E L A T I O N"),
                MyPasswordInputField(controller: password, hint: "P A S S W O R D"),
                const SizedBox(
                  height: 10,
                ),
                MyButton(
                    text: "Sign Up",
                    onTap: () {
                      uploadFile(_imageFile);
                    }),
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
    print('Image path ' + f.path);
    EasyLoading.show();
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(Utilities.baseurl +
            "/memoryjogger/api/caretaker/Upload?username=" +
            fullname.text +
            "&email=" +
            email.text +
            "&relation=" +
            relation.text +
            "&password=" +
            password.text));
    request.files.add(await http.MultipartFile.fromPath('photo', f.path));

    request.headers.addAll({'Content-type': 'multipart/formdata'});
    print('sending request...');

    var res = await request.send();
    print('response received....');

    if (res.statusCode == 200) {
      print('OK Call');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Caretaker added Successfully!")));
      EasyLoading.dismiss();
      Navigator.pushNamed(context, '/caretaker_login');
    } else {
      print('Not Uploaded');
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Oops!Something went wrong")));
    }
  }
}
