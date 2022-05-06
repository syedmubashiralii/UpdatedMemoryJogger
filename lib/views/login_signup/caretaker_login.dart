// ignore_for_file: unnecessary_cast, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/after_login_caretaker.dart';
import 'package:flutter_application_mj/views/login_signup/caretaker_signup.dart';
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
        appBar: AppBar(title: Text('Caretaker Login')),
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
                          // Navigator.pushNamed(context, '/caretaker_signup');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CaretakerSignup()),
                          );
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              "Don't Have and Account? ",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              " SignUp ",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
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
            "/memoryjogger/api/caretaker/caretakerlogin?email=" +
            email.text +
            "&password=" +
            password.text),
      );
      if (response.statusCode == 200) {
        Utilities.caretakerid = int.parse(response.body.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text("login successfull  with id=" + Utilities.caretakerid.toString())));
        EasyLoading.dismiss();
        // Navigator.pushNamed(context, '/after_login_caretaker');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AfterLoginCaretaker()),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("invalid email/password")));
        EasyLoading.dismiss();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Blank email/password not Allowed!")));
    }
  }
}
