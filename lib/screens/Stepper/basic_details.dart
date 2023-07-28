import 'dart:convert';
import 'package:communityapp/screens/Stepper/family_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasicDetail extends StatefulWidget {

  @override
  State<BasicDetail> createState() => _BasicDetailState();
}

class _BasicDetailState extends State<BasicDetail> {

  String? location;
  String? district;

  List get_city_list=[];
  Future  get_city() async{
    var url="https://community.creditmywallet.in.net/api/get_state";
    http.Response response=await http.post(Uri.parse(url));
    var res=jsonDecode(response.body)['state'];
    setState(() {
      print("%%%%%%%%%%%%"+res.toString());
      get_city_list=res;
      print(get_city_list.toString()+"%%%%%%%%%%%%%%%%");
    });

  }

  List get_district_list=[];
  Future  get_District() async{
    Map data={
      "state_id":location.toString(),
    };
    setState(() {
      print(location.toString()+"BBBBBBBBBBBBBBB");
    });
    var url="https://community.creditmywallet.in.net/api/get_dist";
    var body1=jsonEncode(data);
    http.Response response=await http.post(Uri.parse(url),headers: {"Content-Type":"application/json"}, body: body1);
    var res=jsonDecode(response.body)['state'];
    setState(() {
      print("%%%%%FFFFFFFFFFFf%%%%%%%"+res.toString());
      get_district_list=res;
      print(get_district_list.toString()+"%%%%%%%%%%%%%%%%");
    });

  }





  String? martial_status;
  String? selectgender;
  String? blood_group;
  String? ready_donate;
  String? drop;
  String country = 'Select Country';
  String taluka = 'Taluka';
  String persent_position = 'Present Position';
  String previous_postion1 = 'Previous Position';
  String previous_postion2 = 'Previous Position';
  String previous_postion3 = 'Previous Position';
  String previous_postion4 = 'Previous Position';
  String previous_postion5 = 'Previous Position';
  String previous_postion6 = 'Previous Position';
  String? Aniversery;
  String? married;
  String? gender;
  String? ready_to_donate;
  String? dob;
  String? from;
  String? to;
  String? from_v1;
  String? to_v1;
  String? from_v2;
  String? to_v2;
  String? from_v3;
  String? to_v3;
  String? from_v4;
  String? to_v4;
  String? from_v5;
  String? to_v5;
  String? from1;
  String? to1;
  bool add1=false;
  bool add2=false;
  bool add3=false;
  bool add4=false;
  bool add5=false;
  bool a_dd1=true;
  bool a_dd2=true;
  bool a_dd3=true;
  bool a_dd4=true;
  bool a_dd5=true;



  List list_previous_position=[];
  List list_form=[];
  List list_to=[];

  late DateTime _myDateTime;
  late DateTime _AniverseryDateTime;
  String? female_yes;

  var famale_li = [
    'Yes',
    'No'
  ];

  List<Widget> widgets = [];

  var items2 = [
    'Married to a Vadval ',
    'Married  to a Non Vadval',
    'Divorced',
    'Single'
  ];
  var items3 = [
    'Male',
    'Female',
    'Other'
  ];
  var items4 = [
    'A +',
    'A -',
    'B +',
    'B -',
    'O +',
    'O -',
    'AB +',
    'AB -'
  ];
  var items6 = [
    'Yes',
    'No'
  ];
  var items7 = [
    'Select Country',
    'India'
  ];
  var items10 = [
    'Present Position',
  ];

  var items13 = [
    'Previous Position',
  ];


