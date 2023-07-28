import 'dart:async';
import 'dart:convert';
import 'package:communityapp/screens/dashboard.dart';
import 'package:communityapp/screens/pre_registration_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OTP extends StatefulWidget {
 String? number;
 OTP({required this.number});

  @override
  State<OTP> createState() => _OTPState();



}

class _OTPState extends State<OTP> {

  var otpController=TextEditingController();
  var otpController1=TextEditingController();
  var otpController2=TextEditingController();
  var otpController3=TextEditingController();

  void _setValue(value) async{
    final pref=await SharedPreferences.getInstance();
    final set1=pref.setString('user_id', value);
    print(set1);
  }

  late Timer _timer;
  int _start = 25;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  String? good;
  String? kyc_status;
  Future getuser() async{
    final pref1=await SharedPreferences.getInstance();
    var userid=pref1.getString('user_id');
    Map data={
      'user_id':userid.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_user");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    setState(() {
      print(url.toString());
    });
    var res=json.decode(response.body)[0];
    setState(() {
      kyc_status=res['kyc_status'];
      kyc_status="0";
      print(kyc_status.toString()+"verification");
    });
  }

  Future reSendOTP () async{
    Map data={
      'input': widget.number.toString()
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

      Fluttertoast.showToast(msg: 'OTP SENT',toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);

    }

  }


  @override
  void initState() {
    super.initState();
    setState(() {
      startTimer();
      getuser();

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            Container(
              height: 120,
              width: 120,
              child: Padding(
                padding: EdgeInsets.only(left: 0),
                child: Image.asset("assets/images/login.png"),
              ),
            ),
            Text(
              "Please verify the otp sent on your",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000),
                  fontSize: 14),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "Registered Mobile or Email",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000),
                  fontSize: 14),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.7,
              child: Card(
                color: Color(0xffDED9D9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 130,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(7),),
                            ),
                            child: TextFormField(
                              controller: otpController,
                              onChanged: (value)
                              {
                                if(value.length==1)
                                {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              onSaved: (pin1){},
                              decoration: InputDecoration(hintText: "0",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],

                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(7),),
                            ),
                            child: TextFormField(
                              controller: otpController1,
                              onChanged: (value)
                              {
                                if(value.length==1)
                                {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              onSaved: (pin2){},
                              decoration: InputDecoration(hintText: "0",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],

                            ),

                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(7),),
                            ),
                            child: TextFormField(
                              controller: otpController2,
                              onChanged: (value)
                              {
                                if(value.length==1)
                                {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              onSaved: (pin3){},
                              decoration: InputDecoration(hintText: "0",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],

                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(7),),
                            ),
                            child: TextFormField(
                              controller: otpController3,
                              onChanged: (value)
                              {
                                if(value.length==1)
                                {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              onSaved: (pin4){},
                              decoration: InputDecoration(hintText: "0",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],

                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width:MediaQuery.of(context).size.width*0.82,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
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
                            if(otpController.text.isNotEmpty &&
                                otpController1.text.isNotEmpty &&
                                otpController2.text.isNotEmpty &&
                                otpController3.text.isNotEmpty )
                            {
                              Map data = {
                                'input': "${widget.number}",
                                'otp' : otpController.text+
                                    otpController1.text+
                                    otpController2.text+
                                    otpController3.text
                              };
                              Uri url = Uri.parse("https://community.creditmywallet.in.net/api/otp_verify");
                              var body1 = json.encode(data);
                              var response = await http.post(
                                  url, headers: {"Content-Type": "application/json"},
                                  body: body1);
                              var res=json.decode(response.body);
                              setState(() {
                                print(res.toString());
                                _setValue(res['response_login']['user_id']);
                              });
                              var msg=res['status_message'];
                              if(res["kyc_status"]=="0")
                              {
                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                      builder: (context)=>PreRegistrationHomeScreen()));
                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);
                              }
                             else if(res["kyc_status"]=="1")
                              {
                                Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder: (context)=>Dashboard()));

                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);
                              }
                              else if(res["kyc_status"]=="2")
                              {
                                Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder: (context)=>Dashboard()));

                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);
                              }
                              else if(res["kyc_status"]=="3")
                              {
                                Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder: (context)=>Dashboard()));

                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);
                              }
                              else
                              {
                                Fluttertoast.showToast(msg: "Fill the Correct Otp",toastLength: Toast.LENGTH_LONG,
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
                              "Verify",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color(0xffFFFFFF),
                              ),
                          )
                        ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 56,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not Received OTP ? Resend In",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xff000000),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(_start.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xff000000),
                            )),
                        _start==0?
                        TextButton(
                            onPressed: () {
                              reSendOTP();
                              startTimer();
                            },
                            child: Text("Resend OTP",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Color(0xffFF9300),
                                ))):
                        Text(""),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
