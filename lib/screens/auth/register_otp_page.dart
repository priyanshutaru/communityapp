import 'dart:async';
import 'dart:convert';
import 'package:communityapp/screens/auth/login_page.dart';
import 'package:communityapp/screens/success_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
class register_otp extends StatefulWidget {
  /*const register_otp({Key? key}) : super(key: key);*/
  String? user_id,first_name,middle_name,last_name,mobile,email,country,currnet_shakha,dob,
  native_shakha,aali,otp;


  register_otp({
    required this.user_id,
    required this.first_name,
    required this.middle_name,
    required this.last_name,
    required this.mobile,
    required this.email,
    required this.country,
    required this.currnet_shakha,
    required this.dob,
    required this.native_shakha,
    required this.aali,
    required this.otp});

  @override
  State<register_otp> createState() => _register_otpState();
}

class _register_otpState extends State<register_otp> {

  final formKey = GlobalKey<FormState>();
  TextEditingController _otp=TextEditingController();

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


  Future reSendOTP () async{
    Map data={
      'input': widget.mobile.toString()
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
    startTimer();
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
              height: MediaQuery.of(context).size.height/1.5,
              width: MediaQuery.of(context).size.width,
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
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Form(
                        key: formKey,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: PinCodeTextField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Valid OTP";
                                }
                              },

                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6)
                              ],
                              controller: _otp,
                              obscuringCharacter: '*',
                              appContext: context,
                              length: 4,
                              obscureText: false,

                              blinkWhenObscuring: true,
                              pinTheme: PinTheme(
                                  borderWidth: 0.1,
                                  shape: PinCodeFieldShape.box,
                                  fieldHeight: 50,
                                  fieldWidth: 50,
                                  activeFillColor: Colors.white,
                                  disabledColor: Colors.white,
                                  inactiveColor: Colors.white,
                                  inactiveFillColor: Colors.white,
                                  selectedFillColor: Colors.white,
                                  errorBorderColor: Colors.red,
                                  activeColor: Colors.white,
                                  selectedColor: Colors.white),
                              cursorColor: Colors.black54,
                              animationDuration:
                              Duration(milliseconds: 300),
                              enableActiveFill: true,
                              keyboardType: TextInputType.number,
                              boxShadows: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Colors.blueAccent,
                                  blurRadius: 1,
                                )
                              ],
                              onCompleted: (v) {
                                debugPrint("Completed");
                              },
                              onChanged: (value) {
                                debugPrint(value);
                                setState(() {
                                });
                              },
                              beforeTextPaste: (text) {
                                debugPrint("Allowing to paste $text");
                                return true;
                              },
                            )),
                      ),
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
                                if(_otp.text.isNotEmpty)
                                  {
                                    if(_otp.text.toString()=="${widget.otp}") {
                                      Map data1 = {
                                        'first_name':"${widget.first_name}",
                                        'user_id':"${widget.user_id}",
                                        'otp': _otp.text.toString(),
                                        'middle_name': "${widget.middle_name}",
                                        'last_name': "${widget.last_name}",
                                        'current_shakha': "${widget.currnet_shakha}",
                                        'native_shakha': "${widget.native_shakha}",
                                        'email': "${widget.email}",
                                        'mobile': "${widget.mobile}",
                                        'dob': "${widget.dob}",
                                        'country_code': "${widget.country}",
                                        'aali': "${widget.aali}",
                                      };
                                      print(data1.toString());
                                      var url = Uri.parse("https://community.creditmywallet.in.net/api/register");
                                      var body1 = json.encode(data1);
                                      var response = await http.post(
                                          url, headers: {"Content-Type": "application/json"},
                                          body: body1);
                                      var res=json.decode(response.body);
                                        Fluttertoast.showToast(msg: res['status_message'].toString(),toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM);
                                        print(res['status_message'].toString()+"bsdk");
                                      print(res.toString()+"%%%%%%%%%%%%%");
                                      var msg=res["status_message"];
                                      print(res.toString()+"%%%%%%%%%%%%%");
                                      if (res['status_message'] == "User Registered Successfully") {
                                        Navigator.pushReplacement(
                                            context, MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterSuccess()));
                                                // RegisterSuccess()));
                                        Fluttertoast.showToast(
                                            msg: 'Account Created!!',
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM);
                                        _otp.clear();
                                      }
                                      else
                                      {
                                        Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM);
                                      }
                                    }
                                    else
                                      {
                                        Fluttertoast.showToast(msg: "OTP Invalid",toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM);
                                      }
                                  }
                                else
                                  {
                                    Fluttertoast.showToast(msg: "OTP is Not Empty",toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM);
                                  }

                              },
                              child: Text(
                                "Verify OTP",
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height/7.7,
                        )
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
