// ignore_for_file: prefer_const_constructors, unused_import, prefer_typing_uninitialized_variables, avoid_print
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/patient_pictures.dart';
import 'package:flutter_application_mj/views/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../controllers/utilites.dart';

class PatientPersonalInfo extends StatefulWidget {
  const PatientPersonalInfo({Key? key}) : super(key: key);
  @override
  State<PatientPersonalInfo> createState() => _PatientPersonalInfoState();
}

class _PatientPersonalInfoState extends State<PatientPersonalInfo> {
  var name = TextEditingController();
  var age = TextEditingController();
  var spouse = TextEditingController();
  var gender = TextEditingController();
  var education = TextEditingController();
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
        appBar: AppBar(
          title: Text('Patient Personal Information'),
        ),
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
                MyInputField(controller: name, hint: "Name"),
                MyInputField(controller: age, hint: "Age"),
                MyInputField(controller: spouse, hint: "Spouse"),
                MyInputField(controller: gender, hint: "Gender"),
                MyInputField(controller: education, hint: "Education"),

                const SizedBox(
                  height: 10,
                ),
                MyButton(
                    text: "S U B M I T",
                    onTap: () {
                      if (_imageFile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Select Picture First!")));
                        return;
                      } else {
                        uploadFile(_imageFile);
                      }
                    }),
                MyButton(
                    text: "N E X T",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientPictures()),
                      );
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
                ? AssetImage('assets/images/patient.jpg') as ImageProvider
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

  Future<void> uploadFile(io.File f) async {
    EasyLoading.show();
    print('Image path ' + f.path);
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(Utilities.baseurl +
            "/memoryjogger/api/patient/UploadPatient?name=" +
            name.text +
            "&age=" +
            age.text +
            "&spouse=" +
            spouse.text +
            "&gender=" +
            gender.text ));
    request.files.add(await http.MultipartFile.fromPath('photo', f.path));
    request.headers.addAll({'Content-type': 'multipart/formdata'});
    print('sending request...');
    print(Utilities.caretakerid.toString());
    var res = await request.send();
    print('response received....');
    if (res.statusCode == 200) {
      print('OK Call');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Patient added Successfully!")));
      EasyLoading.dismiss();
      Navigator.pushNamed(context, '/patient_pictures');
    } else {
      print('Not Uploaded');
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Oops!Something went wrong")));
    }
  }
}
