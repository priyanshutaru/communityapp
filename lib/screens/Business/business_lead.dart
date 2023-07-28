import 'dart:convert';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/generate_lead.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/auth/view_all_bussiness_lead_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessLead extends StatefulWidget {
  const BusinessLead({Key? key}) : super(key: key);

  @override
  State<BusinessLead> createState() => _BusinessLeadState();
}

class _BusinessLeadState extends State<BusinessLead> {


  Future <List<Bussiness_Lead>> get_bussiness_leads() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      "user_id":user_id
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/view_all_business_leads");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type":
    "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['state'];
      return data.map((job) => Bussiness_Lead.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC32995',
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
  int? total_lead;
  Future total_leads() async{
    final pref=await SharedPreferences.getInstance();
    var get=pref.getString('user_id');
    Map data={
      'user_id':get.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/view_all_business_leads");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    var res=json.decode(response.body);
    setState(() {
      total_lead=res['total_leads'];
    });
  }

  @override
  void initState() {
    super.initState();
    get_banner();
    total_leads();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffF4F8FB),
        leading:  IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
        ),
        title: Text(
          "Business Lead from Vadval Business",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: Color(0xff000000)),
        ),
      ),
      body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 21),
                    child: total_lead!=null?
                    Text(
                      "Total leads : "+total_lead.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000),
                          fontSize: 16),
                    ):
                    Text(
                      "Total leads : 0",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000),
                          fontSize: 16),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>GenerateLead()));
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Stack(
                      children: [
                        Container(
                          child: Center(
                              child: Text(
                                "Create Forum",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.blue.shade200,
                                    Colors.blue.shade400
                                  ]
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 110,
                          ),
                          child: CircleAvatar(
                            backgroundImage:
                            AssetImage("assets/images/upload.png"),
                            radius: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder <List<Bussiness_Lead>>(
                  future: get_bussiness_leads(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Bussiness_Lead>? data = snapshot.data;
                      return Expanded(child: ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return  Container(
                            height: 107,
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10, top: 10),
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.1,
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(40)),
                                            image: DecorationImage(
                                                image: NetworkImage(data[index].profileImg.toString(),),
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.55,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(data[index].firstName.toString()+" "+data[index].middleName.toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff3E3E3E),
                                                    fontWeight: FontWeight.w700),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            child: Text(data[index].description.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Color(0xff878383)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.7,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 20, width: 20,
                                                  child: Image.asset("assets/images/jobs.png"),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(data[index].subCategoryName.toString(),
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w700,
                                                      color: Color(0xff878383)),
                                                ),
                                                Spacer(),
                                                Container(
                                                  child: Text(data[index].createdAt.toString().replaceRange(10, 19, ""),
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color(0xff000000)),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.1,
                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: () async{
                                                  final number=data[index].mobile.toString();
                                                  await FlutterPhoneDirectCaller.callNumber(number);
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(50),
                                                      gradient: LinearGradient(
                                                          begin: Alignment.bottomLeft,
                                                          end: Alignment.bottomRight,
                                                          colors: [Colors.blue.shade100, Colors.blue])),
                                                  child: Icon(
                                                    Icons.call,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ));
                    }
                    return  Text("No View Bussiness Leads");
                  }),
            ),
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
                    )
                )
                )
                    .toList(),
              ),
            ):
            Text(""),
            SizedBox(
              height: 10,
            ),
          ]
      ),
    );
  }
}


