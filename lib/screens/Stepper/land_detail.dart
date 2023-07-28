import 'dart:convert';
import 'package:communityapp/screens/Stepper/income_details.dart';
import 'package:communityapp/screens/Stepper/professional_details.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LandDetails extends StatefulWidget {
  const LandDetails({Key? key}) : super(key: key);
  @override
  State<LandDetails> createState() => _LandDetailsState();
}

class _LandDetailsState extends State<LandDetails> {
  String? OwnLand;
  String family_own = 'Family/Own';
  String area = '0.5 to 1.5 acre';
  String category = 'Cultivated';
  String crop_type = 'FloriCulture';
  String? rent_land;
  String rent_land_type = 'Floriculture';
  var items = [
    'Select',
    'Yes',
    'No'
  ];
  TextEditingController area_cultivation=TextEditingController();
  TextEditingController under_area_cultivation=TextEditingController();
  String? ownland;
  String? rented_land;
  var items1 = [
    'Family/Own',
    'Family',
    'Own',
  ];
  var items2 = [
    '0.5 to 1.5 acre',
  ];
  var items3 = [
    'Cultivated',
  ];
  var items4 = [
    'FloriCulture',
  ];
  var items5 = [
    'Yes',
    'No',
  ];
  var items6 = [
    'Floriculture',
  ];

