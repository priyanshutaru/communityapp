import 'dart:convert';
import 'package:communityapp/screens/Business/business_registration.dart';
import 'package:communityapp/screens/Stepper/activement.dart';
import 'package:communityapp/screens/Stepper/income_details.dart';
import 'package:communityapp/screens/Stepper/professional_details.dart';
import 'package:communityapp/screens/pre_registration_homescreen.dart';
import 'package:communityapp/screens/testing.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/auth/login_page.dart';
import 'package:communityapp/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:communityapp/Utils/helperFunctions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  String login_status="";
  String? kyc_status;
  String? verification_staus;
  // bool? userIsLoggedIn;

  // getLoggedInSate()async {
  //   await HelperFunctions.getuserLoggedInSharedPreference().then((value) {
  //     setState(() {
  //       userIsLoggedIn = value;
  //       print("value:${value}");
  //     });
  //   });
  // }

  // var subscribe_status1;
  // Future Matrimoney_Statuss () async{
  //   final pref=await SharedPreferences.getInstance();
  //   var get=pref.getString('user_id');
  //   Map data={'user_id':get.toString()};
  //   Uri url = Uri.parse("https://community.creditmywallet.in.net/api/my_matrimony");
  //   var body=jsonEncode(data);
  //   var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
  //   var res=json.decode(response.body)['matrimony_status'];
  //
  //   if(response.statusCode==200){
  //     setState(() {
  //       subscribe_status1 = res;
  //       print("mmmmamsmxmxmxmxmxmxmxm" + " = " + subscribe_status1.toString());
  //
  //     });
  //   }
  // }
  Future getuser() async{
    final pref1=await SharedPreferences.getInstance();
    var userid=pref1.getString('user_id');

    setState(() {
      print(userid.toString());
    });
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
      print(kyc_status.toString()+"verification");
    });
  }




  void initState() {
    super.initState();
      super.initState();
    // Matrimoney_Statuss ();
    // getLoggedInSate();
      getuser();
      Future.delayed(Duration(seconds: 5), ()async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? email = prefs.getString('mobile');
        print(email.toString());
         if( email !=null) {
          setState(() {
            kyc_status=="0"?
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=>PreRegistrationHomeScreen())):
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=>Dashboard()));
          });
        }
        else {
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context)=>Loginpage()));
        }
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F5F5),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Container(
                    height: 100,
                    width: 92.76,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/splash.png"),
                            fit: BoxFit.contain)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 20.41,
                width: 219,
                child: Text(
                  "COMMUNITY CONNECT",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 18.55,
                width: 22,
                child: Text(
                  "By",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 19.55,
                width: 182,
                child: Text("\"सोमवंशी क्षत्रिय समाजोन्नति संघ\"")
              ),
              SizedBox(
                height: 7.42,
              ),
              Container(
                height: 14.91,
                width: 87,
                child: Text("\"संघ हीच शक्ती\"")
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: 19,
                width: 295,
                child: RichText(
                  text: TextSpan(
                    text: 'POWERED BY ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' OTET Infosystems',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
