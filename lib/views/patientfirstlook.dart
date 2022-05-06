import 'package:flutter/material.dart';
import 'package:flutter_application_mj/views/widgets.dart';

class PatientFirstLook extends StatefulWidget {
  const PatientFirstLook({Key? key}) : super(key: key);

  @override
  State<PatientFirstLook> createState() => _PatientFirstLookState();
}

class _PatientFirstLookState extends State<PatientFirstLook> {
  String text = 'patient';
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
              const SizedBox(
                height: 25,
              ),
              Text(
                'Hi Mr. $text',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              const SizedBox(height: 25),
              MyButton(
                  text: 'About',
                  onTap: () {
                    Navigator.pushNamed(context, '/viewtopatient');
                  }),
              MyButton(
                  text: 'Education',
                  onTap: () {
                    Navigator.pushNamed(context, '/viewtopatient');
                  }),
              MyButton(
                  text: 'People',
                  onTap: () {
                    Navigator.pushNamed(context, '/viewtopatient');
                  }),
              MyButton(
                  text: 'Interest',
                  onTap: () {
                    Navigator.pushNamed(context, '/viewtopatient');
                  }),
              MyButton(
                  text: 'Profession',
                  onTap: () {
                    Navigator.pushNamed(context, '/viewtopatient');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
