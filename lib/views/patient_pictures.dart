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
  String text = "Select Date";
  //AudioPlayer audioPlayer = AudioPlayer();

  // List of items in our dropdown menu
  var items = [
    'general',
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
        appBar: CupertinoNavigationBar(
          middle: Text('Patient Pictures'),
          backgroundColor: Colors.deepPurple,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_rounded)),
          brightness: Brightness.light,
        ),
        // drawer: MainDrawer(),
        body: MyBackground(
            child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Visibility(visible: file != null, child: Image.file(file)),
                // InkWell(
                //     onTap: () {
                //       Navigator.pop(context);
                //     },
                //     child: const Icon(
                //       Icons.arrow_back,
                //       color: Colors.black,
                //     )),
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
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    // CupertinoPicker(itemExtent: itemExtent, onSelectedItemChanged: onSelectedItemChanged, children: children)
                    DropdownButton(
                      dropdownColor: Colors.deepPurple,
                      focusColor: Colors.black,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      underline: Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      value: dropdownvalue,
                      icon: Icon(
                        Icons.arrow_downward_rounded,
                        color: Colors.black,
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

                MyInputField(
                  controller: memorytype,
                  hint: "Memory Type",
                ),
                //MyTextfield(hint: 'MemoryType', icon: Icons.abc_sharp, textEditingController: memorytype),
                MyInputField(
                  controller: memorydescription,
                  hint: "Memory Description",
                ),
                // MyInputField(controller: date, hint: "Date"),
                InkWell(
                  onTap: () async {
                    pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2023));
                    if (pickedDate != null) {
                      date = DateTime.parse(pickedDate.toString());
                      setState(() {});
                      text = pickedDate.toString().split(' ')[0];
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    padding: EdgeInsets.all(12),
                    width: Utilities.getSize(context).width,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4), blurRadius: 5)
                      ],
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[200],
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
                              color: Colors.deepPurple,
                            ),
                            child: Icon(Icons.date_range_rounded)),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          text,
                          style: TextStyle(
                              color: Colors.deepPurple,
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
                        border: Border.all(color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 5)
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[200]),
                    height: 60,
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
                      if (Utilities.audiopath == "" ||
                          _imageFile == null ||
                          memorydescription.text == "" ||
                          memorytype.text == "") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
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
                        await player.setAudioSource(AudioSource.uri(
                            Uri.parse(Utilities.audiopath.toString())));
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
    print(Utilities.caretakerid.toString());
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
            date.toString() +
            "&cid=" +
            Utilities.caretakerid.toString() +
            "&did=" +
            Utilities.doctorid.toString()));
    request.files.add(await http.MultipartFile.fromPath('photo', f.path));

    //request.headers.addAll({'Content-type': 'multipart/formdata'});

    request.files.add(await http.MultipartFile.fromPath('audio', f1));

    request.headers.addAll({'Content-type': 'multipart/formdata'});
    print('Sending request...');

    var res = await request.send();
    print(res.statusCode);
    if (res.statusCode == 200) {
      print('Ok Call');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text("Memory Added Successfully!")));
      EasyLoading.dismiss();
      // Navigator.pushNamed(context, '/');
    } else {
      print('Not Uploaded');
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text("Oops!Something went wrong")));
    }
  }
}
