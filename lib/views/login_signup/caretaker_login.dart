// ignore_for_file: unnecessary_cast, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/after_login_caretaker.dart';
import 'package:flutter_application_mj/views/login_signup/caretaker_signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../controllers/utilites.dart';
import '../widgets.dart';

// ignore: must_be_immutable
class CaretakerLogin extends StatelessWidget {
  CaretakerLogin({Key? key}) : super(key: key);

  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: MyBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.man,
                    size: 100,
                  ),
                  SizedBox(height: 50),
                  //hello
                  Text(
                    "Hello Caretaker!",
                    style: GoogleFonts.bebasNeue(fontSize: 52),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    "Wellcome back you've been missed",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 50),

                  //emailtextfield
                  MyInputField(controller: email, hint: "Email"),
                  SizedBox(
                    height: 10,
                  ),

                  //passwordtextfield
                  MyPasswordInputField(controller: password, hint: 'Password'),
                  SizedBox(
                    height: 10,
                  ),

                  //login button
                  MyButton(
                      text: 'Login',
                      onTap: () {
                        _showAlertDialog(context);
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  //not a member ?registernow
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member? ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/caretaker_signup');
                        },
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //create function to call login api
  Future<void> login(context) async {
    if (password.text.isNotEmpty && email.text.isNotEmpty) {
      EasyLoading.show();
      var response = await http.get(
        Uri.parse(Utilities.baseurl +
            "/memoryjogger/api/caretaker/caretakerlogin?email=" +
            email.text +
            "&password=" +
            password.text),
      );

      if (response.statusCode == 200) {
        var dat = response.body.toString().split('"')[1];
        var cid = dat.toString().split(" ")[0];
        var did = dat.toString().split(" ")[1];
        Utilities.caretakerid = int.parse(cid);
        Utilities.doctorid = int.parse(did);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            content: Text("login successfull  with id=" + Utilities.caretakerid.toString())));
        EasyLoading.dismiss();
        // Navigator.pushNamed(context, '/after_login_caretaker');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AfterLoginCaretaker()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            content: Text("invalid email/password")));
        EasyLoading.dismiss();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Blank email/password not Allowed!")));
    }
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Proceed with Login action?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              login(context);
            },
            child: const Text('Yes'),
          )
        ],
      ),
    );
  }
}
