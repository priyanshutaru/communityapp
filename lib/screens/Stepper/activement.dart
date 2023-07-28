import 'dart:convert';
import 'dart:developer';
import 'package:communityapp/screens/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/Stepper/income_details.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Activement extends StatefulWidget {
  const Activement({Key? key}) : super(key: key);

  @override
  State<Activement> createState() => _ActivementState();
}
class _ActivementState extends State<Activement> {
  String acchivement_category = 'NGO/Political';
  String acchivement_category1 = 'NGO/Political';
  String acchivement_category2 = 'NGO/Political';
  String acchivement_category3 = 'NGO/Political';
  String acchivement_category4 = 'NGO/Political';
  String acchivement_category5 = 'NGO/Political';

  String level_star = 'Vilage/District/State/National';
  String level_star1 = 'Vilage/District/State/National';
  String level_star2 = 'Vilage/District/State/National';
  String level_star3 = 'Vilage/District/State/National';
  String level_star4 = 'Vilage/District/State/National';
  String level_star5 = 'Vilage/District/State/National';

  String vibhag_santha = 'Vibhag';
  String vibhag_santha1 = 'Vibhag';
  String vibhag_santha2 = 'Vibhag';
  String vibhag_santha3 = 'Vibhag';
  String vibhag_santha4 = 'Vibhag';
  String vibhag_santha5 = 'Vibhag';

  String padhamshree_award = 'Padmashree Award';
  String padhamshree_award1 = 'Padmashree Award';
  String padhamshree_award2 = 'Padmashree Award';
  String padhamshree_award3 = 'Padmashree Award';
  String padhamshree_award4 = 'Padmashree Award';
  String padhamshree_award5 = 'Padmashree Award';

  TextEditingController ahivement=TextEditingController();
  TextEditingController sanstha=TextEditingController();
   TextEditingController sanstha1=TextEditingController();
    TextEditingController sanstha2=TextEditingController();
     TextEditingController sanstha3=TextEditingController();
          TextEditingController sanstha4=TextEditingController();
     TextEditingController sanstha5=TextEditingController();



  var items = [
    'NGO/Political',
    'NGO',
    'Political',
  ];

  var items1 = [
    'Vilage/District/State/National',
    'Vilage',
    'District',
    'State',
    'National',
  ];

  String? dob;
  String? form;
  String? to;
  String? dob1;
  String? form1;
  String? to1;
  String? dob2;
  String? form2;
  String? to2;
  String? dob3;
  String? form3;
  String? to3;
  String? dob4;
  String? form4;
  String? to4;
  String? dob5;
  String? form5;
  String? to5;

  List list_Categorey=[];
  List list_level=[];
  List list_vivagh=[];
  List list_position=[];
  List list_yearof=[];
  List list_from=[];
  List list_to=[];

late DateTime _myDateTime;
var items2 = ['Bibhag'];
List getAward = [];
String? award;
Future get_awards() async {
    var url = Uri.parse("https://community.creditmywallet.in.net/api/get_award_position");
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    log(response.body.toString());
    var res = await json.decode(response.body)['response'];
    if (response.statusCode == 200) {
      setState(() {
        getAward = res;
        print("%%%%%%%%%%5555"+getAward.toString());
        // print(msg.toString());
      });
    }
  }

