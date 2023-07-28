import 'dart:convert';
import 'package:communityapp/screens/auth/otp_screen.dart';
import 'package:communityapp/screens/auth/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum LoginScreen {
  SHOW_MOBILE_ENTER_WIDGET,
  SHOW_OTP_FORM_WIDGET,
}

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController emailaddress = TextEditingController();
  final formKey = GlobalKey<FormState>();
  LoginScreen currentState = LoginScreen.SHOW_MOBILE_ENTER_WIDGET;


  showmobilePhoneWidget(context) {
    return Column(
      children: [
        const SizedBox(
          height: 60,
        ),
        Container(
          height: 200,
          width: 160,
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Image.asset("assets/images/login.png"),
          ),
        ),
        Text(
          "Mobile or E-mail",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "We need to send otp for Authentication",
          style: TextStyle(color: Colors.black45),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          height:MediaQuery.of(context).size.height*0.6,
          width: MediaQuery.of(context).size.width,
          child: Card(
            color: Color(0xffDED9D9),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60))),
            child: Column(
              children: [
                 Padding(
                  padding: EdgeInsets.only(top: 80, right: 235),
                  child: Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 50,
                        //width: Get.width * 0.7,
                        width:MediaQuery.of(context).size.width*0.7,
                        child: RichText(
                          text: const TextSpan(
                            text: 'Welcome back to',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            /*defining default style is optional */
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' वाडवळ  पाचकळशी ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffFF8900),
                                      fontSize: 15)),
                              TextSpan(
                                  text: '   Community',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Card(
                          color: Color(0xffFFFFFF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: TextFormField(
                            controller: mobileNumber,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Registered Mobile or Email',
                                prefixIcon: Icon(Icons.phone_android_outlined),
                                contentPadding: EdgeInsets.all(14)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [
                              Colors.blue.shade400,
                              Colors.blue.shade200,
                            ],
                          )
                      ),
                    child: MaterialButton(
                      highlightColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () async{
                        if(mobileNumber.text.isNotEmpty)
                        {
                              Map data = {
                                'input': mobileNumber.text,
                              };
                              Uri url = Uri.parse("https://community.creditmywallet.in.net/api/sendotpLogin");
                              var body1 = json.encode(data);
                              setState(() {
                                print("******************8"+body1.toString());
                              });
                              var response = await http.post(
                                  url, headers: {"Content-Type": "application/json"},
                                  body: body1);
                              var res=json.decode(response.body);
                              var msg=res['status_message'];
                              print(res.toString()+"%%%%%%%%%%%%%");
                              if(res['status_message']=="OTP Sent To Your Mobile No")
                              {
                                Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder: (context)=>OTP(number: mobileNumber.text.toString(),)));
                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString('mobile',mobileNumber.text);
                              }
                              else if(res['status_message']=="Profile Under Verification")
                                {
                                  verification_pendind();
                                }
                              else if(res['status_message']=="Verofication Rejected")
                              {
                                verification_rejected();
                              }
                              else
                              {
                                Fluttertoast.showToast(msg: "Invalid Mobile Number Or Email",toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);
                              }
                        }
                        else
                        {
                          Fluttertoast.showToast(msg: "Blank Field Not Allow",toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM);
                        }
                      },
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account yet ?"),
                    TextButton(
                        onPressed: () {
                          //Get.to(Registration());
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context)=>Registration()));

                        },
                        child: const Text("Register Now"))
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
  showOtpwidget(context) {
    return Column(
      children:  [
      ],
    );
  }



  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: currentState == LoginScreen.SHOW_MOBILE_ENTER_WIDGET
            ? showmobilePhoneWidget(context)
            : showOtpwidget(context),
      ),
    );
  }
  void verification_pendind() {
    AlertDialog dialog=new AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: Icon(Icons.av_timer,size: 50,color: Colors.orange.shade300,),
            )
          ),
          SizedBox(
            height: 7,
          ),
          Text("Your account is pending for verification  with your current shakha. Please visit again",
            style: TextStyle(
                fontSize: 12,
              color: Colors.grey.shade800
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
    showDialog(context: context, builder: (BuildContext context)
    {
      return dialog;
    });

  }
  void verification_rejected() {
    AlertDialog dialog=new AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Container(
                child: Icon(Icons.disabled_visible,size: 50,color: Colors.redAccent,),
              )
          ),
          SizedBox(
            height: 7,
          ),
          Text("Your verification is Rejected Contact on shakha",
            style: TextStyle(
              fontSize: 16
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
    showDialog(context: context, builder: (BuildContext context)
    {
      return dialog;
    });

  }
}
