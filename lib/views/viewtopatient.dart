// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/widgets.dart';

class ViewToPatient extends StatefulWidget {
  const ViewToPatient({Key? key}) : super(key: key);

  @override
  State<ViewToPatient> createState() => _ViewToPatientState();
}

class _ViewToPatientState extends State<ViewToPatient> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Count $count',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100)),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(30),
                child: const Text(
                    'The Current Prime minister Of Pakistan Imran Khan'),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(100)),
              ),
              Container(
                padding: const EdgeInsets.all(90),
                // height: Utilities.getSize(context).height,
                // width: Utilities.getSize(context).width,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/imrankhan.jpg"),
                  ),
                ),
              ),
              // MyButton(
              //     text: 'Next',
              //     onTap: () {
              //       count++;
              //       print(count);
              //     })
              SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton(
                  onPressed: () {
                    count++;
                  },
                  child: const Text('Next'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
