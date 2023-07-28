import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/membersearch/member_search_profile.dart';
import 'package:communityapp/screens/membersearch/member_search_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemberSearch extends StatefulWidget {
  const MemberSearch({Key? key}) : super(key: key);

  @override
  State<MemberSearch> createState() => _MemberSearchState();
}

class _MemberSearchState extends State<MemberSearch> {

  String dropdownvalue3 = 'Gender';
  String dropdownvalue6 = 'Profession';
  var items3 = [
    'Gender',
    'Male',
    'Female',
  ];
  int? gender_m;

  var items6 = [
    'Profession',
    'Clearical',
    'Technical',
  ];

  TextEditingController first_name=TextEditingController();
  TextEditingController first_name1=TextEditingController();


  String? lastname2;
  String? lastname4;
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

  String? qualifications;
  List get_quali_list=[];
  Future  get_Qualifications() async{
    var url="https://community.creditmywallet.in.net/api/get_qua";
    http.Response response=await http.post(Uri.parse(url));
    var res=jsonDecode(response.body)['details'];
    setState(() {
      print("%%%%%%%%%%%%"+res.toString());
      get_quali_list=res;
      print(get_quali_list.toString()+"%%%%%%%%%%%%%%%%");
    });
  }


  String? membership1;
  List membership=[];
  Future  get_membership() async{
    var url="https://community.creditmywallet.in.net/api/get_membership";
    http.Response response=await http.get(Uri.parse(url));
    var res=jsonDecode(response.body)['response_userRegister'];
    setState(() {
      print("%%%%%%%%%%%%"+res.toString());
      membership=res;
      print(membership.toString()+"%%%%%%%%%%%%%%%%");
    });
  }

