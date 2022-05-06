// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/listofcaretaker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
        appBar: AppBar(
          title: Text("Doctor Login"),
        ),
        body: MyBackground(
            child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/login.png'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MyInputField(controller: email, hint: "E M A I L"),
                MyPasswordInputField(
                    controller: password, hint: "P A S S W O R D"),
                const SizedBox(
                  height: 10,
                ),
                MyButton(
                    text: "Login",
                    onTap: () {
                      login(context);
                    }),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/doctor_signup');
                        },
                        child: Text(
                          "Don't Have an Account? SignUp",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )))
              ],
            ),
          ),
        )));
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
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("login successfull")));
        EasyLoading.dismiss();
        // Navigator.pushNamed(context, '/listofcaretaker');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListOfCaretaker()),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("invalid email/password")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Blank email/password not Allowed!")));
    }
  }
}
