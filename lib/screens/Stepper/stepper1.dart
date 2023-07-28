import 'package:communityapp/screens/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/Stepper/basic_details.dart';
import 'package:communityapp/screens/Stepper/family_details.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class IconStepperDemo21 extends StatefulWidget {
  @override
  _IconStepperDemo createState() => _IconStepperDemo();
}

class _IconStepperDemo extends State<IconStepperDemo21> {

  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  void onStepTapped() {
    if (_currentStep != 6) {
      setState(() => _currentStep++);
    }
    else if(_currentStep==6)
      {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context)=>Dashboard()));
      }
  }

  void onStepCancel() {
    if (_currentStep != 0) {
      setState(() => _currentStep--);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            child:
                Expanded(
                    child: Stepper(
                      type: StepperType.horizontal,
                      physics : ClampingScrollPhysics(),
                      controlsBuilder: (context, details) {
                        return Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                child: Center(
                                    child: MaterialButton(
                                      onPressed: onStepCancel,
                                      child: Text("Prev",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white
                                        ),
                                      ),
                                    )
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
                              Spacer(),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Center(
                                    child: MaterialButton(
                                      onPressed: onStepTapped,
                                      child: Text("Next",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white
                                        ),
                                      ),
                                    )
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
                            ],
                          ),
                        );
                      },
                      currentStep: _currentStep,
                      steps: <Step>[
                        Step(
                          label: Text(
                            'Basic Details',
                          ),
                          title: Text(''),
                          content: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.red,
                              )
                            ],
                          ),
                          isActive: _currentStep >= 0,
                        ),
                        Step(
                          label: Text(
                            'Family Details',
                          ),
                          title: Text(''),
                          content: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.blue,
                              )
                            ],
                          ),
                          isActive: _currentStep >= 1,
                        ),
                        Step(
                          label: Text(
                            'Education Details',
                          ),
                          title: Text(''),
                          content: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.yellow,
                              )
                            ],
                          ),
                          isActive: _currentStep >= 2,
                        ),
                        Step(
                          label: Text(
                            'Professional Details',
                          ),
                          title: Text(''),
                          content: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.blue,
                              )
                            ],
                          ),
                          isActive: _currentStep >= 3,
                        ),
                        Step(
                          label: Text(
                            'Land Details',
                          ),
                          title: Text(''),
                          content: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.pink,
                              )
                            ],
                          ),
                          isActive: _currentStep >= 4,
                        ),
                        Step(
                          label: Text(
                            'Income Details',
                          ),
                          title: Text(''),
                          content: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.blue,
                              )
                            ],
                          ),
                          isActive: _currentStep >= 5,
                        ),
                        Step(
                          label: Text(
                            'Acheivements',
                          ),
                          title: Text(''),
                          content: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.yellow,
                              )
                            ],
                          ),
                          isActive: _currentStep >= 6,
                        ),
                      ],
                    )
                ),
             /*   FAStepper(
                  steps: [
                    FAStep(
                        title: Text("Demo"),
                        content: Container(
                          height: 200,
                          width: 200,
                          color: Colors.lightGreen,
                        )
                    ),
                    FAStep(
                        title: Text("Demo1"),
                        content: Container(
                          height: 200,
                          width: 200,
                          color: Colors.yellow,
                        )
                    ),
                    FAStep(
                        title: Text("Demo2"),
                        content: Container(
                          height: 200,
                          width: 200,
                          color: Colors.black,
                        )
                    ),
                    FAStep(
                        title: Text("Demo3"),
                        content: Container(
                          height: 200,
                          width: 200,
                          color: Colors.red,
                        )
                    ),
                    FAStep(
                        title: Text("Demo4"),
                        content: Container(
                          height: 200,
                          width: 200,
                          color: Colors.green,
                        )
                    ),
                    FAStep(
                        title: Text("Demo5"),
                        content: Container(
                          height: 200,
                          width: 200,
                          color: Colors.purple,
                        )
                    ),


                  ],
                ),*/
          )
      ),
    );
  }
}
