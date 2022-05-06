// ignore_for_file: prefer_const_constructors, duplicate_ignore, avoid_print, avoid_unnecessary_containers, unrelated_type_equality_checks
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/controllers/utilites.dart';
import 'package:flutter_application_mj/views/record_example.dart';
import 'package:flutter_application_mj/views/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart' as ap;

class PatientPictures extends StatefulWidget {
  final task;
  const PatientPictures({
    Key? key,
    this.task,
  }) : super(key: key);

  @override
  State<PatientPictures> createState() => _PatientPicturesState();
}

class _PatientPicturesState extends State<PatientPictures> {
  DateTime date = DateTime.now();
  var pickedDate;
  var memorytype = TextEditingController();
  var memorydescription = TextEditingController();
  var keywords = TextEditingController();
  // Initial Selected Value
  String dropdownvalue = 'Profession';
  ap.AudioPlayer player = ap.AudioPlayer();
  //AudioPlayer audioPlayer = AudioPlayer();

  // List of items in our dropdown menu
  var items = [
    'Profession',
    'Education',
    'Interests',
    'People',
  ];

  final ImagePicker _picker = ImagePicker();
  var _imageFile;
  final record = Record();
  //ap.AudioSource? audioSource;
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
          title: Text('Patient Pictures'),
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ignore: prefer_const_constructors
                    Text(
                      'Select Memory ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    DropdownButton(
                      dropdownColor: Colors.blueAccent,
                      focusColor: Colors.white,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      underline: Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      value: dropdownvalue,
                      icon: const Icon(
                        CupertinoIcons.arrow_down_circle_fill,
                        color: Colors.white60,
                      ),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                        print(dropdownvalue);
                      },
                    ),
                  ],
                ),

                MyInputField(controller: memorytype, hint: "Memory Type"),
                //MyTextfield(hint: 'MemoryType', icon: Icons.abc_sharp, textEditingController: memorytype),
                MyInputField(
                    controller: memorydescription, hint: "Memory Description"),
                // MyInputField(controller: date, hint: "Date"),
                InkWell(
                  onTap: () async {
                    pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(20223));
                    if (pickedDate != null) {
                      date = DateTime.parse(pickedDate.toString());
                      print(date);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    padding: EdgeInsets.all(12),
                    width: Utilities.getSize(context).width,
                    height: 40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4), blurRadius: 5)
                      ],
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.9),
                                    blurRadius: 5)
                              ],
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.blueAccent,
                            ),
                            child: Icon(Icons.date_range_rounded)),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "SELECT DATE",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 5)
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    height: 70,
                    width: Utilities.getSize(context).width,
                    child: AudioRecorder(
                      onStop: (path) async {
                        setState(() {
                          //audioSource = ap.AudioSource.uri(Uri.parse(path));
                        });
                      },
                    )),
                MyButton(
                    text: "Next",
                    onTap: () async {
                      if (Utilities.audiopath.isEmpty&&memorydescription.text.isEmpty&&memorytype.text.isEmpty&&pickedDate.toString().isEmpty&&_imageFile.toString().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please enter complete data!")));
                        //return;
                      } else {
                        await uploadpatientpictures(
                            _imageFile, Utilities.audiopath);
                      }
                      // Navigator.pushNamed(context, '/patient_remindars');
                    }),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () async {
                      try {
                        print(Utilities.baseurl +
                            "/memoryjogger/Content/Audio/audio2391229551833672720.m4a");

                        // await audioPlayer.setUrl(Utilities.baseurl +
                        //     "/memoryjogger/Content/Audio/audio2391229551833672720.m4a");
                        await player.setAudioSource(AudioSource.uri(Uri.parse(
                            "http://192.168.43.24/memoryjogger/Content/Audio/audio7365682922559329978.m4a")));
                        // await player.setUrl(Utilities.baseurl +
                        //     "/memoryjogger/Content/Audio/audio2391229551833672720.m4a");
                        player.play();
                      } catch (ex) {
                        print(ex);
                      }
                    },
                    child: Center(
                        child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 5)
                                ],
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white),
                            child: Icon(Icons.play_arrow))))
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
                ? AssetImage('assets/images/memory.png') as ImageProvider
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

  Future<void> uploadpatientpictures(io.File f, String f1) async {
    print('Image path ' + f.path);
    print("audiopath" + f1);
    EasyLoading.show();
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(Utilities.baseurl +
            "/memoryjogger/api/pictures/PatientMemory?memory=" +
            dropdownvalue.toString() +
            "&memorytype=" +
            memorytype.text +
            "&memorydec=" +
            memorydescription.text +
            "&date=" +
            date.toString()));
    request.files.add(await http.MultipartFile.fromPath('photo', f.path));

    //request.headers.addAll({'Content-type': 'multipart/formdata'});

    request.files.add(await http.MultipartFile.fromPath('audio', f1));

    request.headers.addAll({'Content-type': 'multipart/formdata'});
    print('sending request...');

    var res = await request.send();
    print(res.statusCode);
    if (res.statusCode == 200) {
      print('OK Call');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Memory Added Successfully!")));
      EasyLoading.dismiss();
      // Navigator.pushNamed(context, '/');
    } else {
      print('Not Uploaded');
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Oops!Something went wrong")));
    }
  }
}