  String? location;
  String? district;
  List get_district_list=[];
  Future  get_District() async{
    Map data={
      "state_id":location.toString(),
    };
    var url="https://community.creditmywallet.in.net/api/get_dist";
    var body1=jsonEncode(data);
    http.Response response=await http.post(Uri.parse(url),
        headers: {"Content-Type":"application/json"}, body: body1);
    var res=jsonDecode(response.body)['state'];
    setState(() {
      print("%%%%%FFFFFFFFFFFf%%%%%%%"+res.toString());
      get_district_list=res;
      print(get_district_list.toString()+"%%%%%%%%%%%%%%%%");
    });

  }
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

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC99669',
    };
    var url = Uri.parse("https://community.creditmywallet.in.net/api/get_banner");
    var body=jsonEncode(data);
    final response = await http.post(url,
        headers:{"Content-Type": "application/json"},body: body);
    var res =json.decode(response.body);
    setState(() {
      Banner = res;
      print("%%%%%%%%f,gfgfgjhfgn,j%%5555"+Banner.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    get_banner();
    get_membership();
    get_city();
    getlastname();
    getCurrentShakha();
    get_Qualifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xffEEEEEE),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        elevation: 2,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )
        ),
        title: Text(
          "Member Search",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xff000000),
              fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Banner.length!=0?
            Center(
              child: CarouselSlider(
                options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    viewportFraction: 1),
                items: Banner.map((item) => Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(item),
                              fit: BoxFit.cover)),
                    )))
                    .toList(),
              ),
            ):
            Text(""),
            SizedBox(
              height: 17,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Color(0xffEEEEEE),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Center(
                                child: Text(
                                  "First Name :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xff989595)),
                                )
                            )
                        ),
                        Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width * 0.55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: TextFormField(
                            controller: first_name,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(14.0),
                              border: InputBorder.none,
                              hintText: "Enter your name",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff878383),
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Center(
                                child: Text(
                                  "Last Name :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xff989595)),
                                )
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3, bottom: 3),
                          child: Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width * .55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: lastname4,
                                hint: Text("        Last Name"),
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: lastname.map((item) {
                                  return DropdownMenuItem(
                                    value: item['surname_eng'].toString(),
                                    child: Padding(
                                      padding:  EdgeInsets.only(left: 30),
                                      child: Text(
                                        item['surname_eng'].toString(),
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    lastname4 = newValue!;
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
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.19,
                              child: Text(
                                "Shakha :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color(0xff989595)),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3, bottom: 3),
                          child: Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width * .65,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: drop,
                                hint: Text("        Sakha"),
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: currentShakha.map((item) {
                                  return DropdownMenuItem(
                                    value: item['shakha_id'].toString(),
                                    child: Padding(
                                      padding:  EdgeInsets.only(left: 20),
                                      child: Text(
                                        item['shakha_name'].toString(),
                                        style: TextStyle(
                                            color: Colors.black54,
                                          fontSize: 11
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    drop = newValue! as String?;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.48,
                          height: 40,
                        ),
                         Container(
                            width: 154,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.blue.shade200,
                                      Colors.blue.shade400
                                    ])
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>MemberSearchResult(
                                      name: 'Search',
                                      first_name: first_name.text.toString(),
                                      last_name: lastname4.toString(),
                                      shakha: drop.toString(),
                                      gender: '',
                                      membership: '',
                                      profession: '',
                                      qualification: '',
                                      district: '',

                                    )
                                ));
                              },
                              child: Center(
                                child: Text(
                                  "Search",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 24.9,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 21,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Color(0xffEEEEEE),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color: Color(0xffFF8900),
                                  width:
                                  2.0,
                                )
                            )
                        ),
                        child: Text(
                          "Advance Search",
                          style: TextStyle(
                              color: Color(0xffFF8900),
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Center(
                                child: Text(
                                  "First Name :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xff989595)),
                                ))),
                        Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width * 0.55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: TextFormField(
                            controller: first_name1,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(14.0),
                              border: InputBorder.none,
                              hintText: "Enter your name",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff878383),
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Center(
                                child: Text(
                                  "Last Name :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xff989595)),
                                ))),
                        Padding(
                          padding: EdgeInsets.only(top: 3, bottom: 3),
                          child: Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width * .55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: lastname2,
                                hint: Text("        Last Name"),
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: lastname.map((item) {
                                  return DropdownMenuItem(
                                    value: item['surname_eng'].toString(),
                                    child: Padding(
                                      padding:  EdgeInsets.only(left: 30),
                                      child: Text(
                                        item['surname_eng'].toString(),
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    lastname2 = newValue!;
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
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.19,
                              child: Text(
                                "Shakha :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color(0xff989595)),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3, bottom: 3),
                          child: Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width * .65,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: drop,
                                hint: Text("        Sakha"),
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: currentShakha.map((item) {
                                  return DropdownMenuItem(
                                    value: item['shakha_id'].toString(),
                                    child: Padding(
                                      padding:  EdgeInsets.only(left: 20),
                                      child: Text(
                                        item['shakha_name'].toString(),
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 11
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    drop = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    "Membership Category       :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Color(0xff989595)),
                                  ),
                                )
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3, bottom: 3),
                          child: Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width * .55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: membership1,
                                hint: Text("      Membership"),
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: membership.map((item) {
                                  return DropdownMenuItem(
                                    value: item['sks_id'].toString(),
                                    child: Padding(
                                      padding:  EdgeInsets.only(left: 30),
                                      child: Text(
                                        item['sks_membership'].toString(),
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    setState((){
                                      membership1 = newValue!;
                                    });
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
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Center(
                                child: Text(
                                  "Profession     :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xff989595)),
                                )
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                          child: Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width * .55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: dropdownvalue6,
                                icon: const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                                items: items6.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          items,
                                          style: TextStyle(
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue6 = newValue!;
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
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Center(
                                child: Text(
                                  "Qualification :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xff989595)),
                                )
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3, bottom: 3),
                          child: Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width * .55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: qualifications,
                                hint: Text("      Qualifications"),
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
                                onChanged: (String? newValue) {
                                  setState(() {
                                    setState((){
                                      qualifications = newValue!;
                                    });
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
                    Container(
                      child: Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.23,
                              child: Center(
                                  child: Text(
                                    "State :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Color(0xff989595)),
                                  )
                              )
                          ),
                          Spacer(),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width * 0.67,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: location,
                                  hint: Text("      State"),
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                  items: get_city_list.map((item) {
                                    return DropdownMenuItem(
                                      value: item['state_id'].toString(),
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: 30),
                                        child: Text(
                                          item['state_title'].toString(),
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      setState((){
                                        location = newValue!;
                                        get_District();
                                      });
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
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.23,
                              child: Center(
                                  child: Text(
                                    "District :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Color(0xff989595)),
                                  )
                              )
                          ),
                          Spacer(),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width * 0.67,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: district,
                                  hint: Text("      District"),
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                  items: get_district_list.map((item) {
                                    return DropdownMenuItem(
                                      value: item['district_title'].toString(),
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: 30),
                                        child: Text(
                                          item['district_title'].toString(),
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      setState((){
                                        district = newValue!;
                                      });
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
                      height: 21,
                    ),
                     Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 40,
                          ),
                          Container(
                            width: 215,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.blue.shade200,
                                      Colors.blue.shade400
                                    ]
                                )
                            ),
                            child:  MaterialButton(
                              onPressed: (){
                                if(first_name!=null){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>MemberSearchResult(
                                      name: 'Advance Search',
                                      first_name: first_name1.text.toString(),
                                      last_name: lastname2.toString(),
                                      shakha: drop.toString(),
                                      gender: gender_m.toString(),
                                      membership: membership1.toString(),
                                      profession: dropdownvalue6.toString(),
                                      qualification: qualifications.toString(),
                                      district: district.toString(),
                                    )
                                ));
                                }
                              },
                              child: Center(
                                child: Text(
                                  "Advance Search",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 33,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget textcard(String title, String name) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.35,
              child: Center(
                  child: Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black54),
                  )
              )
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: name,
                  suffixIcon: Icon(Icons.arrow_drop_down_outlined)),
            ),
          )
        ],
      ),
    );
  }
}
