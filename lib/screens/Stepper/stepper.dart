import 'package:communityapp/screens/Stepper/activement.dart';
import 'package:communityapp/screens/Stepper/basic_details.dart';
import 'package:communityapp/screens/Stepper/education_detail.dart';
import 'package:communityapp/screens/Stepper/family_details.dart';
import 'package:communityapp/screens/Stepper/income_details.dart';
import 'package:communityapp/screens/Stepper/land_detail.dart';
import 'package:communityapp/screens/Stepper/professional_details.dart';
import 'package:communityapp/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';

import 'stepper.dart';

class IconStepperDemo extends StatefulWidget {
  @override
  _IconStepperDemo createState() => _IconStepperDemo();
}

class _IconStepperDemo extends State<IconStepperDemo> {
  int activeStep = 0;
  int upperBound = 6;

  List items = [
    BasicDetail(),
    FamilyDetails(material_status: '', gender: '', female: '',),
    EducationDetails(material_status: '', gender: '', female: '',),
    ProfessionalDetails(),
    LandDetails(),
    IncomeDetails(),
    Activement()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                IconStepper (
                  icons:  const [
                    Icon(Icons.call,color: Colors.white,),
                    Icon(Icons.supervised_user_circle,color: Colors.white,),
                    Icon(Icons.access_alarm,color: Colors.white,),
                    Icon(Icons.supervised_user_circle,color: Colors.white,),
                    Icon(Icons.flag,color: Colors.white,),
                    Icon(Icons.access_alarm,color: Colors.white,),
                    Icon(Icons.supervised_user_circle,color: Colors.white,),
                  ],
                  activeStep: activeStep,
                  stepRadius: 20,
                  scrollingDisabled: true,
                  enableNextPreviousButtons: false,
                  enableStepTapping: false,
                  lineColor: Colors.green,
                  lineLength: 60,
                  activeStepBorderPadding: 0,
                  onStepReached: (index) {
                    setState(() {
                      activeStep = index;
                      if (activeStep == upperBound) {}
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 1,
                      child: Center(
                        child: items[activeStep],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    /*  persistentFooterButtons: [
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             *//* previousButton(),
              nextButton(),*//*
            ],
          ),
        )
      ],*/
    );
  }

  Widget nextButton() {
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: () {
         if (activeStep < upperBound) {
            setState(() {
              activeStep++;
            });
            if (activeStep == upperBound) {
              setState(() {
                Fluttertoast.showToast(
                    msg: "Registration is Completed", textColor: Colors.green);

                Navigator.pushReplacement(
                    context,
                     MaterialPageRoute(
                        builder: (BuildContext context) => Dashboard()));
              });
            }
          }
        },
        child: Container(
          alignment: Alignment.centerRight,
          child: Center(
            child: Text(
              "Next",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
          height: 45,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade100, Colors.blue.shade300])),
        ),
      ),
    );
  }

  Widget previousButton() {
    return InkWell(
      onTap: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
        if (activeStep == 0) {
          setState(() {
            Fluttertoast.showToast(
              msg: "This is first page",
              textColor: Colors.red,
              backgroundColor: Colors.purple[100],
            );
          });
        }
      },
      child: Container(
        alignment: Alignment.centerRight,
        child: Center(
          child: Text(
            "Prev",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
        ),
        height: 45,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.pink.shade100, Colors.pink.shade300])),
      ),
    );
  }
}