 void initState() {
    super.initState();
    get_awards();
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
                  Icon(Icons.supervised_user_circle),
                  Icon(Icons.access_alarm),
                  Icon(Icons.supervised_user_circle),
                  Icon(Icons.flag),
                  Icon(Icons.access_alarm),
                  Icon(Icons.supervised_user_circle,color: Colors.white,),
                ],
                activeStep: 6,
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
                  child: Column(children: [
                    const SizedBox(
                      height: 33.45,
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
                                          "Achievements",
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
                              height: 22.29,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Achievement Category",
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
                                        value: acchivement_category,
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(Icons.arrow_drop_down),
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
                                                    style: TextStyle(
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
                                            acchivement_category = newValue!;
                                            list_Categorey.add(acchivement_category);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Level/Star*",
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
                                    value: level_star,
                                    icon: Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    items: items1.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 30),
                                          child: Row(
                                            children: [
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
                                        level_star = newValue!;
                                        list_level.add(level_star);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Vivhag/Sanstha",
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
                                height: 50,width: MediaQuery.of(context).size.width*0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextFormField(
                                  controller: sanstha,
                                decoration: InputDecoration(
                                    hintText: 'Vivhag/Sanstha',
                                  hintStyle: TextStyle(fontSize: 14),
                                  contentPadding: EdgeInsets.all(12),
                                  border: OutlineInputBorder(borderSide: BorderSide.none)
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Position/Award Name",
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
                                    value: award,
                                    icon:  Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    items: getAward.map((items) {
                                      return DropdownMenuItem(
                                        value: items['award_name'].toString(),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 30),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                items['award_name'].toString(),
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
                                        award = newValue!;
                                        // list_position.add(padhamshree_award);
                                        get_awards();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Year of Position award",
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
                            InkWell(
                              onTap: () async{
                                _myDateTime= (await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2050),
                                ))!;
                                setState(() {
                                  dob=DateFormat('yyyy').format(_myDateTime);
                                  list_yearof.add(dob);
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
                                        Text("Year Of Position Award"),
                                      ],
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "From",
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
                            SizedBox(
                              height: 5,
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
                                  form=DateFormat('yyyy-MM-dd').format(_myDateTime);
                                  list_from.add(form);
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
                                        form!=null?
                                        Text(form.toString()):
                                        Text("Select Form Date"),
                                      ],
                                    )
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "To",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff7A7A7A)),
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
                                  to=DateFormat('yyyy-MM-dd').format(_myDateTime);
                                  list_to.add(to);
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
                                        Text("Select To Date"),
                                      ],
                                    )
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
                                    padding: EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Achievement Category",
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
                                              value: acchivement_category1,
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(Icons.arrow_drop_down),
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
                                                          style: TextStyle(
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
                                                  acchivement_category1 = newValue!;
                                                  list_Categorey.add(acchivement_category1);
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Level/Star*",
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
                                          value: level_star1,
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(Icons.arrow_drop_down),
                                          ),
                                          items: items1.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 30),
                                                child: Row(
                                                  children: [
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
                                              level_star1 = newValue!;
                                              list_level.add(level_star1);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Vivagh/Sanstha",
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
                                height: 50,width: MediaQuery.of(context).size.width*0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextFormField(
                                  controller: sanstha1,
                                decoration: InputDecoration(
                                    hintText: 'Vivhag/Sanstha',
                                  hintStyle: TextStyle(fontSize: 14),
                                  contentPadding: EdgeInsets.all(12),
                                  border: OutlineInputBorder(borderSide: BorderSide.none)
                                ),
                              ),
                            ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Position/Award Name",
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
                                          value: award,
                                          icon: const Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(Icons.arrow_drop_down),
                                          ),
                                          items: getAward.map((items) {
                                            return DropdownMenuItem(
                                              value: items['award_name'].toString(),
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 30),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      items['award_name'].toString(),
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
                                              award = newValue!;
                                              list_position.add(padhamshree_award1);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Year of Position award",
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
                                  InkWell(
                                    onTap: () async{
                                      _myDateTime= (await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2050),
                                      ))!;
                                      setState(() {
                                        dob1=DateFormat('yyyy').format(_myDateTime);
                                        list_yearof.add(dob1);
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
                                              dob1!=null?
                                              Text(dob1.toString()):
                                              Text("Year Of Position Award"),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "From",
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
                                  SizedBox(
                                    height: 5,
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
                                        form1=DateFormat('yyyy-MM-dd').format(_myDateTime);
                                        list_from.add(form1);
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
                                              form1!=null?
                                              Text(form1.toString()):
                                              Text("Select Form Date"),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "To",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff7A7A7A)),
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
                                        to1=DateFormat('yyyy-MM-dd').format(_myDateTime);
                                        list_to.add(to1);
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
                                              Text("Select To Date"),
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
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Achievement Category",
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
                                              value: acchivement_category2,
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(Icons.arrow_drop_down),
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
                                                          style: TextStyle(
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
                                                  acchivement_category2 = newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Level/Star*",
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
                                          value: level_star2,
                                          icon: const Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(Icons.arrow_drop_down),
                                          ),
                                          items: items1.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 30),
                                                child: Row(
                                                  children: [
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
                                              level_star2 = newValue!;
                                              list_level.add(level_star2);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Vivagh/Sanstha",
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
                                height: 50,width: MediaQuery.of(context).size.width*0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextFormField(
                                  controller: sanstha2,
                                decoration: InputDecoration(
                                    hintText: 'Vivhag/Sanstha',
                                  hintStyle: TextStyle(fontSize: 14),
                                  contentPadding: EdgeInsets.all(12),
                                  border: OutlineInputBorder(borderSide: BorderSide.none)
                                ),
                              ),
                            ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Position/Award Name",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff7A7A7A)),
                                      ),
                                    ),
                                  ),
                                   Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: Text("    Award"),
                                        value: award,
                                        icon: const Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                        items: getAward.map((items) {
                                          return DropdownMenuItem<String>(
                                            value: items['award_name'].toString(),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    items['award_name'],
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
                                            award = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 5,
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 3, bottom: 3),
                                  //   child: Container(
                                  //     height: 50,
                                  //     width: MediaQuery.of(context).size.width * .9,
                                  //     decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(20),
                                  //         color: Colors.white),
                                  //     child: DropdownButtonHideUnderline(
                                  //       child: DropdownButton(
                                  //         value: award,
                                  //         icon: const Padding(
                                  //           padding: EdgeInsets.only(right: 20),
                                  //           child: Icon(Icons.arrow_drop_down),
                                  //         ),
                                  //         items: getAward.map((items) {
                                  //           return DropdownMenuItem(
                                  //        value: items['award_name'].toString(),
                                  //       child: Padding(
                                  //         padding:  EdgeInsets.only(left: 20),
                                  //         child: Text(
                                  //           items['award_name'].toString(),
                                  //           style: TextStyle(color: Colors.black54),
                                  //         ),
                                  //       ),
                                  //           );
                                  //         }).toList(),
                                  //         onChanged: (String ?newValue) {
                                  //           setState(() {
                                  //             award = newValue!;
                                  //             // list_position.add(padhamshree_award2);
                                  //           });
                                  //         },
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Year of Position award",
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
                                  InkWell(
                                    onTap: () async{
                                      _myDateTime= (await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2050),
                                      ))!;
                                      setState(() {
                                        dob2=DateFormat('yyyy').format(_myDateTime);
                                        list_yearof.add(dob2);
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
                                              dob2!=null?
                                              Text(dob2.toString()):
                                              Text("Year Of Position Award"),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "From",
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
                                  SizedBox(
                                    height: 5,
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
                                        form2=DateFormat('yyyy-MM-dd').format(_myDateTime);
                                        list_from.add(form2);
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
                                              form2!=null?
                                              Text(form2.toString()):
                                              Text("Select Form Date"),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "To",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff7A7A7A)),
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
                                        to2=DateFormat('yyyy-MM-dd').format(_myDateTime);
                                        list_to.add(to2);
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
                                              to2!=null?
                                              Text(to2.toString()):
                                              Text("Select To Date"),
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
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Achievement Category",
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
                                              value: acchivement_category3,
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(Icons.arrow_drop_down),
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
                                                          style: TextStyle(
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
                                                  acchivement_category3 = newValue!;
                                                  list_Categorey.add(acchivement_category3);
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Level/Star*",
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
                                          value: level_star3,
                                          icon: const Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(Icons.arrow_drop_down),
                                          ),
                                          items: items1.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 30),
                                                child: Row(
                                                  children: [
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
                                              level_star3 = newValue!;
                                              list_level.add(level_star3);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Vivagh/Sanstha",
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
                                height: 50,width: MediaQuery.of(context).size.width*0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextFormField(
                                  controller: sanstha3,
                                decoration: InputDecoration(
                                    hintText: 'Vivhag/Sanstha',
                                  hintStyle: TextStyle(fontSize: 14),
                                  contentPadding: EdgeInsets.all(12),
                                  border: OutlineInputBorder(borderSide: BorderSide.none)
                                ),
                              ),
                            ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Position/Award Name",
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
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: Text("    Award"),
                                        value: award,
                                        icon: const Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                        items: getAward.map((items) {
                                          return DropdownMenuItem<String>(
                                            value: items['award_name'].toString(),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    items['award_name'],
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
                                            award = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Year of Position award",
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
                                  InkWell(
                                    onTap: () async{
                                      _myDateTime= (await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2050),
                                      ))!;
                                      setState(() {
                                        dob3=DateFormat('yyyy').format(_myDateTime);
                                        list_yearof.add(dob3);
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
                                              dob3!=null?
                                              Text(dob3.toString()):
                                              Text("Year Of Position Award"),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "From",
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
                                  SizedBox(
                                    height: 5,
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
                                        form3=DateFormat('yyyy-MM-dd').format(_myDateTime);
                                        list_from.add(form3);
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
                                              form3!=null?
                                              Text(form3.toString()):
                                              Text("Select Form Date"),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "To",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff7A7A7A)),
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
                                        to3=DateFormat('yyyy-MM-dd').format(_myDateTime);
                                        list_to.add(to3);
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
                                              to3!=null?
                                              Text(to3.toString()):
                                              Text("Select To Date"),
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
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Achievement Category",
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
                                              value: acchivement_category4,
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(Icons.arrow_drop_down),
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
                                                          style: TextStyle(
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
                                                  acchivement_category4 = newValue!;
                                                  list_Categorey.add(acchivement_category4);
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Level/Star*",
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
                                          value: level_star4,
                                          icon: const Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(Icons.arrow_drop_down),
                                          ),
                                          items: items1.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 30),
                                                child: Row(
                                                  children: [
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
                                              level_star4 = newValue!;
                                              list_level.add(level_star4);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Vivagh/Sanstha",
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
                                height: 50,width: MediaQuery.of(context).size.width*0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextFormField(
                                  controller: sanstha4,
                                decoration: InputDecoration(
                                    hintText: 'Vivhag/Sanstha',
                                  hintStyle: TextStyle(fontSize: 14),
                                  contentPadding: EdgeInsets.all(12),
                                  border: OutlineInputBorder(borderSide: BorderSide.none)
                                ),
                              ),
                            ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Position/Award Name",
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
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: Text("    Award"),
                                        value: award,
                                        icon: const Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                        items: getAward.map((items) {
                                          return DropdownMenuItem<String>(
                                            value: items['award_name'].toString(),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    items['award_name'],
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
                                            award = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Year of Position award",
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
                                  InkWell(
                                    onTap: () async{
                                      _myDateTime= (await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2050),
                                      ))!;
                                      setState(() {
                                        dob4=DateFormat('yyyy').format(_myDateTime);
                                        list_yearof.add(dob4);
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
                                              dob4!=null?
                                              Text(dob4.toString()):
                                              Text("Year Of Position Award"),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "From",
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
                                  SizedBox(
                                    height: 5,
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
                                        form4=DateFormat('yyyy-MM-dd').format(_myDateTime);
                                        list_from.add(form4);
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
                                              form4!=null?
                                              Text(form4.toString()):
                                              Text("Select Form Date"),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "To",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff7A7A7A)),
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
                                        to4=DateFormat('yyyy-MM-dd').format(_myDateTime);
                                        list_to.add(to4);
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
                                              to4!=null?
                                              Text(to4.toString()):
                                              Text("Select To Date"),
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
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Achievement Category",
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
                                              value: acchivement_category5,
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(Icons.arrow_drop_down),
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
                                                          style: TextStyle(
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
                                                  acchivement_category5 = newValue!;
                                                  list_Categorey.add(acchivement_category5);
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Level/Star*",
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
                                          value: level_star5,
                                          icon: const Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(Icons.arrow_drop_down),
                                          ),
                                          items: items1.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 30),
                                                child: Row(
                                                  children: [
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
                                              level_star5 = newValue!;
                                              list_level.add(level_star5);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Vivagh/Sanstha",
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
                                height: 50,width: MediaQuery.of(context).size.width*0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextFormField(
                                  controller: sanstha5,
                                decoration: InputDecoration(
                                    hintText: 'Vivhag/Sanstha',
                                  hintStyle: TextStyle(fontSize: 14),
                                  contentPadding: EdgeInsets.all(12),
                                  border: OutlineInputBorder(borderSide: BorderSide.none)
                                ),
                              ),
                            ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Position/Award Name",
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
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: Text("    Award"),
                                        value: award,
                                        icon: const Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                        items: getAward.map((items) {
                                          return DropdownMenuItem<String>(
                                            value: items['award_name'].toString(),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    items['award_name'],
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
                                            award = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Year of Position award",
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
                                  InkWell(
                                    onTap: () async{
                                      _myDateTime= (await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2050),
                                      ))!;
                                      setState(() {
                                        dob5=DateFormat('yyyy').format(_myDateTime);
                                        list_yearof.add(dob5);
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
                                              dob5!=null?
                                              Text(dob5.toString()):
                                              Text("Year Of Position Award"),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "From",
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
                                  SizedBox(
                                    height: 5,
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
                                        form5=DateFormat('yyyy-MM-dd').format(_myDateTime);
                                        list_from.add(form5);
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
                                              form5!=null?
                                              Text(form5.toString()):
                                              Text("Select Form Date"),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "To",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff7A7A7A)),
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
                                        to5=DateFormat('yyyy-MM-dd').format(_myDateTime);
                                        list_to.add(to5);
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
                                              to5!=null?
                                              Text(to5.toString()):
                                              Text("Select To Date"),
                                            ],
                                          )
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
                            SizedBox(height: 10,),
                            // Visibility(
                            //   visible: a_dd5,
                            //   child: Row(
                            //     children: [
                            //       Container(
                            //         height: 45,
                            //         width: MediaQuery.of(context).size.width * 0.5,
                            //       ),
                            //       Container(
                            //         height: 45,
                            //         width: MediaQuery.of(context).size.width * 0.40,
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(30),
                            //             gradient: LinearGradient(
                            //                 begin: Alignment.topLeft,
                            //                 end: Alignment.bottomRight,
                            //                 colors: [
                            //                   Colors.blue.shade100,
                            //                   Colors.blue.shade300
                            //                 ])),
                            //         child: MaterialButton(
                            //           onPressed: (){
                            //           },
                            //           child: Text("Add More",
                            //             style: TextStyle(
                            //                 fontWeight: FontWeight.w700,
                            //                 fontSize: 14,
                            //                 color: Color(0xffFFFFFF)),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30, right: 10),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
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
                                  controller: ahivement,
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
                                            Navigator.pushReplacement(context, MaterialPageRoute(
                                                builder: (context)=>IncomeDetails()));
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
                                        child:MaterialButton(

                                          onPressed: () async{
                                            /*  if(list_Categorey.length!='0' && list_level.length!='0' && list_vivagh.length!='0' && list_position.length!='0' &&
                                                list_yearof.length!='0' && list_from.length!='0' && list_to.length!='0' && ahivement.text.isNotEmpty)
                                              {*/
                                            final pref=await SharedPreferences.getInstance();
                                            var userid=pref.getString('user_id');
                                            final pref1=await SharedPreferences.getInstance();
                                            var id=pref1.getString('id');
                                            Map data = {
                                              'user_id': id.toString(),
                                              'user_ids' : userid.toString(),
                                              'achivement_catg': list_Categorey,
                                              'level_star' : list_level,
                                              "vebahg_sanstha": sanstha.text.toString(),
                                              "awardname": list_position,
                                              "year":list_yearof.toString(),
                                              "fromyear":list_from.toString(),
                                              "toyear": list_to.toString(),
                                              "avivementdesc": ahivement.text.toString(),
                                            };
                                            Uri url = Uri.parse("https://community.creditmywallet.in.net/api/user_achhivement_details");
                                            var body1 = json.encode(data);
                                            var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body1);
                                            var res=json.decode(response.body);
                                            var succes=res["status_message"];
                                            setState(() {
                                              print("######%%%%%%%%%^^^^^^^"+res.toString());
                                              print("*************"+data.toString());
                                            });
                                           if(response.statusCode==200)
                                            {
                                              Fluttertoast.showToast(msg: 'KYC Form Submitted Successfully'.toString(),toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM);
                                              Navigator.pushReplacement(context, MaterialPageRoute(
                                                  builder: (context)=>Dashboard()));
                                            }
                                            else{
                                              Fluttertoast.showToast(msg: succes.toString(),toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM);
                                            }
                                            /*   }
                                            else
                                              {
                                                Fluttertoast.showToast(msg: "Blank Field Not Allow",toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }*/

                                          },
                                          child: Text("Submit",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
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
                  ]
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}

