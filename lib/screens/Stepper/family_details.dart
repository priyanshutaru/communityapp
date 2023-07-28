import 'dart:convert';
import 'package:communityapp/screens/Stepper/basic_details.dart';
import 'package:communityapp/screens/Stepper/education_detail.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FamilyDetails extends StatefulWidget {
  String? material_status,gender,female;
  FamilyDetails({
    required this.material_status,
    required this.gender,
    required this.female
  });

  @override
  State<FamilyDetails> createState() => _FamilyDetailsState();
}

class _FamilyDetailsState extends State<FamilyDetails> {
  String dropdownvalue3 = '+91(IN)';
  String dropdownvalue4 = '+91(IN)';
  String dropdownvalue5 = '+91(IN)';
  String dropdownvalue6 = '+91(IN)';
  String? family_type;
  String? son_daughter_bro;
  String? son_daughter_bro1;
  String? son_daughter_bro2;
  String? son_daughter_bro3;
  String? son_daughter_bro4;
  String? son_daughter_bro5;
  String foreign = 'Yes';
  String? foreign1;

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


  TextEditingController husband_name=TextEditingController();
  TextEditingController husband_mobile=TextEditingController();
  TextEditingController husband_email=TextEditingController();
  TextEditingController father_name=TextEditingController();
  TextEditingController father_mobile=TextEditingController();
  TextEditingController father_email=TextEditingController();
  TextEditingController grandfather_name=TextEditingController();
  TextEditingController grandfather_mobile=TextEditingController();
  TextEditingController mother_name=TextEditingController();
  TextEditingController mother_mobile=TextEditingController();
  TextEditingController mother_email=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController middle_name=TextEditingController();
  TextEditingController mobile=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController name1=TextEditingController();
  TextEditingController middle_name1=TextEditingController();
  TextEditingController mobile1=TextEditingController();
  TextEditingController email1=TextEditingController();
  TextEditingController name2=TextEditingController();
  TextEditingController middle_name2=TextEditingController();
  TextEditingController mobile2=TextEditingController();
  TextEditingController email2=TextEditingController();
  TextEditingController name3=TextEditingController();
  TextEditingController middle_name3=TextEditingController();
  TextEditingController mobile3=TextEditingController();
  TextEditingController email3=TextEditingController();
  TextEditingController name4=TextEditingController();
  TextEditingController middle_name4=TextEditingController();
  TextEditingController mobile4=TextEditingController();
  TextEditingController email4=TextEditingController();
  TextEditingController name5=TextEditingController();
  TextEditingController middle_name5=TextEditingController();
  TextEditingController mobile5=TextEditingController();
  TextEditingController email5=TextEditingController();


  String? lastname1;
  String? lastname2;
  String? lastname3;
  String? lastname4;
  String? lastname5;
  String? lastname6;
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


  var items3 = [
    '+91(IN)',
  ];
  var items4 = [
    '+91(IN)',
  ];
  var items5 = [
    '+91(IN)',
  ];
  var items6 = [
    '+91(IN)',
  ];
  var items = [
    'Merital Status',
    'Item 5',
    'Item 8',
    'Item 22',
    'Item 7878',
  ];

  var items7 = [
    'Join Family',
    'Small Family',
  ];
  var items8 = [
    'Son',
    'Daughter',
    'Brother',
    'Sister',
  ];
  var items10 = [
    'Yes',
    'No',
  ];

  List currentShakha=[];
  String? family_details_shakha;
  String? family_details_shakha1;
  String? family_details_shakha2;
  String? family_details_shakha3;
  String? family_details_shakha4;
  String? family_details_shakha5;
  String? hus_shakha,fat_shakha,grand_shakha;
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

  List list_relationship=[];
  List list_name=[];
  List list_middle=[];
  List list_last_name=[];
  List list_shakha1=[];
  List list_mobile=[];
  List list_email=[];


  String? huname,huemail,humobile,hushakha,hu_shakha_name,fname,fmobile,
      femail,grname,grmobile, mname,memail,mmobile,fa_shakha,fa_shakha_name,gr_shakha,
      gr_shakha_name,_family_type,son_daughter;
  String? fa_name1,fa_name2,fa_name3,fa_name4,fa_name5;
  String? fa_middle1,fa_middle2,fa_middle3,fa_middle4,fa_middle5;
  String? fa_email1,fa_email2,fa_email3,fa_email4,fa_email5;
  String? fa_mobile1,fa_mobile2,fa_mobile3,fa_mobile4,fa_mobile5;
  String? fam_ska_id1,fam_ska_id2,fam_ska_name1,fam_ska_name2;
  String? lst_name,lst_id,lst_name1,lst_id1;

