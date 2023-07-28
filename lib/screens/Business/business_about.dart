import 'dart:convert';
import 'package:card_loading/card_loading.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Business/business_gallery.dart';
import 'package:communityapp/screens/Business/business_info.dart';
import 'package:flutter/material.dart';

class BusinessAbout extends StatefulWidget {
  /*const BusinessAbout({Key? key}) : super(key: key);*/

  String? bussiness_id;
  BusinessAbout({required this.bussiness_id});

  @override
  State<BusinessAbout> createState() => _BusinessAboutState();
}

class _BusinessAboutState extends State<BusinessAbout> {

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

  String? img,name,category,location,opening_time,closing_time,email,website,
      contact,whatsapp,subCategory,about,opening_day,closing_day;

  Future  my_Bussiness_details() async {
    Map data={
      "business_id": "${widget.bussiness_id}"
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
  @override
  void initState() {
    super.initState();
    setState(() {
      get_banner();
      my_Bussiness_details();
      print("%%%%%%%%%%"+"${widget.bussiness_id}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F8FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffF4F8FB),
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () {
             Navigator.push(context, MaterialPageRoute(
                 builder: (context)=>BusinessInfo(bussiness_id: "${widget.bussiness_id}",)));
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          "Business Profile",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xff000000)),
        ),
      ),
      body: SingleChildScrollView(
        child: name!=null?
        Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: Container(
                      height: 106,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                              padding: EdgeInsets.only(left: 120),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(name.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(location.toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff979797),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 2,),
                                  Text(opening_time.toString()+"-"+closing_time.toString(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff4FBC87),
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 2,),
                                Text(opening_day.toString()+"-"+closing_day.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff4FBC87),
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                ],
                              ),
                            ),
                                ],
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
              padding: EdgeInsets.only(left: 15, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>BusinessInfo(
                            bussiness_id: "${widget.bussiness_id}",)));
                    },
                    child: Container(
                        height: 80,
                        width: 110,
                        child: Card(
                          elevation: 0,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 9,
                              ),
                              Container(
                                  height: 30,
                                  width: 24.26,
                                  // width: 60,
                                  child: Image.asset("assets/images/p.png")),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Business Details",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff878383)),
                              )
                            ],
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: () {
                    },
                    child: Container(
                        height: 80,
                        width: 110,
                        child: Card(
                          elevation: 0,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 9,
                              ),
                              Container(
                                  height: 30,
                                  width: 24.26,
                                  // width: 60,
                                  child:
                                      Image.asset("assets/images/about.png")),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "About",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff878383)),
                              ),
                              Spacer(),
                              Container(
                                height: 5,
                                color: Colors.pink.shade200,
                              )
                            ],
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>BusinessGallery(bussiness_id: "${widget.bussiness_id}",)));
                    },
                    child: Container(
                        height: 80,
                        width: 110,
                        child: Card(
                          elevation: 0,
                          color: Color(0xffFFFFFF),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 9,
                              ),
                              Container(
                                  height: 30,
                                  width: 24.26,
                                  // width: 60,
                                  child:
                                      Image.asset("assets/images/gallery.png")),
                              const SizedBox(
                                height: 6,
                              ),
                              const Text(
                                "Gallery",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff878383)),
                              ),
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 26, bottom: 36),
                    child: Container(
                      child: Text(about.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff656565)),
                      ),
                    ),
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
              height: 27,
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
                  padding: EdgeInsets.only(left: 21, right: 15),
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