  String? g_type,g_area,g_cat,g_type_of_crop,are_under,g_rented,g_select,ares_under_cul;
  Future landdetails_form() async{
    final pref=await SharedPreferences.getInstance();
    var get=pref.getString('user_id');
    Map data={
      'user_ids':get.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_form5_data");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    var res=json.decode(response.body)['response'];
    setState(() {
      g_type=res['user_f5_land_type'];
      are_under=res['user_f5_area_cltivton'];
      area_cultivation.text=are_under.toString();
      ares_under_cul=res['user_f5_r_areacltivton'];
      under_area_cultivation.text=ares_under_cul.toString();
      if(g_type!=null)
        {
          family_own=g_type!;
        }
      else
        {
          null;
        }
      g_area=res['user_f5_area'];
      if(g_area!=null)
      {
        area=g_area!;
      }
      else
      {
        null;
      }
      g_cat=res['user_f5_category'];
      if(g_cat!=null)
        {
          category=g_cat!;
        }
      else
        {
          null;
        }
      g_type_of_crop=res['user_f5_crop_type'];
      if(g_type_of_crop!=null)
      {
        crop_type=g_type_of_crop!;
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
    landdetails_form();
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
                  Icon(Icons.supervised_user_circle),
                  Icon(Icons.access_alarm),
                  Icon(Icons.supervised_user_circle),
                  Icon(Icons.flag,color:Colors.white),
                  Icon(Icons.access_alarm),
                  Icon(Icons.supervised_user_circle),
                ],
                activeStep: 4,
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
                    SizedBox(
                      height: 33.45,
                    ),
                    Form(
                        child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 22),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.28,
                                    height: 25,
                                    decoration: BoxDecoration(
                                    ),
                                    child: Text(
                                      "Land Details",
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
                                        width: MediaQuery.of(context).size.width * 0.20,
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
                              "Do you own land?",
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
                                    value: OwnLand,
                                    hint: Text("         Select"),
                                    icon: Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    items: items.map((String items) {
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
                                        OwnLand = newValue!;
                                        if(OwnLand=="Yes")
                                          {
                                            setState(() {
                                              ownland='0';
                                            });
                                          }
                                        else if(OwnLand=="No")
                                          {
                                            setState(() {
                                              ownland='1';
                                            });
                                          }
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
                              "Type",
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
                        OwnLand=="Yes"?
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
                                value: family_own,
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
                                    family_own = newValue!;
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
                                color: Colors.white54),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: family_own,
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
                                onChanged: null,
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
                              "Area",
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
                        OwnLand=="Yes"?
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
                                value: area,
                                icon: const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.arrow_drop_down),
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
                                    area = newValue!;
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
                                color: Colors.white54),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: area,
                                icon: const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: items2.map((String items) {
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
                                onChanged: null,
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
                              "Category",
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
                        OwnLand=="Yes"?
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
                                value: category,
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: items3.map((String items) {
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
                                    category = newValue!;
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
                                color: Colors.white54),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: category,
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: items3.map((String items) {
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
                                onChanged: null,
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
                              "Type of crop",
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
                        OwnLand=="Yes"?
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
                                value: crop_type,
                                icon: const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: items4.map((String items) {
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
                                    crop_type = newValue!;
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
                                color: Colors.white54),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: crop_type,
                                icon: const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: items4.map((String items) {
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
                                onChanged: null,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 10),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "How much area under cultivation ?",
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
                        OwnLand=="Yes"?
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          height: 50,
                          width: MediaQuery.of(context).size.width * .9,

                          child: TextFormField(
                            controller: area_cultivation,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(14.0),
                              border: InputBorder.none,
                              hintText: " 5.5 acre",
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
                            enabled: false,
                            controller: area_cultivation,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(14.0),
                              border: InputBorder.none,
                              hintText: " 5.5 acre",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff878383),
                                  fontSize: 14),
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
                              "Do you have rented land",
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
                        OwnLand=="Yes"?
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
                                value: rent_land,
                                hint:  Text("           Yes/No"),
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: items5.map((String items) {
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
                                    rent_land = newValue!;
                                    if(rent_land=="Yes")
                                      {
                                        setState((){
                                          rented_land='0';
                                        });
                                      }
                                  else if(rent_land=="No")
                                    {
                                      setState((){
                                        rented_land='1';
                                      });
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ):
                        Padding(
                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * .9,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white54),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: rent_land,
                                hint:  Text("           Yes/No"),
                                icon: const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: items5.map((String items) {
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
                                onChanged: null,
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
                              "Select type of crops",
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
                        OwnLand=="Yes"?
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
                                value: rent_land_type,
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: items6.map((String items) {
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
                                    rent_land_type = newValue!;
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
                                color: Colors.white54),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: rent_land_type,
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: items6.map((String items) {
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
                                onChanged: null,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 10),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "How much area under cultivation in rented lands ?",
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
                        OwnLand=="Yes"?
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          height: 50,
                          width: MediaQuery.of(context).size.width * .9,
                          child: TextFormField(
                            controller: under_area_cultivation,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(14.0),
                              border: InputBorder.none,
                              hintText: " 5.5 acre",
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
                            enabled: false,
                            controller: under_area_cultivation,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(14.0),
                              border: InputBorder.none,
                              hintText: " 5.5 acre",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff878383),
                                  fontSize: 14),
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
                                            builder: (context)=>ProfessionalDetails()));
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
                                        if(ownland==null )
                                          {
                                            Fluttertoast.showToast(msg: "Own Land is Empty",toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM);
                                          }
                                        else{
                                          if(OwnLand=="Yes")
                                            {
                                              if(family_own==null)
                                                {
                                                  Fluttertoast.showToast(msg: "Type Family is Empty",toastLength: Toast.LENGTH_LONG,
                                                      gravity: ToastGravity.BOTTOM);
                                                }
                                              else if(area==null)
                                                {
                                                  Fluttertoast.showToast(msg: "Area is Empty",toastLength: Toast.LENGTH_LONG,
                                                      gravity: ToastGravity.BOTTOM);
                                                }
                                              else if(category==null)
                                              {
                                                Fluttertoast.showToast(msg: "Categorey is Empty",toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else if(crop_type==null)
                                              {
                                                Fluttertoast.showToast(msg: "Type of Crop is Empty",toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else if(area_cultivation.text.isEmpty)
                                              {
                                                Fluttertoast.showToast(msg: "Area Under Cultivation is Empty",toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else if(rented_land==null)
                                              {
                                                Fluttertoast.showToast(msg: "Rented Land is Empty",toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else if(rent_land_type==null)
                                              {
                                                Fluttertoast.showToast(msg: "Type of Crops is Empty",toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else if(under_area_cultivation.text.isEmpty)
                                              {
                                                Fluttertoast.showToast(msg: "Area Under Cultivation in Rented is Empty",toastLength: Toast.LENGTH_LONG,
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
                                                  'own_land': ownland,
                                                  'land_type' : family_own,
                                                  'area': area,
                                                  'category' : category,
                                                  'crop_type' : crop_type,
                                                  'area_cltivton': area_cultivation.text.toString(),
                                                  'rent_land' : rented_land,
                                                  'rent_ltype' : rent_land_type,
                                                  'rent_area_cltivton': under_area_cultivation.text.toString(),
                                                };
                                                Uri url = Uri.parse("https://community.creditmywallet.in.net/api/user_land_details");
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
                                                      builder: (context)=>IncomeDetails()));
                                                }
                                                else{
                                                  Fluttertoast.showToast(msg: succes.toString(),toastLength: Toast.LENGTH_LONG,
                                                      gravity: ToastGravity.BOTTOM);
                                                }
                                              }
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
                                                'own_land': ownland,
                                                'land_type' : family_own,
                                                'area': area,
                                                'category' : category,
                                                'crop_type' : crop_type,
                                                'area_cltivton': area_cultivation.text.toString(),
                                                'rent_land' : rented_land,
                                                'rent_ltype' : rent_land_type,
                                                'Rent_area_cltivton': under_area_cultivation.text.toString(),
                                              };
                                              Uri url = Uri.parse("https://community.creditmywallet.in.net/api/user_land_details");
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
                                                    builder: (context)=>IncomeDetails()));
                                              }
                                              else{
                                                Fluttertoast.showToast(msg: succes.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                            }

                                        }


                                       /* if(ownland!=null && family_own!=null && area!=null && category!=null &&
                                            crop_type!=null &&  area_cultivation.text.isNotEmpty && rented_land!=null &&
                                            rent_land_type!=null && under_area_cultivation.text.isNotEmpty)
                                          {
                                            final pref=await SharedPreferences.getInstance();
                                            var userid=pref.getString('user_id');
                                            final pref1=await SharedPreferences.getInstance();
                                            var id=pref1.getString('id');
                                            Map data = {
                                              'user_id': id.toString(),
                                              'user_ids' : userid.toString(),
                                              'own_land': ownland,
                                              'land_type' : family_own,
                                              'area': area,
                                              'category' : category,
                                              'crop_type' : crop_type,
                                              'area_cltivton': area_cultivation.text.toString(),
                                              'rent_land' : rented_land,
                                              'rent_ltype' : rent_land_type,
                                              'Rent_area_cltivton': under_area_cultivation.text.toString(),
                                            };
                                            Uri url = Uri.parse("https://community.creditmywallet.in.net/api/user_land_details");
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
                                                  builder: (context)=>IncomeDetails()));
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
                                          }*/

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

