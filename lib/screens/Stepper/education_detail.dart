import 'dart:convert';
import 'package:communityapp/screens/Stepper/professional_details.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/Stepper/family_details.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EducationDetails extends StatefulWidget {
  /*const EducationDetails({Key? key}) : super(key: key);*/
  String? material_status,gender,female;
  EducationDetails({
    required this.material_status,
    required this.gender,
    required this.female,
  });

  @override
  State<EducationDetails> createState() => _EducationDetailsState();
}

class _EducationDetailsState extends State<EducationDetails> {

  int? community_hostel;
  String gender = "Yes";

  List qualification_list=[];
  List education_categorey=[];
  List education_sub_catgorey=[];



  String? qualifications;
  String? Category;
  String? sub_Category;
  String? qualifications1;
  String? Category1;
  String? sub_Category1;
  String? qualifications2;
  String? Category2;
  String? sub_Category2;
  String? qualifications3;
  String? Category3;
  String? sub_Category3;
  String? qualifications4;
  String? Category4;
  String? sub_Category4;
  String? qualifications5;
  String? Category5;
  String? sub_Category5;
  List get_quali_list=[];
  Future  get_Qualifications() async{
    var url="https://community.creditmywallet.in.net/api/get_qua";
    http.Response response=await http.post(Uri.parse(url));
    var res=jsonDecode(response.body)['details'];
    setState(() {
      get_quali_list=res;
    });
  }

  List bussiness_Category=[];
  Future  bussi_Category() async{
    var url="https://community.creditmywallet.in.net/api/get_business_cat";
    http.Response response=await http.post(Uri.parse(url));
    var res=jsonDecode(response.body)['data'];
    setState(() {
      bussiness_Category=res;
    });

  }

  List bussiness_Sub_Category=[];
  Future  bussi_Sub_Category() async{
    Map data={
      "category_id":Category.toString(),
    };
    var url="https://community.creditmywallet.in.net/api/get_business_sub_cat";
    var body1=jsonEncode(data);
    http.Response response=await http.post(Uri.parse(url),headers: {"Content-Type":"application/json"}, body: body1);
    var res=jsonDecode(response.body)['data'];
    setState(() {
      bussiness_Sub_Category=res;
    });

  }

  bool add1=false;
  bool add2=false;
  bool add3=false;
  bool add4=false;
  bool add5=false;
  bool add6=false;
  bool add7=false;
  bool a_dd1=true;
  bool a_dd2=true;
  bool a_dd3=true;
  bool a_dd4=true;
  bool a_dd5=true;


  String? qual1_id,qual2_id,qual3_id,qual4_id,qual5_id;
  String? edu_ca_id1,edu_ca_id2,edu_ca_id3,edu_ca_id4,edu_ca_id5;
  String? edu_ca_sub_id1,edu_ca_sub_id2,edu_ca_sub_id3,edu_ca_sub_id4,edu_ca_sub_id5;

  String? qual1_id_name,qual2_id_name,qual3_id_name,qual4_id_name,qual5_id_name;
  String? edu_ca_id1_name,edu_ca_id2_name,edu_ca_id3_name,edu_ca_id4_name,edu_ca_id5_name;
  String? edu_ca_sub_id1_name,edu_ca_sub_id2_name,edu_ca_sub_id3_name,edu_ca_sub_id4_name,edu_ca_sub_id5_name;

