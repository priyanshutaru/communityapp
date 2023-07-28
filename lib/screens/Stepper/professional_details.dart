import 'dart:convert';
import 'package:communityapp/screens/Stepper/education_detail.dart';
import 'package:communityapp/screens/Stepper/land_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class ProfessionalDetails extends StatefulWidget {
  const ProfessionalDetails({Key? key}) : super(key: key);

  @override
  State<ProfessionalDetails> createState() => _ProfessionalDetailsState();
}

class _ProfessionalDetailsState extends State<ProfessionalDetails> {
  String? jobtype;
  String? job;
  String? dropdownvalue2;
  String? dob;
  late DateTime _myDateTime;
  int? ownBussiness;
  TextEditingController achivement=TextEditingController();
  TextEditingController otet_infosystems=TextEditingController();
  TextEditingController retirement=TextEditingController();

  var items = [
    'Job',
    'Business',
    'Retired',
    'Student',
  ];
  var items1 = [
    'Government/Private',
    'Government',
    'Private',
  ];
  var items2 = [
    'Clerical',
    'Technical',
  ];


  String? Category;

  List bussiness_Category=[];
  Future  bussi_Category() async{
    var url="https://community.creditmywallet.in.net/api/get_business_cat";
    http.Response response=await http.post(Uri.parse(url));
    var res=jsonDecode(response.body)['data'];
    setState(() {
      print("%%%%%%%%%%%%"+res.toString());
      bussiness_Category=res;
      print(bussiness_Category.toString()+"%%%%%%%%%%%%%%%%");
    });

  }

