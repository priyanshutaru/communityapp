import 'dart:convert';
import 'package:communityapp/screens/Chat/chat_detail.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MemberSearchProfile extends StatefulWidget {
/*  const MemberSearchProfile({Key? key}) : super(key: key);*/
String? user_id;


MemberSearchProfile({required this.user_id});

  @override
  State<MemberSearchProfile> createState() => _MemberSearchProfileState();
}

class _MemberSearchProfileState extends State<MemberSearchProfile> {
  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC38898',
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

  String? img;
  String? name;
  String? mobile_no;
  String? email;
  String? location;
  String? gender;
  String? category;
  String? shakha;
  String? native;
  String? bio;
  String? middle_name;
  String? last_name;
  String? gender1;
  String? age;
  String? user_id;
  String? can_call1,can_whatsapp;
  String? sks_membership,prfession;
  String? mobile;
  String? semanticsLabel;

  Future get_user_profile() async{
    Map data={
      'user_id':"${widget.user_id}"
    };
    print(data.toString());
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_user_prof");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    setState(() {
      print(url.toString());
    });
    var res=json.decode(response.body);
    var ms=jsonDecode(response.body)['current_shakha'];
    print(ms.toString());
    setState(() {
      user_id=res['basic_details']['user_id'];
      img=res['basic_details']['profile_img'];
      can_call1=res['basic_details']['can_call'];
      mobile=res['basic_details']['mobile'];
      can_whatsapp=res['basic_details']['can_whats'];
      name=res['basic_details']['first_name'];
      middle_name=res['basic_details']['middle_name'];
      last_name=res['basic_details']['last_name'];
      mobile_no=res['basic_details']['mobile'];
      email=res['basic_details']['email'];
      gender =res['basic_details']['gender'];
      shakha=ms['shakha_name'];
      location=res['personal_details']['user_f1_c_add2'];
      age=res['personal_details']['user_f1_age'];
      native=res['native_shakha']['shakha_name'];
      prfession=res['profession_name'];
      sks_membership=res['personal_details']['user_f1_skha_sksmbrshp'];
    });
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      print("${widget.user_id}"+"nxvnbnb");
      get_user_profile();
      get_banner();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE8EFF3),
        shape: RoundedRectangleBorder(),
        elevation: 0,
        leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        title: Text(
          "Member Profile",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xff000000),
              fontSize: 16),
        ),
      ),
      body:img!=null? SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 196,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xffE8EFF3),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(130),
                      bottomRight: Radius.circular(130))),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  img != null? Container(
                    height: 88,
                    width: 88,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: NetworkImage(img.toString()),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ): CircularProgressIndicator() ,
                  SizedBox(
                    height: 10.82,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(name.toString() + " " + last_name.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffFF8900)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(age.toString()+" ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff878383)),
                      ),
                      gender=="0"?
                      Text(
                        "Male",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff878383)),
                      ):
                      Text(
                        "Female",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff878383)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 21),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                color: Color.fromARGB(255, 248, 248, 248),
                child: Container(
                  height: 211,
                  child: Column(
                    children: [
                      Container(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 19),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 31,
                                          right: 15,
                                        ),
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(
                                              "assets/images/jobs.png",
                                              fit: BoxFit.fill,
                                            )
                                        ),
                                      ),
                                    ),
                                    Text(prfession.toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff656565)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.95,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 19),
                                child: Row(
                                  children: [
                                    Container(
                                      // width: Get.width * 0.25,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 31,
                                          right: 15,
                                        ),
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(
                                              "assets/images/shakha.png",
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                    Text(native.toString(),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff656565)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 19),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 31,
                                          right: 15,
                                        ),
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(
                                              "assets/images/shakha.png",
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                    Text(shakha.toString(),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff656565)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.95,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 19),
                                child: Row(
                                  children: [
                                    Container(
                                      // width: Get.width * 0.25,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 31,
                                          right: 15,
                                        ),
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(
                                              "assets/images/member.png",
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                    Text(sks_membership.toString(),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff656565)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 19),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 31, right: 15,),
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(
                                              "assets/images/locationc.png",
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                    Text(location.toString(),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff656565)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 29,
            ),
            can_call1=="0"?
            InkWell(
              onTap: () async
              {
                final number=mobile.toString();
                await FlutterPhoneDirectCaller.callNumber(number);

              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 15,
                            child: Image.asset("assets/images/calls.png")),
                        SizedBox(
                          width: 14,
                        ),
                        Text(
                          "Call",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xff6AAF50),
                              fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.88,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.white, Colors.green.shade300])),
                ),
              ),
            ):
                Text(""),
            SizedBox(
              height: 16,
            ),
            can_whatsapp=='0'?
            InkWell(
              onTap: () {
              },
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 15,
                        child: Image.asset(
                          "assets/images/whatsapp.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "WhatsApp",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff55CD6C),
                            fontSize: 14),
                      )
                    ],
                  ),
                ),
                height: 45,
                width: MediaQuery.of(context).size.width * 0.88,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.white, Colors.green.shade100])),
              ),
            ):
                Text(""),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>ChatDetail(
                      userid: user_id.toString(),
                      name: name.toString(),
                      img: img.toString(),
                    )));
              },
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 35,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/message.png",
                                ),
                                fit: BoxFit.fill)),
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      Text(
                        "Message",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xff60B8FE),
                            fontSize: 14),
                      )
                    ],
                  ),
                ),
                height: 45,
                width: MediaQuery.of(context).size.width * 0.88,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.white, Colors.blue.shade100])),
              ),
            ),
            SizedBox(
              height: 15,
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
              height: 15,
            )
          ],
        ),
      ):
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
      children:[

        Center(
          child:
          Container(
            width: 40,
            height: 40,
            child: new CircularProgressIndicator(
              strokeWidth: 5,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
         Text('Geeting Profile...',style: TextStyle(color: Colors.pink,fontSize: 17),),
      ]
      ),
    );







  }


  Widget fprofilecard(String img,
      String title,) {
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 19),
              child: Row(
                children: [
                  Container(
                    // width: Get.width * 0.25,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 31,
                        right: 15,
                      ),
                      child: Container(
                          height: 20,
                          width: 20,
                          child: Image.asset(
                            "assets/images/$img",
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff656565)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}