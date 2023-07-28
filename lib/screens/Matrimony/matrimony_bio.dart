import 'dart:convert';
import 'package:card_loading/card_loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/Matrimony/matrimony_gallery.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatrimonyBio extends StatefulWidget {
  String? mat_id,age,district,qualification;
  MatrimonyBio({required this.mat_id,required this.age,
    required this.qualification,required this.district});

  @override
  State<MatrimonyBio> createState() => _MatrimonyBioState();
}

class _MatrimonyBioState extends State<MatrimonyBio> {


  String? about,gender_show,height,qualification,dobtime_birth,
      location,name,age,gender,image;
  Future matrimony_profile() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data = {
      'user_id': user_id,
      'mat_id':"${widget.mat_id}"
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/view_matrimony");
    var body = jsonEncode(data);
    final response = await http.post(
        url, headers: {"Content-Type": "application/json"}, body: body);
    print(response);
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      setState(() {
        image=res['profile'];
        name=res['name'];
        about=res['about'];
        height=res['height'];
        dobtime_birth=res['birth_time'];
        age=res['dob'];
        gender=res['gender'];
        if(gender=='0')
        {
          setState(() {
            gender_show="Male";
          });
        }
        else if(gender=='1')
        {
          setState(() {
            gender_show="Female";
          });
        }
        else
        {
          setState(() {
            gender_show="Other";
          });
        }

        print("dfbfggjhjh"+res.toString());
      });
    }
  }

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC71824',
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
    matrimony_profile();
    get_banner();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF4F8FB),
        appBar: AppBar(
          backgroundColor: Color(0xffF4F8FB),
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            ),

          title: Text(
            "Matrimony Bio",
            style: TextStyle(
                color: Color(0xff000000),
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: SingleChildScrollView(
          child: image!=null?
          Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                      height: 84.71,
                      width: 84.71,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: NetworkImage(image.toString()),
                            fit: BoxFit.fill
                        ),
                      )
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                Text(name.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffFA6393)),
                ),
                SizedBox(
                  height: 2,
                ),
                Text("5"+" years "+ gender_show.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff878383)),
                ),
                SizedBox(
                  height: 31,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
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
                                      child: Image.asset("assets/images/p.png")),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "Personal Details",
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
                                      child: Image.asset("assets/images/bio.png")),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "Biography",
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
                              builder: (context)=>MatrimonyGallery(
                                mat_id: "${widget.mat_id}",
                                age: "${widget.age}",
                                qualification:"${widget.qualification}",
                                district: "${widget.district}",
                              )));
                        },
                        child: Container(
                            height: 80,
                            width: 110,
                            child: Card(
                              elevation: 0,
                              color: Color(0xffFFFFFF),
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
                                      Image.asset("assets/images/gallery.png")),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "Gallery",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff878383)),
                                  )
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Container(
                  // width: MediaQuery.of(context).size.width * 0.9,
                  child:  Text(about.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Color(0xff989595)),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                InkWell(
                  onTap: () {
                    // Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 31, right: 31),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.blue, Colors.white])),
                      child: Center(
                        child: Text(
                          "View Main Profile",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
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
              ]
          ):
          CardLoading(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
        )
    );
  }
}
