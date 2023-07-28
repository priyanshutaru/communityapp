import 'dart:convert';
import 'package:communityapp/screens/auth/login_page.dart';
import 'package:communityapp/screens/auth/register_otp_page.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/pre_registration_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);
  @override
  State<Registration> createState() => _RegistrationState();
}
class _RegistrationState extends State<Registration> {
  // Initial Selected Value
  String? drop1;
  String? aali_drop;
  String? dob;
  late DateTime _myDateTime;
  String phoneNumber = "+91";
  String country_code="countCode";
  void _onCountryChange(CountryCode countryCode) {
    this.phoneNumber =  countryCode.toString();
    print("New Country selected: " + countryCode.toString());
  }


  List currentShakha=[];
  String? drop;
  Future getCurrentShakha() async{
    var url="https://community.creditmywallet.in.net/api/get_current_shakha";
    http.Response response=await http.get(Uri.parse(url));
        var res=jsonDecode(response.body)['response_data'];
        setState(() {
          print("%%%%%%%%%%%%"+res.toString());
          currentShakha=res;
          print(currentShakha.toString()+"%%%%%%%%%%%%%%%%");
        });
  }
  void set_userid(value) async{
    final pref=await SharedPreferences.getInstance();
    final set1=pref.setString('user_id', value!);
    print(set1);
  }

  String? lastname1;
  List lastname=[];
  Future getlastname() async{
    var url="https://community.creditmywallet.in.net/api/surname";
    http.Response response=await http.get(Uri.parse(url));
    var res=jsonDecode(response.body)['data'];
    setState(() {
      print("%%%%%%%%%%%%"+res.toString());
      lastname=res;
      print(lastname.toString()+"%%%%%%%%%%%%%%%%");
    });

  }

  List aali=[];
  Future get_aali() async{
    Map data={
      'shakha_id': drop.toString(),
    };
    var url="https://community.creditmywallet.in.net/api/get_aali";
    var body1=jsonEncode(data);
    http.Response response=await http.post(Uri.parse(url),
        headers: {"Content-Type":"application/json"}, body: body1);
    var res=jsonDecode(response.body)['state'];
    setState(() {
      aali=res;
      print(aali.toString()+"%%%%%%%%%%%%%%%%");
    });
  }

