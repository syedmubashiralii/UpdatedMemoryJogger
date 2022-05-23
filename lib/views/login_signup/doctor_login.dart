// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/listofcaretaker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../controllers/utilites.dart';
import '../widgets.dart';

// ignore: must_be_immutable
class DoctorLogin extends StatelessWidget {
  DoctorLogin({Key? key}) : super(key: key);
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 100,
                  ),
                  SizedBox(height: 50),
                  //hello
                  Text(
                    "Hello Doctor!",
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
                        login(context);
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
                          Navigator.pushNamed(context, '/doctor_signup');
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
            "/memoryjogger/api/doctor/doctorlogin?email=" +
            email.text +
            "&password=" +
            password.text),
      );
      if (response.statusCode == 200) {
        Utilities.doctorid = int.parse(response.body.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            content: Text("login successfull")));
        EasyLoading.dismiss();
        // Navigator.pushNamed(context, '/listofcaretaker');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListOfCaretaker()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            content: Text("invalid email/password")));
        EasyLoading.dismiss();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text("Blank email/password not Allowed!")));
    }
  }
}
