import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Blood/all_donor_list.dart';
import 'package:communityapp/screens/Blood/blood_bank.dart';
import 'package:communityapp/screens/Blood/blood_donation_request.dart';
import 'package:communityapp/screens/Blood/my_blood_request.dart';
import 'package:communityapp/screens/Blood/request_blood.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BloodBankHome extends StatefulWidget {
  const BloodBankHome({Key? key}) : super(key: key);

  @override
  State<BloodBankHome> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<BloodBankHome> {

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC31845',
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

  int? total,lives;

  Future  all_blood() async{
    var url="https://community.creditmywallet.in.net/api/total_request";
    http.Response response=await http.get(Uri.parse(url));
    var res=jsonDecode(response.body);
    setState(() {
      total=res['toral_req']['toral_req2'];
      lives=res['toral_req']['total_live_saves2'];
    });

  }

  @override
  void initState() {
    super.initState();
    setState(() {
      get_banner();
      all_blood();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F5F5),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xffF8F5F5),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                "Give The Gift Of Life",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff878383)),
              ),
              Text(
                "Donate Blood",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffFA6393)),
              ),
              SizedBox(
                height: 45.12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                    },
                    child: Container(
                      height: 93.67,
                      width: 100,
                      child: Card(
                        elevation: 1,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 12.76,
                            ),
                            total!=null?Text(total.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffFFFFFF),
                                  fontSize: 30),
                            ):
                            Text("0",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffFFFFFF),
                                  fontSize: 30),
                            ),
                            SizedBox(
                              height: 2.6,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 18),
                              child: Text(
                                "New Blood Requested",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xffFFFFFF),
                                    fontSize: 12),
                              ),
                            )
                          ],
                        ),
                        color: Colors.pink.shade400,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  InkWell(
                    onTap: () {
                    },
                    child: Container(
                      height: 93.67,
                      width: 100,
                      child: Card(
                        elevation: 1,
                        color: Color(0xffE8EFF3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 13.78,
                            ),
                            lives!=null?
                            Text(lives.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff6B6B6B),
                                  fontSize: 30),
                            ):
                            Text("0",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff6B6B6B),
                                  fontSize: 30),
                            ),
                            SizedBox(
                              height: 9.18,
                            ),
                            Text(
                              "Lives Saved",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff6B6B6B),
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 22.9,
              ),
              Text(
                "Each Donation can help us save upto 3 Lives !",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff6B6B6B)),
              ),
              SizedBox(
                height: 35.39,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>RequestBlood()));
                      },
                      child: bloodcard("assets/images/blooddrop.png",
                          "Request For\n    Blood"),
                    ),
                    SizedBox(
                      width: 29,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>BloodDonationRequest(total: total.toString(),)));
                      },
                      child: bloodcard("assets/images/bloodrequest.png",
                          "    Open Blood Donation Request"),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          //Get.to(BloodBank());
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>BloodBank()));
                        },
                        child: bloodcard(
                            "assets/images/bloodbank.png", "Blood Bank")),
                    SizedBox(
                      width: 29,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>AllDonorList()));
                        },
                        child: bloodcard(
                            "assets/images/saveblood.png", "All Donor List"))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>BloodRequest()));
                },
                child: Container(
                  height: 120,
                  width: 310,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Card(
                    elevation: 3,
                    color: Color(0xffF8F5F5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                            height: 50,
                            width: 50.7,
                            child: Image.asset("assets/images/saveblood.png")),
                        SizedBox(
                          height: 7,
                        ),
                        Center(
                          child: Text(
                            "My Blood Requests",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color(0xffFA6393)),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
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
                      )))
                      .toList(),
                ),
              ):
              Text(""),
            ],
          ),
        ),
      ),
    );
  }
}

Widget bloodcard(img, String title) {
  return Container(
    child: Container(
      height: 155.71,
      width: 140,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Card(
        elevation: 3,
        color: Color(0xffF8F5F5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            SizedBox(
              height: 29.14,
            ),
            Container(
                height: 50,
                width: 50,
                child: Image.asset(img)),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xffFA6393)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
