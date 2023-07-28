import 'dart:convert';
import 'dart:developer';
import 'package:communityapp/screens/Stepper/activement.dart';
import 'package:communityapp/screens/Stepper/land_detail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeDetails extends StatefulWidget {
  const IncomeDetails({Key? key}) : super(key: key);

  @override
  State<IncomeDetails> createState() => _IncomeDetailsState();
}

class _IncomeDetailsState extends State<IncomeDetails> {

  // List of items in our dropdown menu
  // var items = [
  //   '2-4 lakh',
  //   'Item 5',
  //   'Item 8',
  //   'Item 22',
  //   'Item 7878',
  // ];
  // var items1 = [
  //   'Job',
  //   'Business',
  //   'Pension',
  //   'Student',
  //   'Retired'
  // ];

  String? income_range,source_of_inc;

  Future income_detail_form() async{
    final pref=await SharedPreferences.getInstance();
    var get=pref.getString('user_id');
    Map data={
      // 'user_ids': "MU/17/A0009"
      'user_ids':get.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_form6_data");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    log(response.body.toString());
    var res=json.decode(response.body)['data'];
    setState(() {
      income_range=res['user_f6_anual_income'];
      if(income_range==null)
        {
          dropdownvalue=income_range!;
        }
      else{
        null;
      }
      source_of_inc=res['user_f6_source'];
      if(source_of_inc==null)
      {
        dropdownvalue1=source_of_inc;
      }
      else{
        null;
      }
    });
  }
  List get_income_range = [];
  String ? dropdownvalue;
  Future get_income_rang() async {
    var url = Uri.parse("https://community.creditmywallet.in.net/api/get_income_range");
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    log(response.body.toString());
    var res = await json.decode(response.body)['response'];
    print("Income Range" + response.body);
     String msg;
    if (response.statusCode == 200) {
      setState(() {
        // msg = res['status_message'];
         get_income_range = res;
        print("%%%%%%%%%%5555"+get_income_range.toString());
        // print(msg.toString());
      });
    }
  }

  Future get_income_source() async {
    var url = Uri.parse("https://community.creditmywallet.in.net/api/get_income_source");
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    log(response.body.toString());
    var res = await json.decode(response.body)['response'];
    print("Income Range" + response.body);
    if (response.statusCode == 200) {
      setState(() {
        // msg = res['status_message'];
        get_income_sourc = res;
        print("%%%%%%%%%%5555"+get_income_range.toString());
        // print(msg.toString());
      });
    }
  }

  List get_income_sourc = [];
  String ? dropdownvalue1;
  // Future get_income_source() async {
  //   var url = Uri.parse("https://community.creditmywallet.in.net/api/get_income_source");
  //   final response = await http.get(url,headers:{"Content-Type": "application/json"});
  //       log(response.body.toString());
  //   var res = await json.decode(response.body)['response'];
  //   print("Income Source" + response.body);
  //   String msg;
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       // msg = res['status_message'];
  //       get_income_sourc =res ;
  //       print("%%%%%%%%%%5555"+get_income_range.toString());
  //       // print(msg.toString());
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    income_detail_form();
    get_income_rang();
    get_income_source();
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
                  Icon(Icons.supervised_user_circle),
                  Icon(Icons.flag),
                  Icon(Icons.access_alarm,color:Colors.white),
                  Icon(Icons.supervised_user_circle),
                ],
                activeStep: 5,
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
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                color: Color(0xffDED9D9),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(children: [
                    const SizedBox(
                      height: 45,
                    ),
                    Form(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 27),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 46,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.33,
                                    height: 25,
                                    decoration: BoxDecoration(
                                    ),
                                    child: Text(
                                      "Income Details",
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
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Approx annual income ranges",
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
                            // Column(
                            //   children: [
                            //     Padding(
                            //       padding: EdgeInsets.only(top: 3, bottom: 3),
                            //       child: Container(
                            //         height: 50,
                            //         width: MediaQuery.of(context).size.width * .9,
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(20),
                            //             color: Colors.white),
                            //         child: DropdownButtonHideUnderline(
                            //           child: DropdownButton(
                            //             value: dropdownvalue,
                            //             icon: Padding(
                            //               padding: EdgeInsets.only(right: 20),
                            //               child: Icon(Icons.arrow_drop_down),
                            //             ),
                            //             items: get_income_range.map((items) {
                            //               return DropdownMenuItem(
                            //                 value: items,
                            //                 child: Padding(
                            //                   padding: const EdgeInsets.only(
                            //                       left: 30),
                            //                   child: Row(
                            //                     children: [
                            //                       SizedBox(
                            //                         width: 10,
                            //                       ),
                            //                       Text(
                            //                         items,
                            //                         style: const TextStyle(
                            //                             color:
                            //                                 Color(0xff878383),
                            //                             fontSize: 14,
                            //                             fontWeight:
                            //                                 FontWeight.w400),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //               );
                            //             }).toList(),
                            //             onChanged: (String? newValue) {
                            //               setState(() {
                            //                 dropdownvalue = newValue!;
                            //               });
                            //             },
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
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
                                    value: dropdownvalue,
                                    hint: Text("        Income Range"),
                                    icon: Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    items: get_income_range.map((item) {
                                      return DropdownMenuItem(
                                        value: item['end_range'].toString(),
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 20),
                                          child: Text(
                                            item['start_range']+'-'+item['end_range'].toString(),
                                            style: TextStyle(color: Colors.black54),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                        get_income_rang();
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
                                child: Text(
                                  "Source of Incomes",
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
                                        hint: Text("    Source of Income"),
                                        value: dropdownvalue1,
                                        icon: const Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                        items: get_income_sourc.map((items) {
                                          return DropdownMenuItem<String>(
                                            value: items['income_source'].toString(),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    items['income_source'],
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff878383),
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
                                            dropdownvalue1 = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context)=>LandDetails()));
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
                                       if(dropdownvalue!=null && dropdownvalue1!=null)
                                         {
                                            final pref=await SharedPreferences.getInstance();
                                            var userid=pref.getString('user_id');
                                            final pref1=await SharedPreferences.getInstance();
                                            var id=pref1.getString('id');
                                            Map data = {
                                              'user_id': id.toString(),
                                              'user_ids' : userid.toString(),
                                              'anualincome': dropdownvalue,
                                              'source' : dropdownvalue1,
                                            };
                                            Uri url = Uri.parse("https://community.creditmywallet.in.net/api/user_income_details");
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
                                              Navigator.pushReplacement(context, MaterialPageRoute(
                                                  builder: (context)=>Activement()));
                                            }
                                            else{
                                              Fluttertoast.showToast(msg: succes.toString(),toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM);
                                            }
                                         }
                                        else
                                          {
                                            Fluttertoast.showToast(msg: "Blank Field Not Allow",toastLength: Toast.LENGTH_LONG,
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
                    )
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ),
            ],
          )
      ),
    );
  }
}
