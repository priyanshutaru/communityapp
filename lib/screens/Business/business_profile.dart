import 'dart:convert';
import 'package:card_loading/card_loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/Business/business_about.dart';
import 'package:communityapp/screens/Business/business_gallery.dart';
import 'package:communityapp/screens/Business/my_business.dart';
import 'package:flutter/material.dart';

class BusinessProfile extends StatefulWidget {
String? bussines_id;
BusinessProfile({required this.bussines_id});

  @override
  State<BusinessProfile> createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
  String? img,name,category,location,opening_time,closing_time,email,website,
      contact,whatsapp,subCategory,about,opening_day,closing_day;
  Future  my_Bussiness_details() async {
    Map data={
      "business_id": "${widget.bussines_id}"
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_business_details");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    var res = json.decode(response.body);
    setState(() {
      email=res['email'];
      website=res['website'];
      contact=res['contact'];
      whatsapp=res['whatsapp'];
      name=res['business_name'];
      about=res['about'];
      img=res['profile_img'];
      subCategory=res['subcategory_name'];
      location=res['district_name'];
      category=res['category_name'];
      opening_day=res['opening_day'];
      closing_day=res['closing_day'];
      opening_time=res['opening_time'];
      closing_time=res['closing_time'];
      print("res"+res.toString());
    });
    print(response);
  }

  List gallery=[];
  Future get_gallery() async {
    Map data={
      "business_id": "${widget.bussines_id}"
    };
    var url = Uri.parse("https://community.creditmywallet.in.net/api/get_business_gallery");
    var body=jsonEncode(data);
    final response = await http.post(url,headers:{"Content-Type": "application/json"},body: body);
    var res = await json.decode(response.body);
    print("response12" + response.body);

    if (response.statusCode == 200) {
      setState(() {
        gallery = res['data'];
        print("%%%%%%%%%%5555"+gallery.toString());
      });
    }
  }

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC41696',
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
    setState(() {
      my_Bussiness_details();
      get_gallery();
      get_banner();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F8FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffF4F8FB),
        leading:IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        title: Text(
          "Business Profile",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xff000000)),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyBusiness()));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Container(
                height: 25,
                width: 25,
                child: Image.asset(
                  "assets/images/businesspro1.png",
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: name!=null?
        Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height*0.2,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 90,
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20,right: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0, left: 30),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.4,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(name.toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff000000),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(location.toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xff979797),
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(opening_time.toString()+"--"+closing_time.toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xff4FBC87),
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(opening_day.toString()+"-"+closing_day.toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xff4FBC87),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: Container(
                    height: 90, width: 90,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(img.toString()),
                            fit: BoxFit.fill
                        ),
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.52,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.black,
                      width: 1.0, // This would be the width of the underline
                    ))),
                    child: const Text(
                      "Business Information",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  fprofilecard("member.png", category.toString()),
                  SizedBox(
                    height: 10,
                  ),
                  fprofilecard("software.png", subCategory.toString()),
                  SizedBox(
                    height: 10,
                  ),
                  fprofilecard("internet.png", website.toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  fprofilecard("gmail.png", email.toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  fprofilecard("whatsapp.png", "+91 - "+contact.toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  fprofilecard("calls.png", "+91 - "+whatsapp.toString()),
                  const SizedBox(
                    height: 23,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 27,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>BusinessAbout(bussiness_id: "${widget.bussines_id}",)));
              },
              child: Padding(
                padding: EdgeInsets.only(left: 25),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              )
                          )
                      ),
                      child: Text(
                        "About",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Padding(
              padding: EdgeInsets.only(left: 21, right: 22),
              child: Container(
                child: Text(about.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xff656565)),
                ),
              ),
            ),
            SizedBox(
              height: 27,
            ),
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.17,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    )
                        )
                    ),
                    child: Text(
                      "Gallery",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Card(
                color: Colors.white70,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 5, right: 5, top: 19.18, bottom: 22.12),
                  child: Column(
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics:  NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: gallery.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 10/ 10,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 6,
                            crossAxisCount: 3
                        ),
                        itemBuilder: (BuildContext, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20), color: Colors.white),
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              elevation: 4,
                              child: Container(
                                height: 84.71, width: 84.86,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(gallery[index].toString())
                                        , fit: BoxFit.cover)
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),

                    ],
                  ),
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
            SizedBox(
              height: 8,
            ),
          ],
        ):
        CardLoading(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
      ),
    );
  }
  Widget fprofilecard(String img, String title,) {
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 21, right: 15),
                  child: Container(
                    // width: Get.width * 0.25,
                    child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/images/$img",
                      ),
                    ),
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff656565)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


