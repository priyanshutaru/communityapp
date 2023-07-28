import 'dart:convert';
import 'package:card_loading/card_loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/auth/get_hire_a_vadaval_model.dart';
import 'package:communityapp/screens/myProfile.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/Matrimony/matrimony_bio.dart';
import 'package:communityapp/screens/Matrimony/matrimony_gallery.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VadvalProfile extends StatefulWidget {

  const VadvalProfile({Key? key}) : super(key: key);
  @override
  State<VadvalProfile> createState() => _VadvalProfileState();
}
class _VadvalProfileState extends State<VadvalProfile> {
  String? Skin_tone,gender_show,height,qualification,dobtime_birth,
      location,name,age,gender,image,profession,subscription_id;

  String? img;

  Future  get_hire_vadaval() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      "user_id":user_id.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/hire_a_vadval_random");
    var data1 = jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body:data1);
    print(response);
    if (response.statusCode == 200) {
       data = json.decode(response.body)['vadval'];
       img:data['profile_img'];
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
    get_banner();
    get_hire_vadaval();
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
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),

          title: Text(
            "Matrimony Profile",
            style: TextStyle(
                color: Color(0xff000000),
                fontWeight: FontWeight.w700,
                fontSize: 16),
          ),
        ),
        body:image!=null? SingleChildScrollView(
            child: Column(
                children: [
                  SizedBox(
                    height: 20,
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
                  Text(age.toString()+" Years, "+  gender_show.toString(),
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
                            // Navigator.push(context, MaterialPageRoute(
                            //     builder: (context) => MatrimonyBio(
                            //       mat_id: "${widget.mat_id}",
                            //       age: "${widget.age}", district: '', qualification: '',
                            //     )));
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
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    const Text(
                                      "Biography",
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
                            // Navigator.push(context, MaterialPageRoute(
                            //     builder: (context) => MatrimonyGallery(
                            //       mat_id: "${widget.mat_id}",
                            //       age: "${widget.age}",
                            //       qualification:"${widget.education}",
                            //       district: "${widget.district}",
                            //     )));
                          },
                          child: Container(
                            // height: Get.height * 0.13,
                            // width: Get.width * 0.33,
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
                    height: 15,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        personalcard("Skin & Fairness", Skin_tone.toString()),
                        SizedBox(
                          height: 13,
                        ),
                        personalcard("Height", '${height.toString()}'+" Fit"),
                        SizedBox(
                          height: 13,
                        ),
                        personalcard("Profession", profession.toString()),
                        SizedBox(
                          height: 13,
                        ),
                        personalcard("Birth Date", age.toString()),
                        SizedBox(
                          height: 13,
                        ),
                        personalcard("Birth Time", dobtime_birth.toString()),
                        SizedBox(
                          height: 13,
                        ),
                        personalcard("Location",location.toString())
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 37,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 31, right: 31),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.blue, Colors.blue.shade100])),
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
                ])
        ):CardLoading(height: MediaQuery.of(context).size.height)
    );
  }


  Widget personalcard(String brand, String name) {
    return Container(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              brand,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff989595)),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.8,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.green,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
