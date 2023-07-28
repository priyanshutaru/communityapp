import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Blood/my_blood_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestBlood extends StatefulWidget {
  const RequestBlood({Key? key}) : super(key: key);

  @override
  State<RequestBlood> createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC56219',
    };
    var url = Uri.parse("https://community.creditmywallet.in.net/api/get_banner");
    var body=jsonEncode(data);
    final response = await http.post(url,
        headers:{"Content-Type": "application/json"},body: body);
    var res =json.decode(response.body);
    setState(() {
      Banner = res;
    });
  }
  String dropdownvalue = 'Unit';

  var items = ['Unit','1', '2', '3', '4', '5', '6', '7', "8"];
  String dropdownvalue1 = 'Location';
  var items1 = [
    'Location',
    'Lucknow',
    'Barabanki',
    'Kanpur',
    'Pryagraj',
  ];
  var color=Colors.white70;
  var color1=Colors.white70;
  var color2=Colors.white70;
  var color3=Colors.white70;
  var color4=Colors.white70;
  var color5=Colors.white70;
  var color6=Colors.white70;
  var color7=Colors.white70;





  var c1olor=Color(0xff6B6B6B);
  var c2olor=Color(0xff6B6B6B);
  var c3olor=Color(0xff6B6B6B);
  var c4olor=Color(0xff6B6B6B);
  var c5olor=Color(0xff6B6B6B);
  var c6olor=Color(0xff6B6B6B);
  var c7olor=Color(0xff6B6B6B);
  var c8olor=Color(0xff6B6B6B);


  String? blood_group;
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

  @override
  void initState() {
    super.initState();
    get_banner();
    get_city();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 254, 255),
      appBar: AppBar(
          toolbarHeight: 60,
          title: Text(
            "Request For Blood",
            style: TextStyle(
                color: Color(0xff000000),
                fontWeight: FontWeight.w700,
                fontSize: 16),
          ),
          backgroundColor: Color.fromARGB(255, 252, 254, 255),
          elevation: 0,
          leading:  IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      color=Color(0xffFA6393);
                      color1=Colors.white70;
                      color2=Colors.white70;
                      color3=Colors.white70;
                      color4=Colors.white70;
                      color5=Colors.white70;
                      color6=Colors.white70;
                      color7=Colors.white70;

                      c1olor=Colors.white;
                      c2olor=Color(0xff6B6B6B);
                      c3olor=Color(0xff6B6B6B);
                      c4olor=Color(0xff6B6B6B);
                      c5olor=Color(0xff6B6B6B);
                      c6olor=Color(0xff6B6B6B);
                      c7olor=Color(0xff6B6B6B);
                      c8olor=Color(0xff6B6B6B);


                      blood_group="O +";
                    });
                  },
                  onDoubleTap: (){
                    setState(() {
                      color=Colors.white70;
                    });
                  },
                  child: Container(
                    height: 110,
                    width: 75,
                    child: Card(
                      color: color,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 35.06,
                              width: 25,
                              child: Image.asset("assets/images/blooddrop.png")),
                          SizedBox(
                            height: 10.94,
                          ),
                          Text(
                            "O Positive",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: c1olor,
                                fontSize: 12),
                          ),
                          SizedBox(
                            height: 10.94,
                          ),
                          Text(
                            "('O +')",
                            style:  TextStyle(
                                fontWeight: FontWeight.w400,
                                color: c1olor,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ),


                SizedBox(
                  width: 11,
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      color=Colors.white70;
                      color1=Color(0xffFA6393);
                      color2=Colors.white70;
                      color3=Colors.white70;
                      color4=Colors.white70;
                      color5=Colors.white70;
                      color6=Colors.white70;
                      color7=Colors.white70;

                      c1olor=Color(0xff6B6B6B);
                      c2olor=Colors.white;
                      c3olor=Color(0xff6B6B6B);
                      c4olor=Color(0xff6B6B6B);
                      c5olor=Color(0xff6B6B6B);
                      c6olor=Color(0xff6B6B6B);
                      c7olor=Color(0xff6B6B6B);
                      c8olor=Color(0xff6B6B6B);
                      blood_group="A +";
                    });
                  },
                  onDoubleTap: (){
                    setState(() {
                      color1=Colors.white70;
                    });
                  },
                  child: Container(
                    height: 110,
                    width: 75,
                    child: Card(
                      color: color1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 35.06,
                              width: 25,
                              child: Image.asset("assets/images/blooddrop.png")),
                          SizedBox(
                            height: 10.94,
                          ),
                          Text(
                            "A Positive",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: c2olor,
                                fontSize: 12),
                          ),
                          SizedBox(
                            height: 10.94,
                          ),
                          Text(
                            "('A +')",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: c2olor,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 11,
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      color2=Color(0xffFA6393);
                      color=Colors.white70;
                      color1=Colors.white70;
                      color3=Colors.white70;
                      color4=Colors.white70;
                      color5=Colors.white70;
                      color6=Colors.white70;
                      color7=Colors.white70;

                      c1olor=Color(0xff6B6B6B);
                      c2olor=Color(0xff6B6B6B);
                      c3olor=Colors.white;
                      c4olor=Color(0xff6B6B6B);
                      c5olor=Color(0xff6B6B6B);
                      c6olor=Color(0xff6B6B6B);
                      c7olor=Color(0xff6B6B6B);
                      c8olor=Color(0xff6B6B6B);

                      blood_group="B +";
                    });
                  },
                  onDoubleTap: (){
                    setState(() {
                      color2=Colors.white70;
                    });
                  },
                  child: Container(
                    height: 110,
                    width: 75,
                    child: Card(
                      color: color2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 35.06,
                              width: 25,
                              child: Image.asset("assets/images/blooddrop.png")),
                          SizedBox(
                            height: 10.94,
                          ),
                          Text(
                            "B Positive",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: c3olor,
                                fontSize: 12),
                          ),
                          SizedBox(
                            height: 10.94,
                          ),
                          Text(
                            "('B +')",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: c3olor,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 11,
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      color3=Color(0xffFA6393);
                      color=Colors.white70;
                      color1=Colors.white70;
                      color2=Colors.white70;
                      color4=Colors.white70;
                      color5=Colors.white70;
                      color6=Colors.white70;
                      color7=Colors.white70;

                      c1olor=Color(0xff6B6B6B);
                      c2olor=Color(0xff6B6B6B);
                      c3olor=Color(0xff6B6B6B);
                      c4olor=Colors.white;
                      c5olor=Color(0xff6B6B6B);
                      c6olor=Color(0xff6B6B6B);
                      c7olor=Color(0xff6B6B6B);
                      c8olor=Color(0xff6B6B6B);

                      blood_group="AB +";
                    });
                  },
                  onDoubleTap: (){
                    setState(() {
                      color3=Colors.white70;
                    });
                  },
                  child: Container(
                    height: 110,
                    width: 75,
                    child: Card(
                      color: color3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 35.06,
                              width: 25,
                              child: Image.asset("assets/images/blooddrop.png")),
                          SizedBox(
                            height: 10.94,
                          ),
                          Text(
                            "AB Positive",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: c4olor,
                                fontSize: 12),
                          ),
                          SizedBox(
                            height: 10.94,
                          ),
                          Text(
                            "('AB +')",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: c4olor,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 11,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      color4=Color(0xffFA6393);
                      color=Colors.white70;
                      color1=Colors.white70;
                      color2=Colors.white70;
                      color3=Colors.white70;
                      color5=Colors.white70;
                      color6=Colors.white70;
                      color7=Colors.white70;

                      c1olor=Color(0xff6B6B6B);
                      c2olor=Color(0xff6B6B6B);
                      c3olor=Color(0xff6B6B6B);
                      c4olor=Color(0xff6B6B6B);
                      c5olor=Colors.white;
                      c6olor=Color(0xff6B6B6B);
                      c7olor=Color(0xff6B6B6B);
                      c8olor=Color(0xff6B6B6B);

                      blood_group="O -";
                    });
                  },
                  onDoubleTap: (){
                    setState(() {
                      color4=Colors.white70;
                    });
                  },
                  child: Container(
                    height: 110,
                    width: 75,
                    child: Card(
                      color: color4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 35.06,
                              width: 25,
                              child: Image.asset("assets/images/blooddrop.png")),
                          SizedBox(
                            height: 10.94,
                          ),
                          Text(
                            "O Negative",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: c5olor,
                                fontSize: 12),
                          ),
                          const SizedBox(
                            height: 10.94,
                          ),
                          Text(
                            "('O -')",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: c5olor,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ),


                SizedBox(
                  width: 11,
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      color5=Color(0xffFA6393);
                      color=Colors.white70;
                      color1=Colors.white70;
                      color2=Colors.white70;
                      color4=Colors.white70;
                      color3=Colors.white70;
                      color6=Colors.white70;
                      color7=Colors.white70;

                      c1olor=Color(0xff6B6B6B);
                      c2olor=Color(0xff6B6B6B);
                      c3olor=Color(0xff6B6B6B);
                      c4olor=Color(0xff6B6B6B);
                      c5olor=Color(0xff6B6B6B);
                      c6olor=Colors.white;
                      c7olor=Color(0xff6B6B6B);
                      c8olor=Color(0xff6B6B6B);

                      blood_group="A -";
                    });
                  },
                  onDoubleTap: (){
                    setState(() {
                      color5=Colors.white70;
                    });
                  },
                  child: Container(
                    height: 110,
                    width: 75,
                    child: Card(
                      color: color5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 35.06,
                              width: 25,
                              child: Image.asset("assets/images/blooddrop.png")),
                          SizedBox(
                            height: 10.94,
                          ),
                          Text(
                            "A Negative",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: c6olor,
                                fontSize: 12),
                          ),
                          SizedBox(
                            height: 10.94,
                          ),
                          Text(
                            "('A -')",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: c6olor,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 11,
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      color6=Color(0xffFA6393);
                      color=Colors.white70;
                      color1=Colors.white70;
                      color2=Colors.white70;
                      color4=Colors.white70;
                      color5=Colors.white70;
                      color3=Colors.white70;
                      color7=Colors.white70;

                      c1olor=Color(0xff6B6B6B);
                      c2olor=Color(0xff6B6B6B);
                      c3olor=Color(0xff6B6B6B);
                      c4olor=Color(0xff6B6B6B);
                      c5olor=Color(0xff6B6B6B);
                      c6olor=Color(0xff6B6B6B);
                      c7olor=Colors.white;
                      c8olor=Color(0xff6B6B6B);

                      blood_group="B -";
                    });
                  },
                  onDoubleTap: (){
                    setState(() {
                      color6=Colors.white70;
                    });
                  },
                  child: Container(
                    height: 110,
                    width: 75,
                    child: Card(
                      color: color6,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 35.06,
                              width: 25,
                              child: Image.asset("assets/images/blooddrop.png")),
                          SizedBox(
                            height: 10.94,
                          ),
                          Text(
                            "B Negative",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: c7olor,
                                fontSize: 12),
                          ),
                          SizedBox(
                            height: 10.94,
                          ),
                          Text(
                            "('B -')",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: c7olor,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 11,
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      color=Colors.white70;
                      color1=Colors.white70;
                      color2=Colors.white70;
                      color4=Colors.white70;
                      color5=Colors.white70;
                      color3=Colors.white70;
                      color6=Colors.white70;
                      color7=Color(0xffFA6393);

                      c1olor=Color(0xff6B6B6B);
                      c2olor=Color(0xff6B6B6B);
                      c3olor=Color(0xff6B6B6B);
                      c4olor=Color(0xff6B6B6B);
                      c5olor=Color(0xff6B6B6B);
                      c6olor=Color(0xff6B6B6B);
                      c7olor=Color(0xff6B6B6B);
                      c8olor=Colors.white;
                      blood_group="AB -";
                    });
                  },
                  child: Container(
                    height: 110,
                    width: 75,
                    child: Card(
                      color: color7,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 35.06,
                              width: 25,
                              child: Image.asset("assets/images/blooddrop.png")),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "     AB \nNegative",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: c8olor,
                                fontSize: 12),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            "('AB -')",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: c8olor,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 11,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              //height: 380,
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: Colors.white70,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xffFA6393),
                                      width:
                                      1.0, // This would be the width of the underline
                                    ))),
                            child: Text(
                              "Raise Your Requirenmrnt",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffFA6393)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 3),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .9,
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
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    item['state_title'].toString(),
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                )
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                  location = newValue! as String?;
                                  get_District();
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
                        height: 40,
                        width: MediaQuery.of(context).size.width * .9,
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
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    item['district_title'].toString(),
                                    style: TextStyle(color: Colors.black54),
                                  ),
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
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffFFFFFF)),
                          child: Center(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: dropdownvalue,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 35,
                                ),
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width *0.45 ,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.blue.shade100, Colors.blue])),
                          child: MaterialButton(
                            onPressed: () async{
                              final pref=await SharedPreferences.getInstance();
                              var get=pref.getString('user_id');

                              var dio1 = Dio();
                              var formData = FormData.fromMap({
                                'user_id': get.toString(),
                                "blood_group":blood_group.toString(),
                                "unit":dropdownvalue,
                                "city":district,
                              });
                              print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                              var response = await dio1.post('https://community.creditmywallet.in.net/api/add_blood_request'
                                  ,data: formData);
                              var res=response.data;
                              var msg=res["message"];
                              setState(() {
                                print("%%%%%%%%%%%%%%%"+res.toString());
                              });
                              if(res["message"]=="Successfully Added Blood Request")
                              {
                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>BloodRequest()));
                              }
                              else
                              {
                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);
                              }

                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white70,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
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
          ],
        ),
      ),
    );
  }
}

Widget requestBloodCard(img, String name, String symbol) {
  return Container(
    height: 110,
    width: 75,
    child: Card(
      color: Colors.white70,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
              // height: Get.height * 0.12,
              // width: Get.width * 0.18,
              height: 35.06,
              width: 25,
              child: Image.asset(img)),
          const SizedBox(
            height: 10.94,
          ),
          Text(
            name,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Color(0xff6B6B6B),
                fontSize: 12),
          ),
          const SizedBox(
            height: 10.94,
          ),
          Text(
            symbol,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Color(0xff6B6B6B),
                fontSize: 12),
          )
        ],
      ),
    ),
  );
}