  Future educatio_form() async{
    final pref=await SharedPreferences.getInstance();
    var get=pref.getString('user_id');
    Map data={
      'user_ids':get.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_form3_data");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    var res=json.decode(response.body);
    print(res.toString()+"nnfbffb");
    setState(() {
      qual1_id = res['user_qualification'][0]['quid'];
      if (qual1_id != null) {
        qualification_list.add(qual1_id);
      }
      else
      {
        null;
      }

      edu_ca_id1 = res['edu_catg'][0]['quid'];
      if (edu_ca_id1 != null) {
        setState((){
          education_categorey.add(edu_ca_id1);
        });
      }
      else
      {
        null;
      }
      /*edu_ca_id2 = res['edu_catg'][1]['quid'];
      edu_ca_id3 = res['edu_catg'][2]['quid'];
      edu_ca_id4 = res['edu_catg'][3]['quid'];
      edu_ca_id5 = res['edu_catg'][4]['quid'];*/

      edu_ca_sub_id1=res['edu_subcatg'][0]['quid'];
     /* edu_ca_sub_id2=res['edu_subcatg'][1]['quid'];
      edu_ca_sub_id3=res['edu_subcatg'][2]['quid'];
      edu_ca_sub_id4=res['edu_subcatg'][3]['quid'];
      edu_ca_sub_id5=res['edu_subcatg'][4]['quid'];*/

        if (edu_ca_sub_id1 != null) {
          education_sub_catgorey.add(edu_ca_sub_id1);
        }
        else
        {
          null;
        }
        setState((){
          qual1_id_name=res['user_qualification'][0]['name'];
        });

      edu_ca_id1_name=res['edu_catg'][0]['name'];

      edu_ca_sub_id1_name=res['edu_subcatg'][0]['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      educatio_form();
      bussi_Category();
      get_Qualifications();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              IconStepper (
                icons:  [
                  Icon(Icons.person),
                  Icon(Icons.supervised_user_circle,color:Colors.white),
                  Icon(Icons.access_alarm,color: Colors.white,),
                  Icon(Icons.supervised_user_circle),
                  Icon(Icons.flag),
                  Icon(Icons.access_alarm),
                  Icon(Icons.supervised_user_circle),
                ],
                activeStep: 2,
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
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                color: Color(0xffDED9D9),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    Form(
                        child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 22),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.38,
                                    height: 25,
                                    decoration: BoxDecoration(
                                    ),
                                    child: Text(
                                      "Education Details",
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
                          height: 22.29,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Qualification",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff7A7A7A)),
                            ),
                          ),
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
                                    value: qualifications,
                                    hint: qual1_id_name==null?Text("      Diploma"):Text("      "+qual1_id_name.toString()),
                                    icon: Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    items: get_quali_list.map((item) {
                                      return DropdownMenuItem(
                                        value: item['q_id'].toString(),
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 30),
                                          child: Text(
                                            item['qualification'].toString(),
                                            style: TextStyle(color: Colors.black54),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        setState((){
                                          qualifications = newValue! as String?;
                                          qualification_list.add(qualifications);
                                        });
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Education Category",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff7A7A7A)),
                            ),
                          ),
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
                                value: Category,
                                hint: edu_ca_id1_name==null?Text("      Medical/Engg/Pharmacy"):Text("      "+edu_ca_id1_name.toString()),
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: bussiness_Category.map((item) {
                                  return DropdownMenuItem(
                                    value: item['category_id'].toString(),
                                    child: Padding(
                                      padding:  EdgeInsets.only(left: 30),
                                      child: Text(
                                        item['category_name'].toString(),
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    setState((){
                                      Category = newValue! as String?;
                                      bussi_Sub_Category();
                                      education_categorey.add(Category);
                                    });

                                    print(Category.toString()+"&&&&&&&&&");
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Education Sub-Category",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff7A7A7A)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
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
                                value: sub_Category,
                                hint: edu_ca_sub_id1_name==null?Text("      Eg: MD Medicine"):Text("      "+edu_ca_sub_id1_name.toString()),
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: bussiness_Sub_Category.map((item) {
                                  return DropdownMenuItem(
                                    value: item['subcategory_id'].toString(),
                                    child: Padding(
                                      padding:  EdgeInsets.only(left: 30),
                                      child: Text(
                                        item['subcategory_name'].toString(),
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    sub_Category = newValue! as String?;
                                    education_sub_catgorey.add(sub_Category);
                                  });
                                },
                              ),
                            ),
                          ),
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
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Qualification",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff7A7A7A)),
                                  ),
                                ),
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
                                      value: qualifications1,
                                      hint: Text("      Diploma"),
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      items: get_quali_list.map((item) {
                                        return DropdownMenuItem(
                                          value: item['q_id'].toString(),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 30),
                                            child: Text(
                                              item['qualification'].toString(),
                                              style: TextStyle(color: Colors.black54),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          setState((){
                                            qualifications1 = newValue! as String?;
                                            qualification_list.add(qualifications1);
                                          });
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Education Category",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff7A7A7A)),
                                  ),
                                ),
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
                                      value: Category1,
                                      hint: Text("      Medical/Engg/Pharmacy"),
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      items: bussiness_Category.map((item) {
                                        return DropdownMenuItem(
                                          value: item['category_id'].toString(),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 30),
                                            child: Text(
                                              item['category_name'].toString(),
                                              style: TextStyle(color: Colors.black54),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          setState((){
                                            Category1 = newValue! as String?;
                                            bussi_Sub_Category();
                                            education_categorey.add(Category1);
                                          });

                                          print(Category.toString()+"&&&&&&&&&");
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Education Sub-Category",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff7A7A7A)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
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
                                      value: sub_Category1,
                                      hint: Text("      Eg: MD Medicine"),
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      items: bussiness_Sub_Category.map((item) {
                                        return DropdownMenuItem(
                                          value: item['subcategory_id'].toString(),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 30),
                                            child: Text(
                                              item['subcategory_name'].toString(),
                                              style: TextStyle(color: Colors.black54),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          sub_Category1 = newValue! as String?;
                                          education_sub_catgorey.add(sub_Category1);
                                        });
                                      },
                                    ),
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
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Qualification",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff7A7A7A)),
                                  ),
                                ),
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
                                      value: qualifications2,
                                      hint: Text("      Diploma"),
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      items: get_quali_list.map((item) {
                                        return DropdownMenuItem(
                                          value: item['q_id'].toString(),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 30),
                                            child: Text(
                                              item['qualification'].toString(),
                                              style: TextStyle(color: Colors.black54),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          setState((){
                                            qualifications2 = newValue! as String?;
                                            qualification_list.add(qualifications1);
                                          });
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Education Category",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff7A7A7A)),
                                  ),
                                ),
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
                                      value: Category2,
                                      hint: Text("      Medical/Engg/Pharmacy"),
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      items: bussiness_Category.map((item) {
                                        return DropdownMenuItem(
                                          value: item['category_id'].toString(),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 30),
                                            child: Text(
                                              item['category_name'].toString(),
                                              style: TextStyle(color: Colors.black54),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          setState((){
                                            Category2 = newValue! as String?;
                                            bussi_Sub_Category();
                                            education_categorey.add(Category1);
                                          });

                                          print(Category.toString()+"&&&&&&&&&");
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Education Sub-Category",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff7A7A7A)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
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
                                      value: sub_Category2,
                                      hint: Text("      Eg: MD Medicine"),
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      items: bussiness_Sub_Category.map((item) {
                                        return DropdownMenuItem(
                                          value: item['subcategory_id'].toString(),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 30),
                                            child: Text(
                                              item['subcategory_name'].toString(),
                                              style: TextStyle(color: Colors.black54),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          sub_Category2 = newValue! as String?;
                                          education_sub_catgorey.add(sub_Category1);
                                        });
                                      },
                                    ),
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
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Qualification",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff7A7A7A)),
                                  ),
                                ),
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
                                      value: qualifications3,
                                      hint: Text("      Diploma"),
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      items: get_quali_list.map((item) {
                                        return DropdownMenuItem(
                                          value: item['q_id'].toString(),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 30),
                                            child: Text(
                                              item['qualification'].toString(),
                                              style: TextStyle(color: Colors.black54),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          setState((){
                                            qualifications3 = newValue! as String?;
                                            qualification_list.add(qualifications1);
                                          });
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Education Category",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff7A7A7A)),
                                  ),
                                ),
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
                                      value: Category3,
                                      hint: Text("      Medical/Engg/Pharmacy"),
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      items: bussiness_Category.map((item) {
                                        return DropdownMenuItem(
                                          value: item['category_id'].toString(),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 30),
                                            child: Text(
                                              item['category_name'].toString(),
                                              style: TextStyle(color: Colors.black54),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          setState((){
                                            Category3 = newValue! as String?;
                                            bussi_Sub_Category();
                                            education_categorey.add(Category1);
                                          });

                                          print(Category.toString()+"&&&&&&&&&");
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Education Sub-Category",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff7A7A7A)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
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
                                      value: sub_Category3,
                                      hint: Text("      Eg: MD Medicine"),
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      items: bussiness_Sub_Category.map((item) {
                                        return DropdownMenuItem(
                                          value: item['subcategory_id'].toString(),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 30),
                                            child: Text(
                                              item['subcategory_name'].toString(),
                                              style: TextStyle(color: Colors.black54),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          sub_Category3 = newValue! as String?;
                                          education_sub_catgorey.add(sub_Category1);
                                        });
                                      },
                                    ),
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
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Qualification",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff7A7A7A)),
                                  ),
                                ),
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
                                      value: qualifications4,
                                      hint: Text("      Diploma"),
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      items: get_quali_list.map((item) {
                                        return DropdownMenuItem(
                                          value: item['q_id'].toString(),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 30),
                                            child: Text(
                                              item['qualification'].toString(),
                                              style: TextStyle(color: Colors.black54),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          setState((){
                                            qualifications4 = newValue! as String?;
                                            qualification_list.add(qualifications1);
                                          });
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Education Category",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff7A7A7A)),
                                  ),
                                ),
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
                                      value: Category4,
                                      hint: Text("      Medical/Engg/Pharmacy"),
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      items: bussiness_Category.map((item) {
                                        return DropdownMenuItem(
                                          value: item['category_id'].toString(),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 30),
                                            child: Text(
                                              item['category_name'].toString(),
                                              style: TextStyle(color: Colors.black54),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          setState((){
                                            Category4 = newValue! as String?;
                                            bussi_Sub_Category();
                                            education_categorey.add(Category1);
                                          });

                                          print(Category.toString()+"&&&&&&&&&");
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Education Sub-Category",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff7A7A7A)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
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
                                      value: sub_Category4,
                                      hint: Text("      Eg: MD Medicine"),
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      items: bussiness_Sub_Category.map((item) {
                                        return DropdownMenuItem(
                                          value: item['subcategory_id'].toString(),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 30),
                                            child: Text(
                                              item['subcategory_name'].toString(),
                                              style: TextStyle(color: Colors.black54),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          sub_Category4 = newValue! as String?;
                                          education_sub_catgorey.add(sub_Category1);
                                        });
                                      },
                                    ),
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
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Qualification",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff7A7A7A)),
                                  ),
                                ),
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
                                      value: qualifications5,
                                      hint: Text("      Diploma"),
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      items: get_quali_list.map((item) {
                                        return DropdownMenuItem(
                                          value: item['q_id'].toString(),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 30),
                                            child: Text(
                                              item['qualification'].toString(),
                                              style: TextStyle(color: Colors.black54),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          setState((){
                                            qualifications5 = newValue! as String?;
                                            qualification_list.add(qualifications1);
                                          });
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Education Category",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff7A7A7A)),
                                  ),
                                ),
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
                                      value: Category5,
                                      hint: Text("      Medical/Engg/Pharmacy"),
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      items: bussiness_Category.map((item) {
                                        return DropdownMenuItem(
                                          value: item['category_id'].toString(),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 30),
                                            child: Text(
                                              item['category_name'].toString(),
                                              style: TextStyle(color: Colors.black54),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          setState((){
                                            Category5 = newValue! as String?;
                                            bussi_Sub_Category();
                                            education_categorey.add(Category1);
                                          });

                                          print(Category.toString()+"&&&&&&&&&");
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Education Sub-Category",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff7A7A7A)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
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
                                      value: sub_Category5,
                                      hint: Text("      Eg: MD Medicine"),
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      items: bussiness_Sub_Category.map((item) {
                                        return DropdownMenuItem(
                                          value: item['subcategory_id'].toString(),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 30),
                                            child: Text(
                                              item['subcategory_name'].toString(),
                                              style: TextStyle(color: Colors.black54),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          sub_Category5 = newValue! as String?;
                                          education_sub_catgorey.add(sub_Category1);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 23,
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
                        SizedBox(
                          height: 20,
                        ),
                       Text(
                            "Note:Maximum Qualification that can be added 5",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff7A7A7A)),
                          ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Text(
                            "Have you stayed at our community hostel ?",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff7A7A7A)),
                          ),
                        ),
                        Column(
                          children: [
                            RadioListTile (
                              title: Text("Yes"),
                              activeColor: Color(0xffFA6393),
                              value: "",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                  if(gender=="Yes")
                                    {
                                      setState((){
                                        community_hostel=0;
                                      });

                                    }
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text("No"),
                              activeColor: Color(0xffFA6393),
                              value: "No",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                  if(gender=="No")
                                  {
                                    setState((){
                                      community_hostel=1;
                                    });
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 29,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child:  Row(
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                child: Center(
                                    child: MaterialButton(
                                      onPressed: (){
                                        Navigator.push(
                                            context, MaterialPageRoute(
                                            builder: (context) =>
                                                FamilyDetails(
                                                  material_status: "${widget.material_status}",
                                                  gender: "${widget.gender}",
                                                  female: "${widget.female}",
                                                )));
                                      },
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
                                        colors: [Colors.pink.shade100,
                                          Colors.pink.shade300
                                        ]
                                    )
                                ),
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Center(
                                    child: MaterialButton(
                                      onPressed: () async{
                                        if(qualification_list.length==0)
                                          {
                                            Fluttertoast.showToast(msg: "Qualification is Empty",toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM);
                                          }
                                        else if(education_categorey.length==0)
                                          {
                                            Fluttertoast.showToast(msg: "Education Categorey is Empty",toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM);
                                          }
                                        else if(education_sub_catgorey.length==0)
                                        {
                                          Fluttertoast.showToast(msg: "Education Sub Categorey is Empty",toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM);
                                        }
                                        else if(community_hostel==null)
                                        {
                                          Fluttertoast.showToast(msg: "Community Hostel is Empty",toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM);
                                        }
                                        else
                                          {
                                            final pref=await SharedPreferences.getInstance();
                                            var userid=pref.getString('user_id');
                                            final pref1=await SharedPreferences.getInstance();
                                            var id=pref1.getString('id');
                                            Map data = {
                                              'user_id': id.toString(),
                                              'user_ids' : userid.toString(),
                                              'qualification': qualification_list,
                                              'catrgory' : education_categorey,
                                              'subcatgeory': education_sub_catgorey,
                                              'community_hostel' : community_hostel,
                                            };
                                            Uri url = Uri.parse("https://community.creditmywallet.in.net/api/user_education_details");
                                            var body1 = json.encode(data);

                                            var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body1);
                                            var res=json.decode(response.body);
                                            var succes=res["status_message"];
                                            setState(() {
                                              print("######%%%%%%%%%^^^^^^^"+res.toString());
                                              print("*************"+data.toString());
                                            });
                                            if(res["status_message"]=="Inserted Successfully")
                                            {
                                              Fluttertoast.showToast(msg: succes.toString(),toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM);
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context)=>ProfessionalDetails()));
                                            }
                                            else{
                                              Fluttertoast.showToast(msg: succes.toString(),toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM);
                                            }
                                          }

                                      },
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
                        ),
                      ],
                    )
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ),
            ],
          )),
    );
  }


}