  String gender = "Yes";
  String? company_name,retirement1,achivements;
  String? type,g_job,g_job_cat,g_deaprtment,g_clear,year_ofret,ach,g_job_cat_name;
  Future professional_form() async{
    final pref=await SharedPreferences.getInstance();
    var get=pref.getString('user_id');
    Map data={
      'user_ids':get.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_form4_data");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    var res=json.decode(response.body);
    setState(() {
      g_clear=res['response']['user_f4_job_clerical'];
      if(g_clear!=null)
      {
        dropdownvalue2=g_clear;
      }
      else
      {
        null;
      }
      type=res['response']['user_f4_jobType'];
      if(type!=null)
        {
          jobtype=type;
        }
      else
        {
          null;
        }
      g_job=res['response']['user_f4_job'];
      if(g_job!=null)
      {
        job=g_job;
      }
      else
      {
        null;
      }
      g_job_cat=res['response']['user_f4_job_cat'];
      if(g_job_cat!=null)
      {
        Category=g_job_cat;
      }
      else
      {
        null;
      }
      company_name=res['response']['user_f4_compnyName'];
      retirement1=res['response']['user_f4_retirement'];
      achivements=res['response']['user_f4_achievements'];
      if(company_name!=null)
        {
          otet_infosystems.text=company_name.toString();
        }
      else
        {
          null;
        }
      if(retirement1!=null)
      {
        retirement.text=retirement1.toString();
      }
      else
      {
        null;
      }
      if(achivements!=null)
      {
        achivement.text=achivements.toString();
      }
      else
      {
        null;
      }
    });
  }



  @override
  void initState() {
    super.initState();
    professional_form();
    bussi_Category();
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
                  Icon(Icons.person,),
                  Icon(Icons.supervised_user_circle),
                  Icon(Icons.access_alarm),
                  Icon(Icons.supervised_user_circle,color: Colors.white,),
                  Icon(Icons.flag),
                  Icon(Icons.access_alarm),
                  Icon(Icons.supervised_user_circle),
                ],
                activeStep: 3,
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
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 22),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.43,
                                    height: 25,
                                    decoration: BoxDecoration(
                                    ),
                                    child: Text(
                                      "Professional Details",
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
                                        width: MediaQuery.of(context).size.width * 0.27,
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
                          padding: EdgeInsets.only(left: 30),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Type",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff7A7A7A)),
                            ),
                          ),
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
                                    hint: type==null?Text("      Select"):Text("      "+type.toString()),
                                    value: jobtype,
                                    icon: Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                    ),
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Padding(
                                          padding:
                                          EdgeInsets.only(left: 30),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                items,
                                                style: const TextStyle(
                                                    color: Color(0xff878383),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        jobtype = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Job",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff7A7A7A)
                              ),
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
                                value: job,
                                hint: g_job==null?Text("     Government/Private"):Text("     "+g_job.toString()),
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                                items: items1.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Padding(
                                      padding:  EdgeInsets.only(left: 30),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            items, style:  TextStyle(
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
                                    job = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Job Categorey",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff7A7A7A)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2,
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
                                hint: Text("      Job Categorey"),
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
                                    });

                                    print(Category.toString()+"&&&&&&&&&");
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Department/Company Name",
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
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          height: 50,
                          width: MediaQuery.of(context).size.width * .9,
                          child: TextFormField(
                            controller: otet_infosystems,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(14.0),
                              border: InputBorder.none,
                              hintText: " OTET Infosystems",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff878383),
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Clerical/technical",
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
                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * .9,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: dropdownvalue2,
                                hint: Text("      Clearical/Technical"),
                                icon: const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                                items: items2.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Row(
                                        children: [
                                          const SizedBox(
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
                                    dropdownvalue2 = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Year of Retirement",
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
                        jobtype=="Retired"?
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          height: 50,
                          width: MediaQuery.of(context).size.width * .9,
                          child: TextFormField(
                            controller: retirement,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4),
                            ],
                            validator: (val) {
                              if (val! == null &&
                                  val.isEmpty &&
                                  val.length == 4) {
                                Fluttertoast.showToast(
                                    msg: "Please enter 6 digit mobile Number");
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(14),
                              border: InputBorder.none,
                              hintText: "Year Of RetireMent",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff878383),
                                  fontSize: 14),
                            ),
                          ),
                        ):
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white54,
                          ),
                          height: 50,
                          width: MediaQuery.of(context).size.width * .9,
                          child: TextFormField(
                            controller: retirement,
                            enabled: false,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4),
                            ],
                            validator: (val) {
                              if (val! == null &&
                                  val.isEmpty &&
                                  val.length == 4) {
                                Fluttertoast.showToast(
                                    msg: "Please enter 6 digit mobile Number");
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(14),
                              border: InputBorder.none,
                              hintText: "Year Of RetireMent",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff878383),
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Row(
                            children: [
                              Text(
                                "Do you also own a business ?",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff7A7A7A)),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            RadioListTile(
                              title: Text("Yes"),
                              value: "Yes",
                              activeColor: Color(0xffFA6393),
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                  print("********"+gender.toString());
                                  if(gender=="Yes")
                                  {
                                    setState(() {
                                      ownBussiness=0;
                                    });
                                  }
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text("No"),
                              value: "No",
                              activeColor: Color(0xffFA6393),
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                  print("********"+gender.toString());
                                  if(gender=="No")
                                    {
                                      setState(() {
                                        ownBussiness=1;
                                      });
                                    }
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 10),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Achievements",
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
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: TextFormField(
                              controller: achivement,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Write about your achievements......',
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff878383),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                                        Navigator.pushReplacement(context, MaterialPageRoute(
                                            builder: (context)=>EducationDetails(
                                              material_status: '',
                                              gender: '',
                                              female: '',
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
                                        colors: [Colors.pink.shade100, Colors.pink.shade300])),
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Center(
                                    child: MaterialButton(
                                      onPressed: () async{
                                            final pref=await SharedPreferences.getInstance();
                                            var userid=pref.getString('user_id');
                                            final pref1=await SharedPreferences.getInstance();
                                            var id=pref1.getString('id');
                                            Map data = {
                                              'user_id': userid.toString(),
                                              'user_f4_jobType': jobtype.toString(),
                                              'job' : job.toString(),
                                              'job_category':Category,
                                              'companyname': otet_infosystems.text.toString(),
                                              'clerical' : dropdownvalue2,
                                              'retirement' : retirement.text.toString(),
                                              'ownbusiness': ownBussiness,
                                              'achivements' : achivement.text.toString(),
                                            };
                                            Uri url = Uri.parse("https://community.creditmywallet.in.net/api/user_professional_details");
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
                                                  builder: (context)=>LandDetails()));
                                            }
                                            else{
                                              Fluttertoast.showToast(msg: succes.toString(),toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM);
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
                    )),
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