  Future family_form() async{
    final pref=await SharedPreferences.getInstance();
    var get=pref.getString('user_id');
    Map data={
      'user_ids':get.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_form2_data");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    var res=json.decode(response.body);
    setState(() {
      hu_shakha_name=res['data']['shakha_city'];
      _family_type=res['data']['user_f2_m_fmlyTyp'];
      if(_family_type!=null)
        {
          family_type=_family_type;
        }
      else
        {
          null;
        }
      fa_shakha_name=res['father_shakha'];
      gr_shakha_name=res['gf_shakha'];
      huname=res['data']['user_f2_hw_name'];
      humobile=res['data']['user_f2_mobile'];
      huemail=res['data']['user_f2_email'];
      hushakha=res['data']['user_f2_sakha_city'];
      if(hushakha!=null)
      {
        hus_shakha=hushakha;
      }
      else
      {
        null;
      }
      fa_shakha=res['data']['user_f2_f_sakha'];
      if(fa_shakha!=null)
      {
        setState((){
          fat_shakha=fa_shakha;
        });
      }
      else
      {
        null;
      }
      gr_shakha=res['data']['user_f2_gf_sakha'];
      if(gr_shakha!=null)
      {
        grand_shakha=gr_shakha;
      }
      else
      {
        null;
      }
      fname=res['data']['user_f2_f_name'];
      fmobile=res['data']['user_f2_f_mobile'];
      femail=res['data']['user_f2_f_email'];
      grname=res['data']['user_f2_gf_name'];
      grmobile=res['data']['user_f2_gf_mobile'];
      mname=res['data']['user_f2_m_name'];
      mmobile=res['data']['user_f2_m_mobile'];
      memail=res['data']['user_f2_m_email'];
      if(huname!=null)
        {
          husband_name.text=huname.toString();
          husband_mobile.text=humobile.toString();
          husband_email.text=huemail.toString();
        }
      else{
        null;
      }
      if(fname!=null)
        {
          father_name.text=fname.toString();
          father_mobile.text=fmobile.toString();
          father_email.text=femail.toString();
          grandfather_name.text=grname.toString();
          grandfather_mobile.text=grmobile.toString();
          mother_name.text=mname.toString();
          mother_mobile.text=mmobile.toString();
          mother_email.text=memail.toString();
        }
      else
        {
          null;
        }
      fa_mobile1=res['user_f2_fmly2_mob'][0];
      setState((){
        mobile.text=fa_mobile1.toString();
      });
      fa_mobile2=res['user_f2_fmly2_mob'][1];
      fa_mobile3=res['user_f2_fmly2_mob'][2];
      fa_mobile4=res['user_f2_fmly2_mob'][3];
      fa_mobile5=res['user_f2_fmly2_mob'][4];
      fa_middle1=res['user_f2_fmly2_mname'][0];
      fa_middle2=res['user_f2_fmly2_mname'][1];
      fa_middle3=res['user_f2_fmly2_mname'][2];
      fa_middle4=res['user_f2_fmly2_mname'][3];
      fa_middle5=res['user_f2_fmly2_mname'][4];

      fa_name1=res['user_f2_fmly2_fname'][0];
      fa_name2=res['user_f2_fmly2_fname'][1];
      fa_name3=res['user_f2_fmly2_fname'][2];
      fa_name4=res['user_f2_fmly2_fname'][3];
      fa_name5=res['user_f2_fmly2_fname'][4];
      fa_email1=res['user_f2_fmly2_email'][0];
      fa_email2=res['user_f2_fmly2_email'][1];
      fa_email3=res['user_f2_fmly2_email'][2];
      fa_email4=res['user_f2_fmly2_email'][3];
      fa_email5=res['user_f2_fmly2_email'][4];
      setState((){
        name.text=fa_name1.toString();
        middle_name.text=fa_middle1.toString();
        email.text=fa_email1.toString();
      });


      son_daughter=res['user_f2_fmly2_sdbs'][0];

      if(son_daughter!=null)
        {
          setState((){
            list_relationship.add(son_daughter);
          });
        }
      else
        {
          null;
        }
      lst_name=res['lastname'][0]['last_name'];
      lst_name1=res['lastname'][1]['last_name'];
      lst_id=res['lastname'][0]['last_id'];
      if(lst_id!=null)
        {
          setState((){
            list_last_name.add(lst_id);
          });
        }
      else
        {
          null;
        }
      lst_id1=res['lastname'][1]['last_id'];
      if(lst_id1!=null)
      {
        setState((){
          lastname2=lst_id1;
        });
      }
      else
      {
        null;
      }
      fam_ska_id1=res['family_shakha'][0]['shakha_id'];
      if(fam_ska_id1!=null)
      {
        setState((){
          list_shakha1.add(fam_ska_id1);
        });
      }
      else
      {
        null;
      }
      fam_ska_id2=res['family_shakha'][1]['shakha_id'];
      if(fam_ska_id2!=null)
      {
        setState((){
          family_details_shakha1=fam_ska_id2;
        });
      }
      else
      {
        null;
      }
      setState((){
        fam_ska_name1=res['family_shakha'][0]['shakha_name'];
        print(fam_ska_name1.toString()+"ffhhfhfhf");
        fam_ska_name2=res['family_shakha'][1]['shakha_name'];
      });



      name1.text=fa_name2.toString();
      middle_name1.text=fa_middle2.toString();
      mobile1.text=fa_mobile2.toString();
      email1.text=fa_email2.toString();
      name2.text=fa_name3.toString();
      middle_name2.text=fa_middle3.toString();
      mobile2.text=fa_mobile3.toString();
      email2.text=fa_email3.toString();
      name3.text=fa_name4.toString();
      middle_name3.text=fa_middle4.toString();
      mobile3.text=fa_mobile4.toString();
      email3.text=fa_email4.toString();
       name4.text=fa_name5.toString();
      middle_name4.text=fa_middle5.toString();
      mobile4.text=fa_mobile5.toString();
      email4.text=fa_email5.toString();
      print(res.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      family_form();
      getCurrentShakha();
      getlastname();
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
                  Icon(Icons.access_alarm),
                  Icon(Icons.supervised_user_circle),
                  Icon(Icons.flag),
                  Icon(Icons.access_alarm),
                  Icon(Icons.supervised_user_circle),
                ],
                activeStep: 1,
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
                        topRight: Radius.circular(30)
                    )
                ),
                color: Color(0xffDED9D9),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      children: [
                        SizedBox(
                          height: 39.12,
                        ),
                        Form(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 0),
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
                                              "Family Details-1",
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
                                  height: 20,
                                ),
                                Column(
                                  children: [
                                    "${widget.material_status}"=="3" && "${widget.material_status}"=="2"?
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white54,
                                      ),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      child: TextFormField(
                                        controller: husband_name,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(14.0),
                                          border: InputBorder.none,
                                          hintText: " Husband/Wife name",
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff878383),
                                              fontSize: 14),
                                          prefixIcon: Container(
                                              padding: EdgeInsets.only(left: 5),
                                              height: 25,
                                              width: 25,
                                              child: Image.asset(
                                                "assets/images/person.png",
                                                height: 15,
                                              )),// pass the hint text parameter here
                                        ),
                                      ),
                                    ):
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      child: TextFormField(
                                        controller: husband_name,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(14.0),
                                          border: InputBorder.none,
                                          hintText: " Husband/Wife name",
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff878383),
                                              fontSize: 14),
                                          prefixIcon: Container(
                                              padding: EdgeInsets.only(left: 5),
                                              height: 25,
                                              width: 25,
                                              child: Image.asset(
                                                "assets/images/person.png",
                                                height: 15,
                                              )),// pass the hint text parameter here
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    "${widget.material_status}"=="3" && "${widget.material_status}"=="2"?
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 3, bottom: 3),
                                            child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context).size.width * .46,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(20),
                                                      bottomLeft: Radius.circular(20)),
                                                  color: Colors.white54),
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 25,
                                                    color: Colors.black,
                                                  ),
                                                  value: dropdownvalue3,
                                                  items: items3.map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(left: 15),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                child: Image.asset(
                                                                  "assets/images/calll.png",
                                                                  height: 22,
                                                                )),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Image.asset(
                                                                    "assets/images/flag.png"),
                                                                SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  items,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff878383),
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      dropdownvalue3 = newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width * 0.44,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                                color: Colors.white54),
                                            child: TextFormField(
                                              enabled: false,
                                              controller: husband_mobile,
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Mobile Number",
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ):
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 3, bottom: 3),
                                            child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context).size.width * .46,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(20),
                                                      bottomLeft: Radius.circular(20)),
                                                  color: Colors.white),
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 25,
                                                    color: Colors.black,
                                                  ),
                                                  value: dropdownvalue3,
                                                  items: items3.map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(left: 15),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                child: Image.asset(
                                                                  "assets/images/calll.png",
                                                                  height: 22,
                                                                )),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Image.asset(
                                                                    "assets/images/flag.png"),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  items,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff878383),
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      dropdownvalue3 = newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width * 0.44,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                                color: Colors.white),
                                            child: TextFormField(
                                              controller: husband_mobile,
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
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    "${widget.material_status}"=="3" && "${widget.material_status}"=="2"?
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white54,
                                      ),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      child: TextFormField(
                                        controller: husband_email,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(14.0),
                                          border: InputBorder.none,
                                          hintText: " Email",
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff878383),
                                              fontSize: 14),
                                          prefixIcon: Container(
                                              padding: EdgeInsets.all(11),
                                              height: 20,
                                              width: 20,
                                              child: Image.asset("assets/images/@.png",)
                                          )
                                        ),
                                      ),
                                    ):
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      child: TextFormField(
                                        controller: husband_email,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(14.0),
                                          border: InputBorder.none,
                                          hintText: " Email",
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff878383),
                                              fontSize: 14),
                                          prefixIcon: Container(
                                              padding: EdgeInsets.all(11),
                                              height: 20,
                                              width: 20,
                                              child: Image.asset("assets/images/@.png",)
                                          )// pass the hint text parameter here
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    "${widget.material_status}"!="3" && "${widget.material_status}"!="2"?
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
                                            value: hus_shakha,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              prefixIcon: Container(
                                                  padding:EdgeInsets.all(13),
                                                  height: 10,
                                                  child: Image.asset(
                                                    "assets/images/native.png",
                                                  )
                                              ),
                                              hintText: hu_shakha_name==null?"Shakha":hu_shakha_name.toString(),
                                            ),
                                            icon: Padding(
                                              padding: EdgeInsets.only(right: 20),
                                              child: Icon(Icons.arrow_drop_down),
                                            ),
                                            items: currentShakha.map((item) {
                                              return DropdownMenuItem(
                                                value: item['shakha_id'].toString(),
                                                child: Padding(
                                                  padding:  EdgeInsets.only(left: 0),
                                                  child: Text(
                                                    item['shakha_name'].toString(),
                                                    style: TextStyle(color: Colors.black54),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                hus_shakha = newValue!;
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
                                        width:MediaQuery.of(context).size.width*0.9,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white54),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField(
                                            value: hus_shakha,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              prefixIcon: Container(
                                                  padding:EdgeInsets.all(13),
                                                  height: 10,
                                                  child: Image.asset(
                                                    "assets/images/native.png",
                                                  )
                                              ),
                                              hintText: hushakha==null?"Shakha":hushakha.toString(),
                                            ),
                                            icon: Padding(
                                              padding: EdgeInsets.only(right: 20),
                                              child: Icon(Icons.arrow_drop_down),
                                            ),
                                            items: currentShakha.map((item) {
                                              return DropdownMenuItem(
                                                value: item['shakha_id'].toString(),
                                                child: Padding(
                                                  padding:  EdgeInsets.only(left: 0),
                                                  child: Text(
                                                    item['shakha_name'].toString(),
                                                    style: TextStyle(color: Colors.black54),
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
                                    "${widget.material_status}"=="1"&&"${widget.gender}"=="1" && "${widget.female}"=="No"?
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white54,
                                      ),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      child: TextFormField(
                                        enabled: false,
                                        controller: father_name,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(20),
                                          border: InputBorder.none,
                                          hintText: "Father Name",
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff878383),
                                              fontSize: 14),
                                          prefixIcon: Container(
                                              padding: EdgeInsets.only(left: 5),
                                              height: 25,
                                              width: 25,
                                              child: Image.asset(
                                                "assets/images/person.png",
                                                height: 15,
                                              )),/// pass the hint text parameter here
                                        ),
                                      ),
                                    ):
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      child: TextFormField(
                                        controller: father_name,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(20),
                                          border: InputBorder.none,
                                          hintText: "Father Name",
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff878383),
                                              fontSize: 14),
                                          prefixIcon: Container(
                                              padding: EdgeInsets.only(left: 5),
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
                                      height: 5,
                                    ),
                                    "${widget.material_status}"=="1"&&"${widget.gender}"=="1"  && "${widget.female}"=="No"?
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 3, bottom: 3),
                                            child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context).size.width * .46,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(20),
                                                      bottomLeft: Radius.circular(20)),
                                                  color: Colors.white54),
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 25,
                                                    color: Colors.black,
                                                  ),
                                                  value: dropdownvalue3,
                                                  items: items3.map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(left: 15),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                child: Image.asset(
                                                                  "assets/images/calll.png",
                                                                  height: 22,
                                                                )),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Image.asset(
                                                                    "assets/images/flag.png"),
                                                                SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  items,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff878383),
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      dropdownvalue3 = newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width * 0.44,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                                color: Colors.white54),
                                            child: TextFormField(
                                              controller: father_mobile,
                                              enabled: false,
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
                                                border: InputBorder.none,
                                                hintText: "Mobile Number",
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ):
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 3, bottom: 3),
                                            child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context).size.width * .46,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(20),
                                                      bottomLeft: Radius.circular(20)),
                                                  color: Colors.white),
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 25,
                                                    color: Colors.black,
                                                  ),
                                                  value: dropdownvalue3,
                                                  items: items3.map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(left: 15),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                child: Image.asset(
                                                                  "assets/images/calll.png",
                                                                  height: 22,
                                                                )),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Image.asset(
                                                                    "assets/images/flag.png"),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  items,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff878383),
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      dropdownvalue3 = newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width * 0.44,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                                color: Colors.white),
                                            child: TextFormField(
                                              controller: father_mobile,
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
                                                border: InputBorder.none,
                                                hintText: "Mobile Number",
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    "${widget.material_status}"=="1"&&"${widget.gender}"=="1" && "${widget.female}"=="No"?
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white54,
                                      ),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      child: TextFormField(
                                        enabled:false,
                                        controller: father_email,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(14.0),
                                          border: InputBorder.none,
                                          hintText: " Email",
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff878383),
                                              fontSize: 14),
                                          prefixIcon:Container(
                                              padding: EdgeInsets.all(11),
                                              height: 20,
                                              width: 20,
                                              child: Image.asset("assets/images/@.png",)
                                          )// pass the hint text parameter here
                                        ),
                                      ),
                                    ):
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width * .9,
                                      child: TextFormField(
                                        controller: father_email,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(14.0),
                                          border: InputBorder.none,
                                          hintText: " Email",
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff878383),
                                              fontSize: 14),
                                          prefixIcon:Container(
                                              padding: EdgeInsets.all(11),
                                              height: 20,
                                              width: 20,
                                              child: Image.asset("assets/images/@.png",)
                                          )// pass the hint text parameter here
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                "${widget.material_status}"=="1"&&"${widget.gender}"=="1" && "${widget.female}"=="No"?
                                Padding(
                                  padding: EdgeInsets.only(top: 3, bottom: 3),
                                  child: Container(
                                    height: 50,
                                    width:MediaQuery.of(context).size.width*0.9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white54),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField(
                                        value: fat_shakha,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Container(
                                              padding:EdgeInsets.all(13),
                                              height: 10,
                                              child: Image.asset(
                                                "assets/images/native.png",
                                              )
                                          ),
                                          hintText: fa_shakha_name==null?"Shakha":fa_shakha_name.toString(),
                                        ),
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                        items: currentShakha.map((item) {
                                          return DropdownMenuItem(
                                            value: item['shakha_id'].toString(),
                                            child: Padding(
                                              padding:  EdgeInsets.only(left: 0),
                                              child: Text(
                                                item['shakha_name'].toString(),
                                                style: TextStyle(color: Colors.black54),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: null,
                                      ),
                                    ),
                                  ),
                                ):
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
                                        value: fat_shakha,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Container(
                                              padding:EdgeInsets.all(13),
                                              height: 10,
                                              child: Image.asset(
                                                "assets/images/native.png",
                                              )
                                          ),
                                          hintText: fa_shakha_name==null?"Shakha":fa_shakha_name.toString(),
                                        ),
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                        items: currentShakha.map((item) {
                                          return DropdownMenuItem(
                                            value: item['shakha_id'].toString(),
                                            child: Padding(
                                              padding:  EdgeInsets.only(left: 0),
                                              child: Text(
                                                item['shakha_name'].toString(),
                                                style: TextStyle(color: Colors.black54),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            fat_shakha = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                "${widget.material_status}"=="1"&&"${widget.gender}"=="1" && "${widget.female}"=="No"?
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white54,
                                  ),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * .9,
                                  child: TextFormField(
                                    enabled: false,
                                    controller: grandfather_name,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(14.0),
                                      border: InputBorder.none,
                                      hintText: " Grand Father Name",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff878383),
                                          fontSize: 14),
                                      prefixIcon: Container(
                                          padding: EdgeInsets.only(left: 5),
                                          height: 25,
                                          width: 25,
                                          child: Image.asset(
                                            "assets/images/person.png",
                                            height: 15,
                                          )),
                                    ),
                                  ),
                                ):
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * .9,
                                  child: TextFormField(
                                    controller: grandfather_name,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(14.0),
                                      border: InputBorder.none,
                                      hintText: " Grand Father Name",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff878383),
                                          fontSize: 14),
                                      prefixIcon: Container(
                                          padding: EdgeInsets.only(left: 5),
                                          height: 25,
                                          width: 25,
                                          child: Image.asset(
                                            "assets/images/person.png",
                                            height: 15,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                "${widget.material_status}"=="1"&&"${widget.gender}"=="1" && "${widget.female}"=="No"?
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 3, bottom: 3),
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width * .46,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft: Radius.circular(20)),
                                              color: Colors.white54),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                size: 25,
                                                color: Colors.black,
                                              ),
                                              value: dropdownvalue3,
                                              items: items3.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 15),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            child: Image.asset(
                                                              "assets/images/calll.png",
                                                              height: 22,
                                                            )),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                                "assets/images/flag.png"),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              items,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff878383),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                            ),
                                                          ],
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
                                      Container(
                                        height: 50,
                                        width: MediaQuery.of(context).size.width * 0.44,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                            color: Colors.white54),
                                        child: TextFormField(
                                          controller: grandfather_mobile,
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
                                            border: InputBorder.none,
                                            hintText: "Mobile Number",
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ):
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 3, bottom: 3),
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width * .46,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft: Radius.circular(20)),
                                              color: Colors.white),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                size: 25,
                                                color: Colors.black,
                                              ),
                                              value: dropdownvalue3,
                                              items: items3.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 15),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            child: Image.asset(
                                                              "assets/images/calll.png",
                                                              height: 22,
                                                            )),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                                "assets/images/flag.png"),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              items,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff878383),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownvalue3 = newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: MediaQuery.of(context).size.width * 0.44,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                            color: Colors.white),
                                        child: TextFormField(
                                          controller: grandfather_mobile,
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
                                            border: InputBorder.none,
                                            hintText: "Mobile Number",
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                "${widget.material_status}"=="1"&&"${widget.gender}"=="1" && "${widget.female}"=="No"?
                                Padding(
                                  padding: EdgeInsets.only(top: 3, bottom: 3),
                                  child: Container(
                                    height: 50,
                                    width:MediaQuery.of(context).size.width*0.9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white54),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField(
                                        value: grand_shakha,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Container(
                                              padding:EdgeInsets.all(13),
                                              height: 10,
                                              child: Image.asset(
                                                "assets/images/native.png",
                                              )
                                          ),
                                          hintText: "Shakha",
                                        ),
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                        items: currentShakha.map((item) {
                                          return DropdownMenuItem(
                                            value: item['shakha_id'].toString(),
                                            child: Padding(
                                              padding:  EdgeInsets.only(left: 0),
                                              child: Text(
                                                item['shakha_name'].toString(),
                                                style: TextStyle(color: Colors.black54),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: null,
                                      ),
                                    ),
                                  ),
                                ):
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
                                        value: grand_shakha,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Container(
                                              padding:EdgeInsets.all(13),
                                              height: 10,
                                              child: Image.asset(
                                                "assets/images/native.png",
                                              )
                                          ),
                                          hintText: gr_shakha_name==null?"Shakha":gr_shakha_name.toString(),
                                        ),
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                        items: currentShakha.map((item) {
                                          return DropdownMenuItem(
                                            value: item['shakha_id'].toString(),
                                            child: Padding(
                                              padding:  EdgeInsets.only(left: 0),
                                              child: Text(
                                                item['shakha_name'].toString(),
                                                style: TextStyle(color: Colors.black54),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            grand_shakha = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                "${widget.material_status}"=="1"&&"${widget.gender}"=="1" && "${widget.female}"=="No"?
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white54,
                                  ),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * .9,
                                  child: TextFormField(
                                    controller: mother_name,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(14.0),
                                      border: InputBorder.none,
                                      hintText: " Mother Name",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff878383),
                                          fontSize: 14),
                                      prefixIcon: Container(
                                          padding: EdgeInsets.only(left: 5),
                                          height: 25,
                                          width: 25,
                                          child: Image.asset(
                                            "assets/images/person.png",
                                            height: 15,
                                          )),
                                    ),
                                  ),
                                ):
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * .9,
                                  child: TextFormField(
                                    controller: mother_name,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(14.0),
                                      border: InputBorder.none,
                                      hintText: " Mother Name",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff878383),
                                          fontSize: 14),
                                      prefixIcon: Container(
                                          padding: EdgeInsets.only(left: 5),
                                          height: 25,
                                          width: 25,
                                          child: Image.asset(
                                            "assets/images/person.png",
                                            height: 15,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                "${widget.material_status}"=="1"&&"${widget.gender}"=="1" && "${widget.female}"=="No"?
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 3, bottom: 3),
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width * .46,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft: Radius.circular(20)),
                                              color: Colors.white54),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                size: 25,
                                                color: Colors.black,
                                              ),
                                              value: dropdownvalue3,
                                              items: items3.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 15),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            child: Image.asset(
                                                              "assets/images/calll.png",
                                                              height: 22,
                                                            )),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                                "assets/images/flag.png"),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              items,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff878383),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownvalue3 = newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: MediaQuery.of(context).size.width * 0.44,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                            color: Colors.white54),
                                        child: TextFormField(
                                          controller: mother_mobile,
                                          enabled: false,
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
                                            border: InputBorder.none,
                                            hintText: "Mobile Number",
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ):
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 3, bottom: 3),
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width * .46,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft: Radius.circular(20)),
                                              color: Colors.white),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                size: 25,
                                                color: Colors.black,
                                              ),
                                              value: dropdownvalue3,
                                              items: items3.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 15),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            child: Image.asset(
                                                              "assets/images/calll.png",
                                                              height: 22,
                                                            )),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                                "assets/images/flag.png"),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              items,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff878383),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownvalue3 = newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: MediaQuery.of(context).size.width * 0.44,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                            color: Colors.white),
                                        child: TextFormField(
                                          controller: mother_mobile,
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
                                            border: InputBorder.none,
                                            hintText: "Mobile Number",
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                "${widget.material_status}"=="1"&&"${widget.gender}"=="1" && "${widget.female}"=="No"?
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white54,
                                  ),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * .9,
                                  child: TextFormField(
                                    controller: mother_email,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(14.0),
                                      border: InputBorder.none,
                                      hintText: " Email",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff878383),
                                          fontSize: 14),
                                      prefixIcon:Container(
                                          padding: EdgeInsets.all(11),
                                          height: 20,
                                          width: 20,
                                          child: Image.asset("assets/images/@.png",)
                                      )
                                    ),
                                  ),
                                ):
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * .9,
                                  child: TextFormField(
                                    controller: mother_email,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(14.0),
                                      border: InputBorder.none,
                                      hintText: " Email",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff878383),
                                          fontSize: 14),
                                      prefixIcon: Container(
                                          padding: EdgeInsets.all(11),
                                          height: 20,
                                          width: 20,
                                          child: Image.asset("assets/images/@.png",)
                                      )
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
                                      child: DropdownButtonFormField(
                                        value: family_type,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Container(
                                              padding:EdgeInsets.all(13),
                                              height: 10,
                                              child: Image.asset(
                                                "assets/images/familytype.png",
                                              )
                                          ),
                                          hintText: _family_type==null?"Family Type":_family_type.toString(),
                                        ),
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                        items: items7.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 0),
                                              child:Text(
                                                    items,
                                                    style: TextStyle(
                                                        color: Color(0xff878383),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            family_type = newValue!;
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
                                            width: MediaQuery.of(context).size.width * 0.35,
                                            height: 25,
                                            decoration: BoxDecoration(
                                            ),
                                            child: Text(
                                              "Family Details-2",
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
                                  height: 20,
                                ),
                                "${widget.material_status}"=="1" && "${widget.gender}"=="1"?
                                Padding(
                                  padding: EdgeInsets.only(top: 3, bottom: 3),
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white54),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Container(
                                              padding:EdgeInsets.all(13),
                                              height: 10,
                                              child: Image.asset(
                                                "assets/images/sdbs.png",
                                              )
                                          ),
                                          hintText: "Son/Daughter/Brother/Sister",
                                        ),
                                        value: son_daughter_bro,
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                        items: items8.map((String items) {
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
                                        onChanged: null,
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
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Container(
                                              padding:EdgeInsets.all(13),
                                              height: 10,
                                              child: Image.asset(
                                                "assets/images/sdbs.png",
                                              )
                                          ),
                                          hintText: son_daughter==null?"Son/Daughter/Brother/Sister":son_daughter.toString(),
                                        ),
                                        value: son_daughter_bro,
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                        items: items8.map((String items) {
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
                                            son_daughter_bro = newValue!;
                                            list_relationship.add(son_daughter_bro);
                                          });
                                        },
                                      ),
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
                                    controller: name,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(14.0),
                                      border: InputBorder.none,
                                      hintText: " First Name",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff878383),
                                          fontSize: 14),
                                      prefixIcon: Container(
                                          padding: EdgeInsets.only(left: 5),
                                          height: 25,
                                          width: 25,
                                          child: Image.asset(
                                            "assets/images/person.png",
                                            height: 15,
                                          )),
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
                                    controller: middle_name,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(14.0),
                                      border: InputBorder.none,
                                      hintText: " Middle Name",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff878383),
                                          fontSize: 14),
                                      prefixIcon: Container(
                                          padding: EdgeInsets.only(left: 5),
                                          height: 25,
                                          width: 25,
                                          child: Image.asset(
                                            "assets/images/person.png",
                                            height: 15,
                                          )),
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
                                      child: DropdownButtonFormField(
                                        value: lastname1,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Container(
                                              padding:EdgeInsets.all(13),
                                              height: 10,
                                              child: Image.asset(
                                                "assets/images/person.png",
                                              )
                                          ),
                                          hintText: lst_name==null?"Last Name":lst_name.toString(),
                                        ),
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                        items: lastname.map((item) {
                                          return DropdownMenuItem(
                                            value: item['surname_id'].toString(),
                                            child: Text(item["surname_eng"].toString(),
                                                    style: TextStyle(
                                                        color: Color(0xff878383),
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.w400),
                                                  ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            lastname1 = newValue!;
                                            list_last_name.add(lastname1);
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
                                  padding: EdgeInsets.only(top: 3, bottom: 3),
                                  child: Container(
                                    height: 50,
                                    width:MediaQuery.of(context).size.width*0.9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField(
                                        value: family_details_shakha,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Container(
                                              padding:EdgeInsets.all(13),
                                              height: 10,
                                              child: Image.asset(
                                                "assets/images/native.png",
                                              )
                                          ),
                                          hintText: fam_ska_name1==null?"Shakha":fam_ska_name1.toString(),
                                        ),
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                        items: currentShakha.map((item) {
                                          return DropdownMenuItem(
                                            value: item['shakha_id'].toString(),
                                            child: Padding(
                                              padding:  EdgeInsets.only(left: 0),
                                              child: Text(
                                                item['shakha_name'].toString(),
                                                style: TextStyle(color: Colors.black54),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            family_details_shakha = newValue!;
                                            list_shakha1.add(family_details_shakha);
                                          });
                                        },
                                      ),
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
                                    color: Colors.white,
                                  ),
                                  child: TextFormField(
                                    controller: mobile,
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
                                      contentPadding: EdgeInsets.all(16.0),
                                      border: InputBorder.none,
                                      hintText: "Mobile Number",
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                        prefixIcon: Container(
                                            padding: EdgeInsets.all(12),
                                            height: 25,
                                            width: 25,
                                            child: Image.asset(
                                              "assets/images/calll.png",
                                              height: 15,
                                            )),
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
                                    controller: email,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(14.0),
                                      border: InputBorder.none,
                                      hintText: " Email",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff878383),
                                          fontSize: 14),
                                      prefixIcon: Container(
                                          padding: EdgeInsets.all(11),
                                          height: 20,
                                          width: 20,
                                          child: Image.asset("assets/images/@.png",)
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
                                        padding: EdgeInsets.only(top: 3, bottom: 3),
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width * .9,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  prefixIcon: Container(
                                                      padding:EdgeInsets.all(13),
                                                      height: 10,
                                                      child: Image.asset(
                                                        "assets/images/sdbs.png",
                                                      )
                                                  ),
                                                  hintText: "Son/Daughter/Brother/Sister",
                                                ),
                                              value: son_daughter_bro1,
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 30,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              items: items8.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items,
                                                          style: TextStyle(
                                                              color: Color(0xff878383),
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w400),
                                                        ),
                                                  
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  son_daughter_bro1 = newValue!;
                                                  list_relationship.add(son_daughter_bro1);
                                                });
                                              },
                                            ),
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
                                          controller: name1,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: " First Name",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.only(left: 5),
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/person.png",
                                                  height: 15,
                                                )),
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
                                          controller: middle_name1,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: " Middle Name",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.only(left: 5),
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/person.png",
                                                  height: 15,
                                                )),
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
                                            child: DropdownButtonFormField(
                                              value: lastname2,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                    padding:EdgeInsets.all(13),
                                                    height: 10,
                                                    child: Image.asset(
                                                      "assets/images/person.png",
                                                    )
                                                ),
                                                hintText: lst_name1!=null?"Last Name":lst_name1.toString(),
                                              ),
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(Icons.arrow_drop_down),
                                              ),
                                              items: lastname.map((item) {
                                                return DropdownMenuItem(
                                                  value: item['surname_id'].toString(),
                                                  child: Text(item["surname_eng"].toString(),
                                                          style: TextStyle(
                                                              color: Color(0xff878383),
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w400),
                                                        ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  lastname2 = newValue!;
                                                  list_last_name.add(lastname2);
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
                                        padding: EdgeInsets.only(top: 3, bottom: 3),
                                        child: Container(
                                          height: 50,
                                          width:MediaQuery.of(context).size.width*0.9,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButtonFormField(
                                              value: family_details_shakha1,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                    padding:EdgeInsets.all(13),
                                                    height: 10,
                                                    child: Image.asset(
                                                      "assets/images/native.png",
                                                    )
                                                ),
                                                hintText: fam_ska_name2==null?"Shakha":fam_ska_name2.toString(),
                                              ),
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(Icons.arrow_drop_down),
                                              ),
                                              items: currentShakha.map((item) {
                                                return DropdownMenuItem(
                                                  value: item['shakha_id'].toString(),
                                                  child: Padding(
                                                    padding:  EdgeInsets.only(left: 0),
                                                    child: Text(
                                                      item['shakha_name'].toString(),
                                                      style: TextStyle(color: Colors.black54),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  family_details_shakha1 = newValue!;
                                                  list_shakha1.add(family_details_shakha1);
                                                });
                                              },
                                            ),
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
                                          color: Colors.white,
                                        ),
                                        child: TextFormField(
                                          controller: mobile1,
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
                                            contentPadding: EdgeInsets.all(16.0),
                                            border: InputBorder.none,
                                            hintText: "Mobile Number",
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400
                                            ),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.all(12),
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/calll.png",
                                                  height: 15,
                                                )),
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
                                          controller: email1,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: " Email",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.all(11),
                                                height: 20,
                                                width: 20,
                                                child: Image.asset("assets/images/@.png",)
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
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                    padding:EdgeInsets.all(13),
                                                    height: 10,
                                                    child: Image.asset(
                                                      "assets/images/sdbs.png",
                                                    )
                                                ),
                                                hintText: "Son/Daughter/Brother/Sister",
                                              ),
                                              value: son_daughter_bro2,
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 30,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              items: items8.map((String items) {
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
                                                  son_daughter_bro2 = newValue!;
                                                  list_relationship.add(son_daughter_bro2);
                                                });
                                              },
                                            ),
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
                                          controller: name2,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: " First Name",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.only(left: 5),
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/person.png",
                                                  height: 15,
                                                )),
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
                                          controller: middle_name2,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: " Middle Name",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.only(left: 5),
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/person.png",
                                                  height: 15,
                                                )),
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
                                            child: DropdownButtonFormField(
                                              value: lastname3,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                    padding:EdgeInsets.all(13),
                                                    height: 10,
                                                    child: Image.asset(
                                                      "assets/images/person.png",
                                                    )
                                                ),
                                                hintText: "Last Name",
                                              ),
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(Icons.arrow_drop_down),
                                              ),
                                              items: lastname.map((item) {
                                                return DropdownMenuItem(
                                                  value: item['surname_id'].toString(),
                                                  child: Text(item["surname_eng"].toString(),
                                                          style: TextStyle(
                                                              color: Color(0xff878383),
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w400),
                                                        ),

                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  lastname3 = newValue!;
                                                  list_last_name.add(lastname3);
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
                                        padding: EdgeInsets.only(top: 3, bottom: 3),
                                        child: Container(
                                          height: 50,
                                          width:MediaQuery.of(context).size.width*0.9,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButtonFormField(
                                              value: family_details_shakha2,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                    padding:EdgeInsets.all(13),
                                                    height: 10,
                                                    child: Image.asset(
                                                      "assets/images/native.png",
                                                    )
                                                ),
                                                hintText: "Shakha",
                                              ),
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(Icons.arrow_drop_down),
                                              ),
                                              items: currentShakha.map((item) {
                                                return DropdownMenuItem(
                                                  value: item['shakha_id'].toString(),
                                                  child: Padding(
                                                    padding:  EdgeInsets.only(left: 0),
                                                    child: Text(
                                                      item['shakha_name'].toString(),
                                                      style: TextStyle(color: Colors.black54),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  family_details_shakha2 = newValue!;
                                                  list_shakha1.add(family_details_shakha2);
                                                });
                                              },
                                            ),
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
                                          color: Colors.white,
                                        ),
                                        child: TextFormField(
                                          controller: mobile2,
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
                                            contentPadding: EdgeInsets.all(16.0),
                                            border: InputBorder.none,
                                            hintText: "Mobile Number",
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400
                                            ),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.all(12),
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/calll.png",
                                                  height: 15,
                                                )),
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
                                          controller: email2,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: " Email",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon:Container(
                                                padding: EdgeInsets.all(11),
                                                height: 20,
                                                width: 20,
                                                child: Image.asset("assets/images/@.png",)
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
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                    padding:EdgeInsets.all(13),
                                                    height: 10,
                                                    child: Image.asset(
                                                      "assets/images/sdbs.png",
                                                    )
                                                ),
                                                hintText: "Son/Daughter/Brother/Sister",
                                              ),
                                              value: son_daughter_bro3,
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 30,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              items: items8.map((String items) {
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
                                                  son_daughter_bro3 = newValue!;
                                                  list_relationship.add(son_daughter_bro3);
                                                });
                                              },
                                            ),
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
                                          controller: name3,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: " First Name",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon:Container(
                                                padding: EdgeInsets.only(left: 5),
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/person.png",
                                                  height: 15,
                                                )),
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
                                          controller: middle_name3,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: " Middle Name",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.only(left: 5),
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/person.png",
                                                  height: 15,
                                                )),
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
                                            child: DropdownButtonFormField(
                                              value: lastname4,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                    padding:EdgeInsets.all(13),
                                                    height: 10,
                                                    child: Image.asset(
                                                      "assets/images/person.png",
                                                    )
                                                ),
                                                hintText: "Last Name",
                                              ),
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(Icons.arrow_drop_down),
                                              ),
                                              items: lastname.map((item) {
                                                return DropdownMenuItem(
                                                  value: item['surname_id'].toString(),
                                                  child: Text(item["surname_eng"].toString(),
                                                          style: TextStyle(
                                                              color: Color(0xff878383),
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w400),
                                                        ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  lastname4 = newValue!;
                                                  list_last_name.add(lastname4);
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
                                        padding: EdgeInsets.only(top: 3, bottom: 3),
                                        child: Container(
                                          height: 50,
                                          width:MediaQuery.of(context).size.width*0.9,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButtonFormField(
                                              value: family_details_shakha3,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                    padding:EdgeInsets.all(13),
                                                    height: 10,
                                                    child: Image.asset(
                                                      "assets/images/native.png",
                                                    )
                                                ),
                                                hintText: "Shakha",
                                              ),
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(Icons.arrow_drop_down),
                                              ),
                                              items: currentShakha.map((item) {
                                                return DropdownMenuItem(
                                                  value: item['shakha_id'].toString(),
                                                  child: Padding(
                                                    padding:  EdgeInsets.only(left: 0),
                                                    child: Text(
                                                      item['shakha_name'].toString(),
                                                      style: TextStyle(color: Colors.black54),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  family_details_shakha3 = newValue!;
                                                  list_shakha1.add(family_details_shakha3);
                                                });
                                              },
                                            ),
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
                                          color: Colors.white,
                                        ),
                                        child: TextFormField(
                                          controller: mobile3,
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
                                            contentPadding: EdgeInsets.all(16.0),
                                            border: InputBorder.none,
                                            hintText: "Mobile Number",
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400
                                            ),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.all(12),
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/calll.png",
                                                  height: 15,
                                                )),
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
                                          controller: email3,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: " Email",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.all(11),
                                                height: 20,
                                                width: 20,
                                                child: Image.asset("assets/images/@.png",)
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
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                    padding:EdgeInsets.all(13),
                                                    height: 10,
                                                    child: Image.asset(
                                                      "assets/images/sdbs.png",
                                                    )
                                                ),
                                                hintText: "Son/Daughter/Brother/Sister",
                                              ),
                                              value: son_daughter_bro4,
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 30,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              items: items8.map((String items) {
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
                                                  son_daughter_bro4 = newValue!;
                                                  list_relationship.add(son_daughter_bro4);
                                                });
                                              },
                                            ),
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
                                          controller: name4,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: " First Name",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.only(left: 5),
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/person.png",
                                                  height: 15,
                                                )),
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
                                          controller: middle_name4,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: " Middle Name",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.only(left: 5),
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/person.png",
                                                  height: 15,
                                                )),
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
                                            child: DropdownButtonFormField(
                                              value: lastname5,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                    padding:EdgeInsets.all(13),
                                                    height: 10,
                                                    child: Image.asset(
                                                      "assets/images/person.png",
                                                    )
                                                ),
                                                hintText: "Last Name",
                                              ),
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(Icons.arrow_drop_down),
                                              ),
                                              items: lastname.map((item) {
                                                return DropdownMenuItem(
                                                  value: item['surname_id'].toString(),
                                                  child: Text(item["surname_eng"].toString(),
                                                          style: TextStyle(
                                                              color: Color(0xff878383),
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w400),
                                                        ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  lastname5 = newValue!;
                                                  list_last_name.add(lastname5);
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
                                        padding: EdgeInsets.only(top: 3, bottom: 3),
                                        child: Container(
                                          height: 50,
                                          width:MediaQuery.of(context).size.width*0.9,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButtonFormField(
                                              value: family_details_shakha4,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                    padding:EdgeInsets.all(13),
                                                    height: 10,
                                                    child: Image.asset(
                                                      "assets/images/native.png",
                                                    )
                                                ),
                                                hintText: "Shakha",
                                              ),
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(Icons.arrow_drop_down),
                                              ),
                                              items: currentShakha.map((item) {
                                                return DropdownMenuItem(
                                                  value: item['shakha_id'].toString(),
                                                  child: Padding(
                                                    padding:  EdgeInsets.only(left: 0),
                                                    child: Text(
                                                      item['shakha_name'].toString(),
                                                      style: TextStyle(color: Colors.black54),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  family_details_shakha4 = newValue!;
                                                  list_shakha1.add(family_details_shakha4);
                                                });
                                              },
                                            ),
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
                                          color: Colors.white,
                                        ),
                                        child: TextFormField(
                                          controller: mobile4,
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
                                            contentPadding: EdgeInsets.all(16.0),
                                            border: InputBorder.none,
                                            hintText: "Mobile Number",
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400
                                            ),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.all(12),
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/calll.png",
                                                  height: 15,
                                                )),
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
                                          controller: email4,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: " Email",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon:Container(
                                                padding: EdgeInsets.all(11),
                                                height: 20,
                                                width: 20,
                                                child: Image.asset("assets/images/@.png",)
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
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                    padding:EdgeInsets.all(13),
                                                    height: 10,
                                                    child: Image.asset(
                                                      "assets/images/sdbs.png",
                                                    )
                                                ),
                                                hintText: "Son/Daughter/Brother/Sister",
                                              ),
                                              value: son_daughter_bro5,
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 30,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              items: items8.map((String items) {
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
                                                  son_daughter_bro5 = newValue!;
                                                  list_relationship.add(son_daughter_bro5);
                                                });
                                              },
                                            ),
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
                                          controller: name5,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: " First Name",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.only(left: 5),
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/person.png",
                                                  height: 15,
                                                )),
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
                                          controller: middle_name5,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: " Middle Name",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.only(left: 5),
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/person.png",
                                                  height: 15,
                                                )),
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
                                            child: DropdownButtonFormField(
                                              value: lastname6,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                    padding:EdgeInsets.all(13),
                                                    height: 10,
                                                    child: Image.asset(
                                                      "assets/images/person.png",
                                                    )
                                                ),
                                                hintText: "Last Name",
                                              ),
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(Icons.arrow_drop_down),
                                              ),
                                              items: lastname.map((item) {
                                                return DropdownMenuItem(
                                                  value: item['surname_id'].toString(),
                                                  child: Text(item["surname_eng"].toString(),
                                                          style: TextStyle(
                                                              color: Color(0xff878383),
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w400),
                                                        ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  lastname6 = newValue!;
                                                  list_last_name.add(lastname6);
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
                                        padding: EdgeInsets.only(top: 3, bottom: 3),
                                        child: Container(
                                          height: 50,
                                          width:MediaQuery.of(context).size.width*0.9,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButtonFormField(
                                              value: family_details_shakha5,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                    padding:EdgeInsets.all(13),
                                                    height: 10,
                                                    child: Image.asset(
                                                      "assets/images/native.png",
                                                    )
                                                ),
                                                hintText: "Shakha",
                                              ),
                                              icon: Padding(
                                                padding: EdgeInsets.only(right: 20),
                                                child: Icon(Icons.arrow_drop_down),
                                              ),
                                              items: currentShakha.map((item) {
                                                return DropdownMenuItem(
                                                  value: item['shakha_id'].toString(),
                                                  child: Padding(
                                                    padding:  EdgeInsets.only(left: 0),
                                                    child: Text(
                                                      item['shakha_name'].toString(),
                                                      style: TextStyle(color: Colors.black54),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  family_details_shakha5 = newValue!;
                                                  list_shakha1.add(family_details_shakha5);
                                                });
                                              },
                                            ),
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
                                          color: Colors.white,
                                        ),
                                        child: TextFormField(
                                          controller: mobile5,
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
                                            contentPadding: EdgeInsets.all(16.0),
                                            border: InputBorder.none,
                                            hintText: "Mobile Number",
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400
                                            ),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.all(12),
                                                height: 25,
                                                width: 25,
                                                child: Image.asset(
                                                  "assets/images/calll.png",
                                                  height: 15,
                                                )),
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
                                          controller: email5,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(14.0),
                                            border: InputBorder.none,
                                            hintText: " Email",
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff878383),
                                                fontSize: 14),
                                            prefixIcon: Container(
                                                padding: EdgeInsets.all(11),
                                                height: 20,
                                                width: 20,
                                                child: Image.asset("assets/images/@.png",)
                                            )
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 19,
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
                                  height: 31,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "If any son/daughter residing in foreign",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff7A7A7A)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
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
                                        value: foreign,
                                        hint: Text("Select"),
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                        items: items10.map((String items) {
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
                                            foreign = newValue!;
                                            if(foreign=="Yes")
                                            {
                                              foreign1='1';
                                            }
                                            else{
                                              foreign1='2';
                                            }
                                          });
                                        },
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
                                                    builder: (context)=>BasicDetail()));

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
                                                list_name.add(name.text);
                                                list_name.add(name1.text);
                                                list_name.add(name2.text);
                                                list_name.add(name3.text);
                                                list_name.add(name4.text);
                                                list_name.add(name5.text.toString());
                                                list_middle.add(middle_name.text.toString());
                                                list_middle.add(middle_name1.text.toString());
                                                list_middle.add(middle_name2.text.toString());
                                                list_middle.add(middle_name3.text.toString());
                                                list_middle.add(middle_name4.text.toString());
                                                list_middle.add(middle_name5.text.toString());
                                                list_mobile.add(mobile.text.toString());
                                                list_mobile.add(mobile1.text.toString());
                                                list_mobile.add(mobile2.text.toString());
                                                list_mobile.add(mobile3.text.toString());
                                                list_mobile.add(mobile4.text.toString());
                                                list_mobile.add(mobile5.text.toString());
                                                list_email.add(email.text.toString());
                                                list_email.add(email1.text.toString());
                                                list_email.add(email2.text.toString());
                                                list_email.add(email3.text.toString());
                                                list_email.add(email4.text.toString());
                                                list_email.add(email5.text.toString());
                                             /*   if("${widget.material_status}"=="1" && "${widget.gender}"=="1")
                                                  {
                                                    if(husband_name.text.isEmpty)
                                                      {
                                                        Fluttertoast.showToast(msg: "Husband/Wife Name is Empty"
                                                            ,toastLength: Toast.LENGTH_LONG,
                                                            gravity: ToastGravity.BOTTOM);
                                                      }
                                                    else if(husband_mobile.text.isEmpty)
                                                      {
                                                        Fluttertoast.showToast(msg: "Husband/Wife Mobile Number is Empty"
                                                            ,toastLength: Toast.LENGTH_LONG,
                                                            gravity: ToastGravity.BOTTOM);
                                                      }
                                                    else if(husband_email.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Husband/Wife Email is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(hus_shakha==null)
                                                    {
                                                      Fluttertoast.showToast(msg: "Husband/Wife Shakha is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(family_type==null)
                                                    {
                                                      Fluttertoast.showToast(msg: "Family Type is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_relationship.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "RelationShip is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_name.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Name is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_middle.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Middle Name is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if( list_last_name.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Last Name is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_shakha1.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Shakha is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_mobile.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Mobile No is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_email.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Email is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(foreign1==null)
                                                    {
                                                      Fluttertoast.showToast(msg: "Foreign is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else
                                                    {
                                                      final pref=await SharedPreferences.getInstance();
                                                      var userid=pref.getString('user_id');
                                                      final pref1=await SharedPreferences.getInstance();
                                                      var id=pref1.getString('id');
                                                      setState(() {
                                                        print(userid.toString());
                                                      });
                                                      Map data = {
                                                        'user_id': id.toString(),
                                                        'user_ids' : userid.toString(),
                                                        'hus_wife_name': husband_name.text.toString(),
                                                        'mobile' : husband_mobile.text.toString(),
                                                        'email': husband_email.text.toString(),
                                                        'shakah_city' : hus_shakha,
                                                        'f_name': father_name.text.toString(),
                                                        'f_mobile' : father_mobile.text.toString(),
                                                        'f_email': father_email.text.toString(),
                                                        'f_shakha' : fat_shakha,
                                                        'gf_name': grandfather_name.text.toString(),
                                                        'gf_mobile' : grandfather_mobile.text.toString(),
                                                        'gf_shakha': grand_shakha,
                                                        'mother_name' : mother_name.text.toString(),
                                                        'mother_mobile': mother_mobile.text.toString(),
                                                        'mother_email' : mother_email.text.toString(),
                                                        'mother_ftpye': family_type,
                                                        'family2_sdbs' : list_relationship,
                                                        'family2_first_name': list_name,
                                                        'family2_middle_name' : list_middle,
                                                        'family2_last_name': list_last_name,
                                                        'family2_shakha' : list_shakha1,
                                                        'family2_mobile': list_mobile,
                                                        'family2_email' : list_email,
                                                        'in_forigen': foreign1,
                                                      };
                                                      setState((){
                                                        print(data.toString()+"jndfbmfgjmdfg");
                                                      });
                                                      Uri url = Uri.parse("https://community.creditmywallet.in.net/api/user_family_details");
                                                      var body1 = json.encode(data);
                                                      var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body1 );
                                                      var res=json.decode(response.body);
                                                      var succes=res["status_message"];
                                                      setState(() {
                                                        print("######%%%%%%%%%^^^^^^^"+res.toString());
                                                        print("*************"+data.toString());
                                                      });
                                                      if(res["status_message"]=="Inserted Successfully")
                                                      {
                                                        Fluttertoast.showToast(msg: succes.toString(),
                                                            toastLength: Toast.LENGTH_LONG,
                                                            gravity: ToastGravity.BOTTOM);
                                                        Navigator.push(context, MaterialPageRoute(
                                                            builder: (context)=>EducationDetails(
                                                              material_status: "${widget.material_status}",
                                                              gender: "${widget.gender}",
                                                                female: "${widget.female}"
                                                            )));
                                                      }
                                                      else{
                                                        Fluttertoast.showToast(msg: succes.toString(),
                                                            toastLength: Toast.LENGTH_LONG,
                                                            gravity: ToastGravity.BOTTOM);
                                                      }
                                                    }
                                                  }
                                                else if("${widget.material_status}"=="3")
                                                  {
                                                    if(father_name.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Father Name is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(father_mobile.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Father Mobile No is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(father_email.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Father Email is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(fat_shakha==null)
                                                    {
                                                      Fluttertoast.showToast(msg: "Father Shakha is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(grandfather_name.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Grand Father Name is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(grandfather_mobile.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Grand Father Mobile is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(grand_shakha==null)
                                                    {
                                                      Fluttertoast.showToast(msg: "Grand Father Shakha is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(mother_name.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Mother Name is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(mother_mobile.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Mother Mobile is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(mother_email.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Mother Email is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(family_type==null)
                                                    {
                                                      Fluttertoast.showToast(msg: "Family Type is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_relationship.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "RelationShip is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_name.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Name is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_middle.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Middle Name is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if( list_last_name.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Last Name is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_shakha1.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Shakha is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_mobile.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Mobile No is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_email.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Email is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(foreign1==null)
                                                    {
                                                      Fluttertoast.showToast(msg: "Foreign is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else
                                                    {
                                                      final pref=await SharedPreferences.getInstance();
                                                      var userid=pref.getString('user_id');
                                                      final pref1=await SharedPreferences.getInstance();
                                                      var id=pref1.getString('id');
                                                      setState(() {
                                                        print(userid.toString());
                                                      });
                                                      Map data = {
                                                        'user_id': id.toString(),
                                                        'user_ids' : userid.toString(),
                                                        'hus_wife_name': husband_name.text.toString(),
                                                        'mobile' : husband_mobile.text.toString(),
                                                        'email': husband_email.text.toString(),
                                                        'shakah_city' : hus_shakha,
                                                        'f_name': father_name.text.toString(),
                                                        'f_mobile' : father_mobile.text.toString(),
                                                        'f_email': father_email.text.toString(),
                                                        'f_shakha' : fat_shakha,
                                                        'gf_name': grandfather_name.text.toString(),
                                                        'gf_mobile' : grandfather_mobile.text.toString(),
                                                        'gf_shakha': grand_shakha,
                                                        'mother_name' : mother_name.text.toString(),
                                                        'mother_mobile': mother_mobile.text.toString(),
                                                        'mother_email' : mother_email.text.toString(),
                                                        'mother_ftpye': family_type,
                                                        'family2_sdbs' : list_relationship,
                                                        'family2_first_name': list_name,
                                                        'family2_middle_name' : list_middle,
                                                        'family2_last_name': list_last_name,
                                                        'family2_shakha' : list_shakha1,
                                                        'family2_mobile': list_mobile,
                                                        'family2_email' : list_email,
                                                        'in_forigen': foreign1,
                                                      };
                                                      setState((){
                                                        print(data.toString()+"jndfbmfgjmdfg");
                                                      });
                                                      Uri url = Uri.parse("https://community.creditmywallet.in.net/api/user_family_details");
                                                      var body1 = json.encode(data);
                                                      var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body1 );
                                                      var res=json.decode(response.body);
                                                      var succes=res["status_message"];
                                                      setState(() {
                                                        print("######%%%%%%%%%^^^^^^^"+res.toString());
                                                        print("*************"+data.toString());
                                                      });
                                                      if(res["status_message"]=="Inserted Successfully")
                                                      {
                                                        Fluttertoast.showToast(msg: succes.toString(),
                                                            toastLength: Toast.LENGTH_LONG,
                                                            gravity: ToastGravity.BOTTOM);
                                                        Navigator.push(context, MaterialPageRoute(
                                                            builder: (context)=>EducationDetails(
                                                              material_status: "${widget.material_status}",
                                                              gender: "${widget.gender}",
                                                                female: "${widget.female}",
                                                            )));
                                                      }
                                                      else{
                                                        Fluttertoast.showToast(msg: succes.toString(),
                                                            toastLength: Toast.LENGTH_LONG,
                                                            gravity: ToastGravity.BOTTOM);
                                                      }
                                                    }
                                                  }
                                                else
                                                  {
                                                    if(husband_name.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Husband/Wife Name is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(husband_mobile.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Husband/Wife Mobile Number is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(husband_email.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Husband/Wife Email is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(hus_shakha==null)
                                                    {
                                                      Fluttertoast.showToast(msg: "Husband/Wife Shakha is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(father_name.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Father Name is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(father_mobile.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Father Mobile No is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(father_email.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Father Email is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(fat_shakha==null)
                                                    {
                                                      Fluttertoast.showToast(msg: "Father Shakha is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(grandfather_name.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Grand Father Name is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(grandfather_mobile.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Grand Father Mobile is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(grand_shakha==null)
                                                    {
                                                      Fluttertoast.showToast(msg: "Grand Father Shakha is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(mother_name.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Mother Name is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(mother_mobile.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Mother Mobile is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(mother_email.text.isEmpty)
                                                    {
                                                      Fluttertoast.showToast(msg: "Mother Email is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(family_type==null)
                                                    {
                                                      Fluttertoast.showToast(msg: "Family Type is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_relationship.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "RelationShip is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_name.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Name is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_middle.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Middle Name is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if( list_last_name.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Last Name is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_shakha1.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Shakha is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_mobile.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Mobile No is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(list_email.length==0)
                                                    {
                                                      Fluttertoast.showToast(msg: "Email is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else if(foreign1==null)
                                                    {
                                                      Fluttertoast.showToast(msg: "Foreign is Empty"
                                                          ,toastLength: Toast.LENGTH_LONG,
                                                          gravity: ToastGravity.BOTTOM);
                                                    }
                                                    else
                                                    {*/
                                                      final pref=await SharedPreferences.getInstance();
                                                      var userid=pref.getString('user_id');
                                                      final pref1=await SharedPreferences.getInstance();
                                                      var id=pref1.getString('id');
                                                      setState(() {
                                                        print(userid.toString());
                                                      });
                                                      Map data = {
                                                        'user_id': id.toString(),
                                                        'user_ids' : userid.toString(),
                                                        'hus_wife_name': husband_name.text.toString(),
                                                        'mobile' : husband_mobile.text.toString(),
                                                        'email': husband_email.text.toString(),
                                                        'shakah_city' : hus_shakha,
                                                        'f_name': father_name.text.toString(),
                                                        'f_mobile' : father_mobile.text.toString(),
                                                        'f_email': father_email.text.toString(),
                                                        'f_shakha' : fat_shakha,
                                                        'gf_name': grandfather_name.text.toString(),
                                                        'gf_mobile' : grandfather_mobile.text.toString(),
                                                        'gf_shakha': grand_shakha,
                                                        'mother_name' : mother_name.text.toString(),
                                                        'mother_mobile': mother_mobile.text.toString(),
                                                        'mother_email' : mother_email.text.toString(),
                                                        'mother_ftpye': family_type,
                                                        'family2_sdbs' : list_relationship,
                                                        'family2_first_name': list_name,
                                                        'family2_middle_name' : list_middle,
                                                        'family2_last_name': list_last_name,
                                                        'family2_shakha' : list_shakha1,
                                                        'family2_mobile': list_mobile,
                                                        'family2_email' : list_email,
                                                        'in_forigen': foreign1,
                                                      };
                                                      setState((){
                                                        print(data.toString()+"jndfbmfgjmdfg");
                                                      });
                                                      Uri url = Uri.parse("https://community.creditmywallet.in.net/api/user_family_details");
                                                      var body1 = json.encode(data);
                                                      var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body1 );
                                                      var res=json.decode(response.body);
                                                      var succes=res["status_message"];
                                                      setState(() {
                                                        print("######%%%%%%%%%^^^^^^^"+res.toString());
                                                        print("*************"+data.toString());
                                                      });
                                                      if(res["status_message"]=="Inserted Successfully")
                                                      {
                                                        Fluttertoast.showToast(msg: succes.toString(),
                                                            toastLength: Toast.LENGTH_LONG,
                                                            gravity: ToastGravity.BOTTOM);
                                                        Navigator.push(context, MaterialPageRoute(
                                                            builder: (context)=>EducationDetails(
                                                              material_status: "${widget.material_status}",
                                                              gender: "${widget.gender}",
                                                                female: "${widget.female}"
                                                            )));
                                                      }
                                                      else{
                                                        Fluttertoast.showToast(msg: succes.toString(),
                                                            toastLength: Toast.LENGTH_LONG,
                                                            gravity: ToastGravity.BOTTOM);
                                                      }
                                                  /*  }
                                                  }
*/
                                              },
                                              highlightColor: Colors.green,
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