  String? name,middle_name1,last_name4,current,aaali,sks_meber_ship,dob2;
  int? age6;
  Future getuser() async{
    final pref=await SharedPreferences.getInstance();
    var get=pref.getString('user_id');
    Map data={
      'user_id':get.toString()
    };
    print(data.toString());
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_user");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    setState(() {
      print(url.toString());
    });
    var res=json.decode(response.body)[0];
    setState(() {
      name=res['first_name'];
      middle_name1=res['middle_name'];
      last_name4=res['last_name'];
      current=res['shakha_name'];
      sks_meber_ship=res['sks_membership'];
      aaali=res['aali_name'];
      dob2=res['dob'];
      age6=res['turning'];
      setState(() {
        print(age6);
      });
      first_name.text=name.toString();
      middle_name.text=middle_name1.toString();
      last_name.text=last_name4.toString();
      nativeshakha.text=current.toString();
      current_shakha.text=current.toString();
      sksmembership.text=sks_meber_ship.toString();
      aali.text=aaali.toString();
      date_of.text=dob2.toString();
      age.text=age6.toString();
    });
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

  TextEditingController first_name=TextEditingController();
  TextEditingController middle_name=TextEditingController();
  TextEditingController last_name=TextEditingController();
  TextEditingController last_name2=TextEditingController();
  TextEditingController age=TextEditingController();
  TextEditingController address1=TextEditingController();
  TextEditingController address2=TextEditingController();
  TextEditingController landmark=TextEditingController();
  TextEditingController state=TextEditingController();
  TextEditingController pincode=TextEditingController();
  TextEditingController nativeshakha=TextEditingController();
  TextEditingController current_shakha=TextEditingController();
  TextEditingController aali=TextEditingController();
  TextEditingController date_of=TextEditingController();
  TextEditingController sksmembership=TextEditingController();
  TextEditingController taluka1=TextEditingController();



  String? addre1,addre2,landmark5,pin_code,taluka5,s_marital_status,s_gandar,s_gandar_name
  ,s_bloodgroup,s_marital_status_name,anniverser_d,ready_to_dona,ready_to_dona_name,
  country1,state1,st_district,st_district_id,state1_id;

  Future basic_form() async{
    final pref=await SharedPreferences.getInstance();
    var get=pref.getString('user_id');
    Map data={
      'user_ids':get.toString()
    };
    print(data.toString());
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_form1_data");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    var res=json.decode(response.body)['response'];
    setState(() {
      print(res.toString());
      addre1=res['user_f1_c_add1'];
      addre2=res['user_f1_c_add2'];
      landmark5=res['user_f1_c_lndmrk'];
      pin_code=res['user_f1_c_pin'];
      taluka5=res['user_f1_c_taluka'];
      s_gandar=res['user_f1_gender'];
      if(s_gandar!=null){
        gender=s_gandar;
      }
      else{
        null;
      }
      if(s_gandar=="0")
      {
        setState((){
          s_gandar_name="Male";
        });
      }
      else if(s_gandar=="1")
      {
        setState((){
          s_gandar_name="Female";
        });
      }
      else if(s_gandar=="2")
      {
        setState((){
          s_gandar_name="Other";
        });
      }

      s_marital_status=res['user_f1_marital_status'];
      if(s_marital_status!=null)
        {
          married=s_marital_status.toString();
        }
      else
        {
          null;
        }

      if(s_marital_status=="0")
      {
        setState((){
          s_marital_status_name="Married to a Vadval";
        });
      }
      else if(s_marital_status=="1")
      {
        setState((){
          s_marital_status_name="Married  to a Non Vadval";
        });
      }
      else if(s_marital_status=="2")
      {
        setState((){
          s_marital_status_name="Divorced";
        });
      }
      else if(s_marital_status=="3"){
        setState((){
          s_marital_status_name="Single";
        });
      }
      s_bloodgroup=res['user_f1_blood_group'];
      if(s_bloodgroup!=null)
        {
          blood_group=s_bloodgroup;
        }
      else
        {
          null;
        }

      anniverser_d=res['user_f1_anvrsy_dt'];
      if(anniverser_d!="0000-00-00")
        {
          Aniversery=anniverser_d.toString();
        }
      else
        {
          null;
        }

      ready_to_dona=res['user_f1_rdy_t_donate'];
      if(ready_to_dona!=null)
        {
          ready_to_donate=ready_to_dona;
        }
      else
        {
          null;
        }
      if(ready_to_dona=="0")
      {
        setState((){
          ready_to_dona_name='Yes';
        });
      }
      else if(ready_to_dona=="1")
      {
        setState((){
          ready_to_dona_name='No';
        });
      }

      country1=res['user_f1_c_cntry'];
      if(country1!=null)
        {
          country=country1.toString();
        }
      else
        {
          null;
        }

      st_district=res['district_title'];
      state1=res['state_title'];
      st_district_id=res['user_f1_c_distrk'];
      if(st_district_id!=null)
        {
          district=st_district_id;
        }
      else
        {
          null;
        }
      state1_id=res['user_f1_c_state'];
      if(state1_id!=null)
      {
        location=state1_id.toString();
      }
      else
      {
        null;
      }
      address1.text=addre1.toString();
      address2.text=addre2.toString();
      landmark.text=landmark5.toString();
      pincode.text=pin_code.toString();
      taluka1.text=taluka5.toString();
      print(res.toString());
    });
  }



  @override
  void initState() {
    super.initState();
    setState(() {
      basic_form();
      getuser();
      getlastname();
      get_city();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SingleChildScrollView(
          child:  Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                IconStepper (
                  icons:  [
                    Icon(Icons.person,color: Colors.white,),
                    Icon(Icons.supervised_user_circle),
                    Icon(Icons.access_alarm),
                    Icon(Icons.supervised_user_circle),
                    Icon(Icons.flag),
                    Icon(Icons.access_alarm),
                    Icon(Icons.supervised_user_circle),
                  ],
                  activeStep: 0,
                  stepRadius: 20,
                  scrollingDisabled: false,
                  enableNextPreviousButtons: false,
                  enableStepTapping: false,
                  lineColor: Colors.green,
                  lineLength: 60,
                  activeStepBorderPadding: 0,
                  onStepReached: (index) {
                    setState(() {
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    color: Color(0xffDED9D9),
                    child: Column(
                        children: [
                          SizedBox(
                            height: 32,
                          ),
                          Form(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 22),
                                    child: Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              height: 25,
                                              decoration: BoxDecoration(
                                              ),
                                              child: Text(
                                                "Personal Details",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xff000000)),
                                              ),
                                            ),
                                            Positioned(
                                                top: 22,
                                                child: Container(
                                                  height: 2,
                                                  width: MediaQuery.of(context).size.width * 0.25,
                                                  color: Colors.black,
                                                )
                                            )
                                          ],
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
                                        width: MediaQuery.of(context).size.width * .9,
                                        child: TextFormField(
                                          controller: first_name,
                                          enabled: true,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: "First Name",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon: Container(
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/person.png",
                                                  height: 15,
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        height: 50,
                                        width: MediaQuery.of(context).size.width * .9,
                                        child: TextFormField(
                                          controller: middle_name,
                                          enabled: true,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: "Middle Name",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon: Container(
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/person.png",
                                                  height: 15,
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        height: 50,
                                        width: MediaQuery.of(context).size.width * .9,
                                        child: TextFormField(
                                          controller: last_name,
                                          enabled: true,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: "Last Name",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon: Container(
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/person.png",
                                                  height: 15,
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  s_gandar==null?
                                  Padding(
                                    padding: EdgeInsets.only(top: 3, bottom: 3),
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                          value: selectgender,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Container(
                                                padding:EdgeInsets.all(12),
                                                height: 10,
                                                child: Image.asset(
                                                  "assets/images/gender1.png",
                                                )
                                            ),
                                            hintText: "Select Gender",
                                          ),
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ),
                                          ),
                                          items: items3.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(
                                                      items,
                                                      style: TextStyle(
                                                          color: Color(0xff878383),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectgender = newValue!;
                                              if(selectgender=="Male")
                                              {
                                                setState((){
                                                  gender='0';
                                                });
                                              }
                                              else if(selectgender=="Female")
                                              {
                                                setState((){
                                                  gender='1';
                                                });
                                              }
                                              else if(selectgender=="Other")
                                              {
                                                setState((){
                                                  gender='2';
                                                });
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ) :
                                  Padding(
                                    padding: EdgeInsets.only(top: 3, bottom: 3),
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                          value: selectgender,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Container(
                                                padding:EdgeInsets.all(12),
                                                height: 10,
                                                child: Image.asset(
                                                  "assets/images/gender1.png",
                                                )
                                            ),
                                            hintText: s_gandar_name.toString(),
                                          ),
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ),
                                          ),
                                          items: items3.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items.toString(),
                                                style: TextStyle(
                                                    color: Color(0xff878383),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectgender = newValue!;
                                              gender=s_gandar.toString();
                                              print(gender.toString());
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 8,
                                  ),
                                  s_marital_status==null?
                                  Padding(
                                    padding: EdgeInsets.only(top: 3, bottom: 3),
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                          value: martial_status,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Container(
                                                padding:EdgeInsets.all(12),
                                                height: 10,
                                                child: Image.asset(
                                                  "assets/images/maritalstatus.png",
                                                )
                                            ),
                                            hintText: "Marital Status",
                                          ),
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ),
                                          ),
                                          items: items2.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(
                                                      items,
                                                      style: TextStyle(
                                                          color: Color(0xff878383),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              martial_status = newValue!;
                                              if(martial_status=="Married to a Vadval")
                                              {
                                                setState((){
                                                  married="0";
                                                });
                                              }
                                              else if(martial_status=="Married  to a Non Vadval")
                                              {
                                                setState((){
                                                  married="1";
                                                });
                                              }
                                              else if(martial_status=="Divorced")
                                              {
                                                setState((){
                                                  married="2";
                                                });
                                              }
                                              else if(martial_status=="Single"){
                                                setState((){
                                                  married="3";
                                                });
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ):
                                  Padding(
                                    padding: EdgeInsets.only(top: 3, bottom: 3),
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                          value: martial_status,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Container(
                                                padding:EdgeInsets.all(12),
                                                height: 10,
                                                child: Image.asset(
                                                  "assets/images/maritalstatus.png",
                                                )
                                            ),
                                            hintText: s_marital_status_name.toString(),
                                          ),
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ),
                                          ),
                                          items: items2.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(
                                                items,
                                                style: TextStyle(
                                                    color: Color(0xff878383),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              martial_status = newValue!;
                                              if(martial_status=="Married to a Vadval ")
                                              {
                                                setState((){
                                                  married="0";
                                                });
                                              }
                                              else if(martial_status=="Married  to a Non Vadval")
                                              {
                                                setState((){
                                                  married="1";
                                                });
                                              }
                                              else if(martial_status=="Divorced")
                                              {
                                                setState((){
                                                  married="2";
                                                });
                                              }
                                              else if(martial_status=="Single"){
                                                setState((){
                                                  married="3";
                                                });
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  selectgender=="Female" && martial_status!="Single" && martial_status!="Divorced"  ?
                                  Padding(
                                    padding: EdgeInsets.only(top: 3, bottom: 3),
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                          value: female_yes,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "     Vadaval Before Marriage Yes or No",
                                          ),
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ),
                                          ),
                                          items: famale_li.map((String items) {
                                            return DropdownMenuItem(
                                                value: items,
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 50),
                                                  child: Text(items,
                                                    style: TextStyle(
                                                        color: Color(0xff878383),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                )
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              female_yes = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ):
                                  Container(),

                                  selectgender=='Female' && martial_status=="Married  to a Non Vadval"?
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        height: 50,
                                        width: MediaQuery.of(context).size.width * .9,
                                        child: TextFormField(
                                          controller: last_name2,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: "Last Name",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon: Container(
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/person.png",
                                                  height: 15,
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ) :
                                  SizedBox(
                                    height: 0,
                                  ),


                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    child: TextFormField(
                                      controller: date_of,
                                      enabled: true,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(14.0),
                                        border: InputBorder.none,
                                        hintText: "DOB",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff878383),
                                            fontSize: 14),
                                        prefixIcon: Container(
                                            padding: EdgeInsets.all(13),
                                            height: 22,
                                            child: Image.asset(
                                              "assets/images/year.png",
                                              fit: BoxFit.fill,
                                            )
                                        ),

                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                          value: blood_group,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Container(
                                                padding:EdgeInsets.all(13),
                                                height: 10,
                                                child: Image.asset(
                                                  "assets/images/bloodgroup.png",
                                                )
                                            ),
                                            hintText: s_bloodgroup==null?"Blood Group":s_bloodgroup.toString(),
                                          ),
                                          //hint: Text("      Blood Group"),
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ),
                                          ),
                                          items: items4.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(
                                                      items,
                                                      style: const TextStyle(
                                                          color: Color(0xff878383),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              blood_group = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    child: TextFormField(
                                      enabled: true,
                                      controller: age,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(14.0),
                                        border: InputBorder.none,
                                        hintText: "Age",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff878383),
                                            fontSize: 14),
                                        prefixIcon: Container(
                                            padding: EdgeInsets.all(14),
                                            height: 22,
                                            child: Image.asset(
                                              "assets/images/Age.png",
                                              height: 15,
                                              fit: BoxFit.fill,
                                            )
                                        ),// pass the hint text parameter here

                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  married!="3"  && married!="2" ?
                                  InkWell(
                                    onTap: () async{
                                      _AniverseryDateTime= (await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2050),
                                      ))!;
                                      setState(() {
                                        Aniversery=DateFormat('yyyy-MM-dd').format(_AniverseryDateTime);
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
                                            height: 22,
                                            child: Image.asset(
                                              "assets/images/year.png",
                                              fit: BoxFit.fill,
                                            )
                                        ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Aniversery!=null?
                                              Text(Aniversery.toString()):
                                              Text("Anniversary Date"),
                                            ],
                                          )
                                      ),
                                    ),
                                  ):
                                  InkWell(
                                    onTap: () async{

                                    },
                                    child: Padding(
                                      padding:  EdgeInsets.only(top: 3, bottom: 3),
                                      child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width * .9,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white54),
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
                                              Text("Anniversary Date"),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 3, bottom: 3),
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                          value: ready_donate,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Container(
                                                padding:EdgeInsets.all(13),
                                                height: 10,
                                                child: Image.asset(
                                                  "assets/images/donateblood.png",
                                                )
                                            ),
                                            hintText: ready_to_dona_name==null?"Ready to donate blood":ready_to_dona_name.toString(),
                                          ),
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ),
                                          ),
                                          items: items6.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(
                                                      items,
                                                      style: const TextStyle(
                                                          color: Color(0xff878383),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              ready_donate = newValue!;
                                              if(ready_donate=="Yes")
                                              {
                                                ready_to_donate='0';
                                              }
                                              else if(ready_donate=="No")
                                              {
                                                ready_to_donate='1';
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 22),
                                    child: Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.33,
                                              height: 25,
                                              decoration: BoxDecoration(
                                              ),
                                              child: Text(
                                                "Contact Details",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xff000000)),
                                              ),
                                            ),
                                            Positioned(
                                                top: 22,
                                                child: Container(
                                                  height: 2,
                                                  width: MediaQuery.of(context).size.width * 0.22,
                                                  color: Colors.black,
                                                )
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    child: TextFormField(
                                      controller: address1,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(14.0),
                                        border: InputBorder.none,
                                        hintText: "Address Line 1",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff878383),
                                            fontSize: 14),
                                        prefixIcon: Container(
                                            padding: EdgeInsets.all(12),
                                            height: 25,
                                            width: 25,
                                            child: Image.asset(
                                              "assets/images/address.png",
                                              height: 15,
                                            )
                                        )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    child: TextFormField(
                                      controller: address2,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(14.0),
                                        border: InputBorder.none,
                                        hintText: "Address Line 2",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff878383),
                                            fontSize: 14),
                                        prefixIcon: Container(
                                            padding: EdgeInsets.all(12),
                                            height: 25,
                                            width: 25,
                                            child: Image.asset(
                                              "assets/images/address.png",
                                              fit: BoxFit.cover,
                                              height: 15,
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    child: TextFormField(
                                      controller: landmark,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(14.0),
                                        border: InputBorder.none,
                                        hintText: "Landmark",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff878383),
                                            fontSize: 14),
                                        prefixIcon: Container(
                                            padding: EdgeInsets.all(12),
                                            height: 25,
                                            width: 25,
                                            child: Image.asset(
                                              "assets/images/landmark.png",
                                              height: 15,
                                            )),// pass the hint text parameter here
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          value: country,
                                          hint: country1!=null?Text("Select Country"):Text(country1.toString()),
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(Icons.arrow_drop_down, size: 30),
                                          ),
                                          items: items7.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Padding(
                                                padding: EdgeInsets.all(12),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        child: Image.asset(
                                                          "assets/images/country.png",
                                                          height: 22,
                                                        )),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      items,
                                                      style: const TextStyle(
                                                          color: Color(0xff878383),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              country = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 3, bottom: 3),
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Colors.white),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                          value: location,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Container(
                                                padding:EdgeInsets.all(13),
                                                height: 10,
                                                child: Image.asset(
                                                  "assets/images/state.png",
                                                )
                                            ),
                                            hintText: state1==null?"State":state1.toString(),
                                          ),
                                         // hint: Text("      State"),
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(Icons.arrow_drop_down),
                                          ),
                                          items: get_city_list.map((item) {
                                            return DropdownMenuItem(
                                              value: item['state_id'].toString(),
                                              child: Text(
                                                  item['state_title'].toString(),
                                                  style: TextStyle(color: Colors.black54),
                                                ),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              setState((){
                                                location = newValue! as String?;
                                                get_District();
                                              });
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 3, bottom: 3),
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Colors.white),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                          value: district,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Container(
                                                padding:EdgeInsets.all(13),
                                                height: 10,
                                                child: Image.asset(
                                                  "assets/images/distic.png",
                                                )
                                            ),
                                            hintText: st_district==null?"District":st_district.toString(),
                                          ),
                                          //hint: Text("      District"),
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(Icons.arrow_drop_down),
                                          ),
                                          items: get_district_list.map((item) {
                                            return DropdownMenuItem(
                                              value: item['districtid'].toString(),
                                              child: Text(
                                                  item['district_title'].toString(),
                                                  style: TextStyle(color: Colors.black54),
                                                ),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              setState((){
                                                district = newValue! as String?;
                                              });
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    child: TextFormField(
                                      controller: pincode,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(6),
                                      ],
                                      validator: (val) {
                                        if (val! == null &&
                                            val.isEmpty &&
                                            val.length == 6) {
                                          Fluttertoast.showToast(
                                              msg: "Please enter 6 digit mobile Number");
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(14.0),
                                        border: InputBorder.none,
                                        hintText: "Pin Code",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff878383),
                                            fontSize: 14),
                                        prefixIcon: Container(
                                            padding: EdgeInsets.all(12),
                                            height: 25,
                                            width: 25,
                                            child: Image.asset(
                                              "assets/images/pincode.png",
                                              height: 15,
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    child: TextFormField(
                                      controller: taluka1,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(14.0),
                                        border: InputBorder.none,
                                        hintText: "Taluka",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff878383),
                                            fontSize: 14),
                                        prefixIcon: Container(
                                            padding: EdgeInsets.all(12),
                                            height: 25,
                                            width: 25,
                                            child: Image.asset(
                                              "assets/images/taluka.png",
                                              height: 15,
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 22),
                                    child: Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.33,
                                              height: 25,
                                              decoration: BoxDecoration(
                                              ),
                                              child: Text(
                                                "Shakha Details",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xff000000)),
                                              ),
                                            ),
                                            Positioned(
                                                top: 22,
                                                child: Container(
                                                  height: 2,
                                                  width: MediaQuery.of(context).size.width * 0.22,
                                                  color: Colors.black,
                                                )
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    child: TextFormField(
                                      enabled: false,
                                      controller: nativeshakha,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(14.0),
                                        border: InputBorder.none,
                                        hintText: "Native Shakha",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff878383),
                                            fontSize: 14),
                                        prefixIcon: Container(
                                            padding: EdgeInsets.all(12),
                                            height: 25,
                                            width: 25,
                                            child: Image.asset(
                                              "assets/images/native.png",
                                              height: 15,
                                            )),// pass the hint text parameter here
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    child: TextFormField(
                                      controller: aali,
                                      enabled: false,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(14.0),
                                        border: InputBorder.none,
                                        hintText: "Aali (Aali*)",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff878383),
                                            fontSize: 14),
                                        prefixIcon: Container(
                                            padding: EdgeInsets.all(12),
                                            height: 25,
                                            width: 25,
                                            child: Image.asset(
                                              "assets/images/native.png",
                                              height: 15,
                                            )),// pass the hint text parameter here
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    child: TextFormField(
                                      enabled: false,
                                      controller: current_shakha,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(14.0),
                                        border: InputBorder.none,
                                        hintText: "Current Sakha",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff878383),
                                            fontSize: 14),
                                        prefixIcon: Container(
                                            padding: EdgeInsets.all(12),
                                            height: 25,
                                            width: 25,
                                            child: Image.asset(
                                              "assets/images/membership.png",
                                              height: 15,
                                            )),// pass the hint text parameter here
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    child: TextFormField(
                                      enabled: false,
                                      controller: sksmembership,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(14.0),
                                        border: InputBorder.none,
                                        hintText: "SKS membership",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff878383),
                                            fontSize: 14),
                                        prefixIcon: Container(
                                            padding: EdgeInsets.all(12),
                                            height: 25,
                                            width: 25,
                                            child: Image.asset(
                                              "assets/images/membership.png",
                                              height: 15,
                                            )),// pass the hint text parameter here
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 3, bottom: 3),
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          value: persent_position,
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ),
                                          ),
                                          items: items10.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Padding(
                                                padding: EdgeInsets.all(12),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        child: Image.asset(
                                                          "assets/images/position.png",
                                                          height: 22,
                                                        )
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 10),
                                                      child: Text(
                                                        items,
                                                        style: TextStyle(
                                                            color: Color(0xff878383),
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              persent_position = newValue!;
                                              list_previous_position.add(persent_position);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
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
                                        from=DateFormat('yyyy').format(_myDateTime);
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
                                              from!=null?
                                              Text(from.toString()):
                                              Text("From Year"),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
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
                                        to=DateFormat('yyyy').format(_myDateTime);
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
                                              to!=null?
                                              Text(to.toString()):
                                              Text("To Year"),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 22),
                                    child: Row(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.51,
                                              height: 25,
                                              decoration: BoxDecoration(
                                              ),
                                              child: Text(
                                                "Add Previous Positions",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xff000000)),
                                              ),
                                            ),
                                            Positioned(
                                                top: 22,
                                                child: Container(
                                                  height: 2,
                                                  width: MediaQuery.of(context).size.width * 0.30,
                                                  color: Colors.black,
                                                )
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 3, bottom: 3),
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width * .9,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              value: previous_postion1,
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 30,
                                                ),
                                              ),
                                              items: items13.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(12),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            child: Image.asset(
                                                              "assets/images/position.png",
                                                              height: 22,
                                                            )),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          items,
                                                          style: TextStyle(
                                                              color: Color(0xff878383),
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w400),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  previous_postion1 = newValue!;
                                                  list_previous_position.add(previous_postion1);
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
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
                                            from1=DateFormat('yyyy').format(_myDateTime);
                                            list_form.add(from1.toString());
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
                                                  from1!=null?
                                                  Text(from1.toString()):
                                                  Text("From Year"),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
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
                                            to1=DateFormat('yyyy').format(_myDateTime);
                                            list_to.add(to1.toString());
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
                                                  to1!=null?
                                                  Text(to1.toString()):
                                                  Text("To Year"),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: add1,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            IconButton(
                                                onPressed: (){
                                                  setState(() {
                                                    add1=false;
                                                    a_dd1=true;
                                                  });
                                                },
                                                icon: Icon(Icons.clear)),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 3, bottom: 3),
                                          child: Container(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width * .9,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.white),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                value: previous_postion2,
                                                icon: Padding(
                                                  padding: EdgeInsets.only(right: 20),
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 30,
                                                  ),
                                                ),
                                                items: items13.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(12),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              child: Image.asset(
                                                                "assets/images/position.png",
                                                                height: 22,
                                                              )),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            items,
                                                            style: TextStyle(
                                                                color: Color(0xff878383),
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    previous_postion2 = newValue!;
                                                    list_previous_position.add(previous_postion2);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
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
                                              from_v1=DateFormat('yyyy').format(_myDateTime);
                                              list_form.add(from_v1);
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
                                                    from_v1!=null?
                                                    Text(from_v1.toString()):
                                                    Text("From Year"),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
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
                                              to_v1=DateFormat('yyyy').format(_myDateTime);
                                              list_to.add(to_v1);
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
                                                    to_v1!=null?
                                                    Text(to_v1.toString()):
                                                    Text("To Year"),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: add2,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            IconButton(
                                                onPressed: (){
                                                  setState(() {
                                                    add2=false;
                                                  });
                                                },
                                                icon: Icon(Icons.clear)),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 3, bottom: 3),
                                          child: Container(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width * .9,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.white),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                value: previous_postion3,
                                                icon: Padding(
                                                  padding: EdgeInsets.only(right: 20),
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 30,
                                                  ),
                                                ),
                                                items: items13.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(12),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              child: Image.asset(
                                                                "assets/images/position.png",
                                                                height: 22,
                                                              )),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            items,
                                                            style: TextStyle(
                                                                color: Color(0xff878383),
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    previous_postion3 = newValue!;
                                                    list_previous_position.add(previous_postion3);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
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
                                              from_v2=DateFormat('yyyy').format(_myDateTime);
                                              list_form.add(from_v2);
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
                                                    from_v2!=null?
                                                    Text(from_v2.toString()):
                                                    Text("From Year"),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
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
                                              to_v2=DateFormat('yyyy').format(_myDateTime);
                                              list_to.add(to_v2);
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
                                                    to_v2!=null?
                                                    Text(to_v2.toString()):
                                                    Text("To Year"),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: add3,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            IconButton(
                                                onPressed: (){
                                                  setState(() {
                                                    add3=false;
                                                  });
                                                },
                                                icon: Icon(Icons.clear)),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 3, bottom: 3),
                                          child: Container(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width * .9,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.white),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                value: previous_postion4,
                                                icon: Padding(
                                                  padding: EdgeInsets.only(right: 20),
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 30,
                                                  ),
                                                ),
                                                items: items13.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(12),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              child: Image.asset(
                                                                "assets/images/position.png",
                                                                height: 22,
                                                              )),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            items,
                                                            style: TextStyle(
                                                                color: Color(0xff878383),
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    previous_postion4 = newValue!;
                                                    list_previous_position.add(previous_postion4);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
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
                                              from_v3=DateFormat('yyyy').format(_myDateTime);
                                              list_form.add(from_v3);
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
                                                    from_v3!=null?
                                                    Text(from_v3.toString()):
                                                    Text("From Year"),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
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
                                              to_v3=DateFormat('yyyy').format(_myDateTime);
                                              list_to.add(to_v3);
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
                                                    to_v3!=null?
                                                    Text(to_v3.toString()):
                                                    Text("To Year"),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: add4,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            IconButton(
                                                onPressed: (){
                                                  setState(() {
                                                    add4=false;
                                                  });
                                                },
                                                icon: Icon(Icons.clear)),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 3, bottom: 3),
                                          child: Container(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width * .9,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.white),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                value: previous_postion5,
                                                icon: Padding(
                                                  padding: EdgeInsets.only(right: 20),
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 30,
                                                  ),
                                                ),
                                                items: items13.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(12),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              child: Image.asset(
                                                                "assets/images/position.png",
                                                                height: 22,
                                                              )),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            items,
                                                            style: TextStyle(
                                                                color: Color(0xff878383),
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    previous_postion5 = newValue!;
                                                    list_previous_position.add(previous_postion5);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
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
                                              from_v4=DateFormat('yyyy').format(_myDateTime);
                                              list_form.add(from_v4);
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
                                                    from_v4!=null?
                                                    Text(from_v4.toString()):
                                                    Text("From Year"),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
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
                                              to_v4=DateFormat('yyyy').format(_myDateTime);
                                              list_to.add(to_v4);
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
                                                    to_v4!=null?
                                                    Text(to_v4.toString()):
                                                    Text("To Year"),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: add5,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            IconButton(
                                                onPressed: (){
                                                  setState(() {
                                                    add5=false;
                                                  });
                                                },
                                                icon: Icon(Icons.clear)),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 3, bottom: 3),
                                          child: Container(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width * .9,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.white),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                value: previous_postion6,
                                                icon: Padding(
                                                  padding: EdgeInsets.only(right: 20),
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 30,
                                                  ),
                                                ),
                                                items: items13.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(12),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              child: Image.asset(
                                                                "assets/images/position.png",
                                                                height: 22,
                                                              )),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            items,
                                                            style: TextStyle(
                                                                color: Color(0xff878383),
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    previous_postion6 = newValue!;
                                                    list_previous_position.add(previous_postion6);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
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
                                              from_v5=DateFormat('yyyy').format(_myDateTime);
                                              list_form.add(from_v5);
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
                                                    from_v5!=null?
                                                    Text(from_v5.toString()):
                                                    Text("From Year"),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
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
                                              to_v5=DateFormat('yyyy').format(_myDateTime);
                                              list_to.add(to_v5);
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
                                                    to_v5!=null?
                                                    Text(to_v5.toString()):
                                                    Text("To Year"),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  add1==false?
                                  Visibility(
                                    visible: a_dd1,
                                    child: Row(
                                    children: [
                                      Container(
                                        height: 45,
                                        width: MediaQuery.of(context).size.width * 0.5,
                                      ),
                                      Container(
                                        height: 45,
                                        width: MediaQuery.of(context).size.width * 0.40,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Colors.blue.shade100,
                                                  Colors.blue.shade300
                                                ])),
                                        child: MaterialButton(
                                          onPressed: (){
                                                setState(() {
                                                  add1=true;
                                                  a_dd1=false;
                                              print("Qjvjnjnv workkr rha hai re");
                                            });
                                          },
                                          child: Text("Add More",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                color: Color(0xffFFFFFF)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ):
                                  Visibility(
                                    visible: a_dd1,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.5,
                                        ),
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.blue.shade100,
                                                    Colors.blue.shade300
                                                  ])),
                                          child: MaterialButton(
                                            onPressed: (){
                                            },
                                            child: Text("Add More",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Color(0xffFFFFFF)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  add2==false?
                                  Visibility(
                                    visible: add1,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.5,
                                        ),
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.blue.shade100,
                                                    Colors.blue.shade300
                                                  ])),
                                          child: MaterialButton(
                                            onPressed: (){
                                              setState(() {
                                                add2=true;
                                                a_dd2=false;
                                                print("kkr rha hai re");
                                              });
                                            },
                                            child: Text("Add More",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Color(0xffFFFFFF)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ):
                                  Visibility(
                                    visible: a_dd2,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.5,
                                        ),
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.blue.shade100,
                                                    Colors.blue.shade300
                                                  ])),
                                          child: MaterialButton(
                                            onPressed: (){
                                            },
                                            child: Text("Add More",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Color(0xffFFFFFF)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  add3==false?
                                  Visibility(
                                    visible: add2,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.5,
                                        ),
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.blue.shade100,
                                                    Colors.blue.shade300
                                                  ])),
                                          child: MaterialButton(
                                            onPressed: (){
                                              setState(() {
                                                add3=true;
                                                a_dd3=true;
                                                print("Qjvjnjnv workkr rha hai re");
                                              });
                                            },
                                            child: Text("Add More",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Color(0xffFFFFFF)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ):
                                  Visibility(
                                    visible: false,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.5,
                                        ),
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.blue.shade100,
                                                    Colors.blue.shade300
                                                  ])),
                                          child: MaterialButton(
                                            onPressed: (){
                                              setState(() {
                                                if(add1==false)
                                                {
                                                  setState(() {
                                                    add1=true;
                                                  });
                                                }
                                                else if(add1==true){
                                                  setState(() {
                                                    add2=true;
                                                    a_dd1=true;
                                                  });
                                                }
                                                else if(a_dd1==true){
                                                  setState(() {
                                                    add3=true;
                                                  });
                                                }
                                                print("Qjvjnjnv workkr rha hai re");
                                              });
                                            },
                                            child: Text("Add More",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Color(0xffFFFFFF)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  add4==false?
                                  Visibility(
                                    visible: add3,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.5,
                                        ),
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.blue.shade100,
                                                    Colors.blue.shade300
                                                  ])),
                                          child: MaterialButton(
                                            onPressed: (){
                                              setState(() {
                                                add4=true;
                                                a_dd4=false;
                                                print(" re");
                                              });
                                            },
                                            child: Text("Add More",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Color(0xffFFFFFF)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ):
                                  Visibility(
                                    visible: a_dd4,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.5,
                                        ),
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.blue.shade100,
                                                    Colors.blue.shade300
                                                  ])),
                                          child: MaterialButton(
                                            onPressed: (){
                                              setState(() {
                                                if(add1==false)
                                                {
                                                  setState(() {
                                                    add1=true;
                                                  });
                                                }
                                                else if(add1==true){
                                                  setState(() {
                                                    add2=true;
                                                    a_dd1=true;
                                                  });
                                                }
                                                else if(a_dd1==true){
                                                  setState(() {
                                                    add3=true;
                                                  });
                                                }
                                                print("Qjvjnjnv workkr rha hai re");
                                              });
                                            },
                                            child: Text("Add More",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Color(0xffFFFFFF)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  add5==false?
                                  Visibility(
                                    visible: add4,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.5,
                                        ),
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.blue.shade100,
                                                    Colors.blue.shade300
                                                  ])),
                                          child: MaterialButton(
                                            onPressed: (){
                                              setState(() {
                                                add5=true;
                                                a_dd5=true;
                                                print("Qjvjnjnv workkr rha hai re");
                                              });
                                            },
                                            child: Text("Add More",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Color(0xffFFFFFF)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ):
                                  Visibility(
                                    visible: a_dd5,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.5,
                                        ),
                                        Container(
                                          height: 45,
                                          width: MediaQuery.of(context).size.width * 0.40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.blue.shade100,
                                                    Colors.blue.shade300
                                                  ])),
                                          child: MaterialButton(
                                            onPressed: (){
                                            },
                                            child: Text("Add More",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Color(0xffFFFFFF)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft,
                                    colors: [
                                      Colors.blue,
                                      Colors.white,
                                    ],
                                  )
                              ),
                              child: MaterialButton(
                                onPressed: () async{
                                  if(gender==null)
                                    {
                                      Fluttertoast.showToast(msg: "Gender is Empty",toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM);
                                    }
                                  else if(married==null)
                                    {
                                      Fluttertoast.showToast(msg: "Marital Status is Empty",toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM);
                                    }
                                  else if(blood_group==null)
                                  {
                                    Fluttertoast.showToast(msg: "Blood Group is Empty",toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM);
                                  }
                                  else if(address1.text.isEmpty)
                                  {
                                    Fluttertoast.showToast(msg: "Addres one is Empty",toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM);
                                  }
                                  else if(address2.text.isEmpty)
                                  {
                                    Fluttertoast.showToast(msg: "Addres two is Empty",toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM);
                                  }
                                  else if(landmark.text.isEmpty)
                                  {
                                    Fluttertoast.showToast(msg: "LandMark is Empty",toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM);
                                  }
                                  else if(country==null)
                                  {
                                    Fluttertoast.showToast(msg: "Country is Empty",toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM);
                                  }
                                  else if(location==null)
                                  {
                                    Fluttertoast.showToast(msg: "State is Empty",toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM);
                                  }
                                  else if(district==null)
                                  {
                                    Fluttertoast.showToast(msg: "District is Empty",toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM);
                                  }
                                  else if(pincode.text.isEmpty)
                                  {
                                    Fluttertoast.showToast(msg: "Pincode is Empty",toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM);
                                  }
                                  else if(taluka1.text.isEmpty)
                                  {
                                    Fluttertoast.showToast(msg: "Taluka is Empty",toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM);
                                  }
                                  else
                                    {
                                      if(married=="3" || married=="2")
                                      {
                                        final pref = await SharedPreferences.getInstance();
                                        var userid = pref.getString('user_id');
                                        final pref1 = await SharedPreferences.getInstance();
                                        var id = pref1.getString('id');
                                        Map data = {
                                          'user_id': id.toString(),
                                          'user_ids': userid.toString(),
                                          'fname': name,
                                          'mname': middle_name1,
                                          'lname': last_name4,
                                          'dob': dob2.toString(),
                                          'marital_status': married,
                                          'gender': gender,
                                          'blood_group': blood_group,
                                          'age': age.text.toString(),
                                          'anversary_date': Aniversery.toString(),
                                          'ready_doante': ready_to_donate,
                                          'add1': address1.text.toString(),
                                          'add2': address2.text.toString(),
                                          'landmark': landmark.text.toString(),
                                          'country': country,
                                          'state': location.toString(),
                                          'districk': district.toString(),
                                          'pincode': pincode.text.toString(),
                                          'taluka': taluka1.text.toString(),
                                          'nativshakha': current,
                                          'shakhaaali': aaali,
                                          'currentshakaha': current,
                                          'skhakhamember': sks_meber_ship,
                                          'personalposition': persent_position,
                                          'fromyear': from.toString(),
                                          'toyear': to.toString(),
                                          'prevposition': list_previous_position,
                                          'pfronyear': list_form,
                                          'ptoyear': list_to,
                                        };
                                        print(data.toString());
                                        Uri url = Uri.parse("https://community.creditmywallet.in.net/api/user_personal_details");
                                        var body1 = json.encode(data);

                                        var response = await http.post(url,
                                            headers: {
                                              "Content-Type": "application/json"
                                            }, body: body1);
                                        var res = json.decode(response.body);
                                        var succes = res["status_message"];
                                        setState(() {
                                          print("######%%%%%%%%%^^^^^^^" +
                                              res.toString());
                                        });
                                        if (res["status_message"] ==
                                            "Inserted Successfully") {
                                          Fluttertoast.showToast(
                                              msg: succes.toString(),
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM);
                                          Navigator.push(
                                              context, MaterialPageRoute(
                                              builder: (context) =>
                                                  FamilyDetails(
                                                    material_status: married,
                                                    gender: gender,
                                                    female: female_yes,
                                                  )));
                                        }
                                        else {
                                          Fluttertoast.showToast(
                                              msg: succes.toString(),
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM);
                                        }
                                      }
                                      else
                                        {
                                          if(Aniversery==null)
                                            {
                                              Fluttertoast.showToast(msg: "Anniverary is Empty",toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM);
                                            }
                                          else{
                                            final pref = await SharedPreferences
                                                .getInstance();
                                            var userid = pref.getString('user_id');
                                            final pref1 = await SharedPreferences
                                                .getInstance();
                                            var id = pref1.getString('id');
                                            Map data = {
                                              'user_id': id.toString(),
                                              'user_ids': userid.toString(),
                                              'fname': name,
                                              'mname': middle_name1,
                                              'lname': last_name4,
                                              'dob': dob2.toString(),
                                              'marital_status': married,
                                              'gender': gender,
                                              'blood_group': blood_group,
                                              'age': age.text.toString(),
                                              'anversary_date': Aniversery.toString(),
                                              'ready_doante': ready_to_donate,
                                              'add1': address1.text.toString(),
                                              'add2': address2.text.toString(),
                                              'landmark': landmark.text.toString(),
                                              'country': country,
                                              'state': location.toString(),
                                              'districk': district.toString(),
                                              'pincode': pincode.text.toString(),
                                              'taluka': taluka1.text.toString(),
                                              'nativshakha': current,
                                              'shakhaaali': aaali,
                                              'currentshakaha': current,
                                              'skhakhamember': sks_meber_ship,
                                              'personalposition': persent_position,
                                              'fromyear': from.toString(),
                                              'toyear': to.toString(),
                                              'prevposition': list_previous_position,
                                              'pfronyear': list_form,
                                              'ptoyear': list_to,
                                            };
                                            Uri url = Uri.parse(
                                                "https://community.creditmywallet.in.net/api/user_personal_details");
                                            var body1 = json.encode(data);

                                            var response = await http.post(url,
                                                headers: {
                                                  "Content-Type": "application/json"
                                                }, body: body1);
                                            var res = json.decode(response.body);
                                            var succes = res["status_message"];
                                            setState(() {
                                              print("######%%%%%%%%%^^^^^^^" +
                                                  res.toString());
                                            });
                                            if (res["status_message"] ==
                                                "Inserted Successfully") {
                                              Fluttertoast.showToast(
                                                  msg: succes.toString(),
                                                  toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM);
                                              Navigator.push(
                                                  context, MaterialPageRoute(
                                                  builder: (context) =>
                                                      FamilyDetails(
                                                        material_status: martial_status,
                                                        gender: selectgender,
                                                        female: female_yes,)));
                                            }
                                            else {
                                              Fluttertoast.showToast(
                                                  msg: succes.toString(),
                                                  toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM);
                                            }
                                          }
                                        }
                                    }
                                },
                                highlightColor: Colors.green,
                                child: Text("Save",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xffFFFFFF)),),
                              )
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ]
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}