  Future preRegister() async{
    final pref = await SharedPreferences.getInstance();
    var id = pref.getString('user_id');
    final uri = Uri.parse('https://community.creditmywallet.in.net/api/pre_register');
    Map data = {
      'user_id':id.toString(),
      'first_name': firstName.text,
      'middle_name':middlename.text,
      'last_name':lastname1,
      'current_shakha': drop,
      'native_shakha': drop1,
      'email': emailaddress.text,
      'mobile':mobilenumber.text,
      'dob':dob.toString(),
      'country_code':phoneNumber.toString(),
      'aali':aali_drop,
    };
    var data1 = jsonEncode(data);
    final response = await http.post(uri,body: data1);
    var res = jsonDecode(response.body);
    if(response.statusCode==200){
      setState(() {
        Fluttertoast.showToast(msg: "Registration Successfully");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>register_otp(user_id: 'user_id', first_name: 'first_name', middle_name: 'middle_name', last_name: 'last_name', mobile: 'mobile', email: 'email', country: 'country', currnet_shakha: 'currnet_shakha', dob: dob, native_shakha: 'native_shakha', aali: 'aali', otp: 'otp')));
      });
    }
  }
  
  TextEditingController firstName=TextEditingController();
  TextEditingController middlename=TextEditingController();
  TextEditingController mobilenumber=TextEditingController();
  TextEditingController emailaddress=TextEditingController();
  TextEditingController password=TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      getCurrentShakha();
      getlastname();
      // preRegister();
      print(currentShakha.toString()+"%%%%%%%%%%%%%%%%");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Container(
                height: 120,
                width: 120,
                child: Image.asset("assets/images/login.png"),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Registration",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      // height: 30,
                      // width: 295,
                      child: RichText(
                        text: TextSpan(
                          text: 'Welcome back to',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w700),
                          /*defining default style is optional */
                          children: <TextSpan>[
                            TextSpan(
                                text: ' वाडवळ  पाचकळशी ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xffFF8900),
                                    fontSize: 14)),
                            TextSpan(
                              text: '  Community',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                //width: Get.width,
                width:MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  color: Color(0xffDED9D9),
                  child: Column(children: [
                    SizedBox(
                      height: 49,
                    ),
                    Form(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Container(
                                    width:MediaQuery.of(context).size.width*0.31,
                                    alignment: Alignment.centerLeft,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black,
                                              width: 2.0,
                                            )
                                        )
                                    ),
                                    child: Text(
                                      "Let's Get Started",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff000000)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  height: 50,
                                  width:MediaQuery.of(context).size.width*0.9,
                                  child: TextFormField(
                                    controller: firstName,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(14.0),
                                      border: InputBorder.none,
                                      hintText: "First Name",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff878383),
                                          fontSize: 14),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ), // pass the hint text parameter here
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  height: 50,
                                  //width: Get.width * .9,
                                  width:MediaQuery.of(context).size.width*0.9,
                                  child: TextFormField(
                                    controller: middlename,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(14.0),
                                      border: InputBorder.none,
                                      hintText: "Middle Name",
                                      hintStyle:    TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff878383),
                                          fontSize: 14),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 3, bottom: 3),
                                  child: Container(
                                    height: 50,
                                    width:MediaQuery.of(context).size.width*0.9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField(
                                        value: lastname1,
                                        //hint: Text("        Last Name"),
                                        decoration: InputDecoration(
                                          prefixIcon:Icon(
                                            Icons.person,
                                            color: Colors.black,
                                          ),
                                          hintText: "Last Name",
                                          border: InputBorder.none
                                        ),
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                        items: lastname.map((item) {
                                          return DropdownMenuItem(
                                            value: item['surname_eng'].toString(),
                                            child: Padding(
                                              padding:  EdgeInsets.only(left: 0),
                                              child: Text(
                                                item['surname_eng'].toString(),
                                                style: TextStyle(color: Colors.black54),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            lastname1 = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  height: 50,
                                  width:MediaQuery.of(context).size.width*0.9,
                                  child: TextFormField(
                                    controller: mobilenumber,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    validator: (val) {
                                      if (val! == null &&
                                          val.isEmpty &&
                                          val.length == 10) {
                                        Fluttertoast.showToast(
                                            msg: "Please enter 10 digit mobile Number");
                                      }
                                      return null;
                                    },

                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(14.0),
                                      border: InputBorder.none,
                                      hintText: "Mobile Number",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff878383),
                                          fontSize: 14),
                                      prefixIcon: CountryCodePicker(
                                        onChanged: _onCountryChange,
                                        initialSelection: 'IN',
                                        favorite: ['+91', 'INDIA'],
                                        showCountryOnly: false,
                                        showOnlyCountryWhenClosed: false,
                                        alignLeft: false,
                                        padding: EdgeInsets.all(10),
                                      ), // pass the hint text parameter here
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  height: 50,
                                  width:MediaQuery.of(context).size.width*0.9,
                                  child: TextFormField(
                                    controller: emailaddress,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(14.0),
                                      border: InputBorder.none,
                                      hintText: "Email Address",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff878383),
                                          fontSize: 14),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ), // pass the hint text parameter here
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                InkWell(
                                  onTap: () async{
                                    _myDateTime= (await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2050),
                                    ))!;
                                    setState(() {
                                      dob=DateFormat('yyyy-MM-dd').format(_myDateTime);
                                    });
                                  },
                                  child: Padding(
                                    padding:  EdgeInsets.only(top: 3, bottom: 3),
                                    child: Container(
                                        height: 50,
                                        width: MediaQuery.of(context).size.width * .9,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 18,
                                            ),
                                            Container(
                                                child: Image.asset(
                                                  "assets/images/year.png",
                                                  height: 22,
                                                )
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            dob!=null?
                                            Text(dob.toString()):
                                            Text("Select DOB"),
                                          ],
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3, bottom: 3),
                              child: Container(
                                height: 50,
                                width:MediaQuery.of(context).size.width*0.9,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: drop,
                                    hint: Text("        Native Sakha"),
                                    icon: Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    items: currentShakha.map((item) {
                                      return DropdownMenuItem(
                                        value: item['shakha_id'].toString(),
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 30),
                                          child: Text(
                                            item['shakha_name'].toString(),
                                            style: TextStyle(color: Colors.black54),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        drop = newValue! as String?;
                                        get_aali();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3, bottom: 3),
                              child: Container(
                                height: 50,
                                width:MediaQuery.of(context).size.width*0.9,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: aali_drop,
                                    hint: Text("        Aali(Aali *)"),
                                    icon: Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    items: aali.map((item) {
                                      return DropdownMenuItem(
                                        value: item['aali_id'].toString(),
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 30),
                                          child: Text(
                                            item['aali_name'].toString(),
                                            style: TextStyle(color: Colors.black54),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        aali_drop = newValue! as String?;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3, bottom: 3),
                              child: Container(
                                height: 50,
                                //width: Get.width * .9,
                                width:MediaQuery.of(context).size.width*0.9,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: drop1,
                                    hint: Text("        Current Sakha"),
                                    icon: Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    items: currentShakha.map((item) {
                                      return DropdownMenuItem(
                                        value: item['shakha_id'].toString(),
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 30),
                                          child: Text(
                                            item['shakha_name'].toString(),
                                            style: TextStyle(color: Colors.black54),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        drop1 = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Note:- ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xff7B7B7B))),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          width:MediaQuery.of(context).size.width*0.8,
                          child: Text(
                              "The profile go for approval to current Sakha Current & Native Sakha can be the same as well",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xff7B7B7B))),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          width:MediaQuery.of(context).size.width*0.8,
                          child: Text(
                              "If you are located Outside of India.Otp will be sent on your Email-Id",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xff7B7B7B))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        Text("I'm agree with the",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff7B7B7B)),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Term & Conditions.",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff4D8AEB)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    isChecked==true?
                    Container(
                      height: 45,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [
                              Colors.blue.shade600,
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
                          if(phoneNumber=='+91') {
                            if(firstName.text.isEmpty)
                              {
                                Fluttertoast.showToast(msg: "First Name is Empty",toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);
                              }
                            else if(middlename.text.isEmpty)
                              {
                                Fluttertoast.showToast(msg: "Middle Name is Empty",toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);
                              }
                            else if(lastname1==null)
                            {
                              Fluttertoast.showToast(msg: "Last Name is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else if(mobilenumber.text.isEmpty)
                            {
                              Fluttertoast.showToast(msg: "Mobile Number is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else if(dob==null)
                            {
                              Fluttertoast.showToast(msg: "Data of Birth is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else if(drop1==null)
                            {
                              Fluttertoast.showToast(msg: "Native Shakha is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else if(aali==null)
                            {
                              Fluttertoast.showToast(msg: "Aali  is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else if(drop1==null)
                            {
                              Fluttertoast.showToast(msg: "Current Shakha is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else
                              {
                                Map data = {
                                  'first_name': firstName.text,
                                  'middle_name':middlename.text,
                                  'last_name':lastname1,
                                  'current_shakha': drop,
                                  'native_shakha': drop1,
                                  'email': emailaddress.text,
                                  'mobile':mobilenumber.text,
                                  'dob':dob.toString(),
                                  'country_code':phoneNumber.toString(),
                                  'aali':aali_drop,
                                };
                                var url = Uri.parse("https://community.creditmywallet.in.net/api/pre_register");
                                var body1 = json.encode(data);
                                var response = await http.post(
                                    url, headers: {"Content-Type": "application/json"},
                                    body: body1);
                                var res=json.decode(response.body);
                                  Fluttertoast.showToast(msg: res['status_message'].toString(),toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM);
                                // set_userid(res['reaponse']['user_id']);
                                // var user_s=res['reaponse']['user_id'];
                                // var otp=res['reaponse']['otp'];
                                // print(otp.toString()+"%%%%%%%%%%%%%");
                                // var msg=res["status_message"];
                                // Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                //     gravity: ToastGravity.BOTTOM);
                                // print(res.toString()+"%%%%%%%%%%%%%");
                                // if(res['status_message']=="Otp Sent Successfully")
                                var msg=res["status_message"];
                                var user_s=res['reaponse_data']['user_id'];
                                var otp=res['reaponse_data']['otp'];
                                set_userid(res['reaponse_data']['reuser_id']);
                                print(res['reaponse_data']['user_id'].toString()+"hddfvuhdfvdf");
                                print(res.toString()+"%%%%%%%%%%%%%");
                                if(res['status_message']=="Otp Sent Successfully")
                                {
                                  setState(() {
                                    Navigator.pushReplacement(context, MaterialPageRoute(
                                        builder: (context)=>register_otp(
                                          user_id: user_s.toString(),
                                          first_name: firstName.text,
                                          middle_name: middlename.text,
                                          last_name: lastname1,
                                          mobile: mobilenumber.text,
                                          email: emailaddress.text,
                                          country: phoneNumber,
                                          currnet_shakha: drop,
                                          dob: dob,
                                          native_shakha: drop1,
                                          aali: aali_drop,
                                          otp: otp.toString(),
                                        )
                                    ));
                                  });
                                }
                                else
                                {
                                  Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM);
                                }
                              }
                          }
                          else{
                            if(firstName.text.isEmpty)
                            {
                              Fluttertoast.showToast(msg: "First Name is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else if(middlename.text.isEmpty)
                            {
                              Fluttertoast.showToast(msg: "Middle Name is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else if(lastname1==null)
                            {
                              Fluttertoast.showToast(msg: "Last Name is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else if(emailaddress.text.isEmpty)
                            {
                              Fluttertoast.showToast(msg: "Email Address is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else if(dob==null)
                            {
                              Fluttertoast.showToast(msg: "Data of Birth is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else if(drop==null)
                            {
                              Fluttertoast.showToast(msg: "Native Shakha is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else if(aali==null)
                            {
                              Fluttertoast.showToast(msg: "Aali  is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else if(drop1==null)
                            {
                              Fluttertoast.showToast(msg: "Current Shakha is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else
                              {
                                Map data = {
                                  'first_name': firstName.text,
                                  'current_shakha': drop,
                                  'middle_name':middlename.text,
                                  'last_name':lastname1,
                                  'native_shakha': drop1,
                                  'email': emailaddress.text,
                                  'mobile':mobilenumber.text,
                                  'dob':dob,
                                  'country_code':phoneNumber.toString(),
                                  'aali':aali_drop,
                                };
                                print(data.toString());
                                var url = Uri.parse("https://community.creditmywallet.in.net/api/pre_register");
                                var body1 = json.encode(data);
                                var response = await http.post(
                                    url, headers: {"Content-Type": "application/json"},
                                    body: body1);
                                var res=json.decode(response.body);
                                  Fluttertoast.showToast(msg: res["status_message"].toString(),
                                      toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                                  print(res.toString());
                                var msg=res["status_message"];
                                var user_s=res['reaponse_data']['user_id'];
                                var otp=res['reaponse_data']['otp'];
                                  set_userid(res['reaponse_data']['reuser_id']);
                                  print(res['reaponse_data']['user_id'].toString()+"hddfvuhdfvdf");
                                print(res.toString()+"%%%%%%%%%%%%%");
                                if(res['status_message']=="Otp Sent Successfully")
                                {
                                  setState(() {

                                    Navigator.pushReplacement(context, MaterialPageRoute(
                                        builder: (context)=>register_otp(
                                          user_id: user_s.toString(),
                                          first_name: firstName.text.toString(),
                                          middle_name: middlename.text.toString(),
                                          last_name: lastname1.toString(),
                                          mobile: mobilenumber.text.toString(),
                                          email: emailaddress.text.toString(),
                                          country: phoneNumber.toString(),
                                          currnet_shakha: drop.toString(),
                                          dob: dob.toString(),
                                          native_shakha: drop1.toString(),
                                          aali: aali_drop.toString(),
                                          otp: otp.toString(),
                                        )
                                    ));
                                  });
                                    Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM);
                                }
                                else
                                {
                                  Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM);
                                }
                              }
                          }
                        },
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xffFFFFFF)),
                        ),
                      ),
                    ):
                    Container(
                      height: 45,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [
                              Colors.blue.shade600,
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
                          Fluttertoast.showToast(msg: "Select the CheckBox",toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM);
                        },
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xffFFFFFF)),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 43,
                    ),
                    SizedBox(
                      height: 31,
                    )
                  ]),
                ),
              ),
            ],
          )
      ),
    );
  }

  bool isChecked = false;
}


