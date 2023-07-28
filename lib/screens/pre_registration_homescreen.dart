import 'dart:convert';
import 'package:card_loading/card_loading.dart';
import 'package:communityapp/screens/Stepper/basic_details.dart';
import 'package:communityapp/screens/Stepper/stepper1.dart';
import 'package:communityapp/screens/auth/get_event_model.dart';
import 'package:communityapp/screens/auth/get_news_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Stepper/stepper.dart';
import 'package:flutter/material.dart';
import 'package:communityapp/Utils/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/helperFunctions.dart';
class PreRegistrationHomeScreen extends StatefulWidget {
 const PreRegistrationHomeScreen({Key? key}) : super(key: key);
  @override
  State<PreRegistrationHomeScreen> createState() =>
      _PreRegistrationHomeScreenState();
}
class _PreRegistrationHomeScreenState extends State<PreRegistrationHomeScreen> {
  List<String> _images = [
    'assets/images/slider.png',
    'assets/images/slider.png',
  ];
  String ?user_id;
  String? name;
  String? img;
  String? id;
  // bool? userIsLoggedIn;
  void setid(value) async{
    final pref1=await SharedPreferences.getInstance();
    final set1=pref1.setString('id', value);
    print(set1);
  }
  void _setname(value) async{
    final pref=await SharedPreferences.getInstance();
    final set1=pref.setString('name', value);
    print(set1);
  }
  // getLoggedInSate()async {
  //   await HelperFunctions.getuserLoggedInSharedPreference().then((value) {
  //     setState(() {
  //       userIsLoggedIn = value;
  //       print("value:${value}");
  //     });
  //   });
  // }

  // Future getuser() async{
  //   final pref=await SharedPreferences.getInstance();
  //   var get=pref.getString('user_id');
  //   Map data={
  //     'user_id':get.toString()
  //   };
  //   print(data.toString());
  //   Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_user");
  //   var body=jsonEncode(data);
  //   var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
  //   setState(() {
  //     print(url.toString());
  //   });
  //   var res=json.decode(response.body)[0];
  //   setState(() {
  //     name=res['first_name'];
  //     setState((){
  //       print(name.toString());
  //     });
  //     img=res['profile_img'];
  //     id=res['id'];
  //     setid(id);
  //     _setname(name.toString());
  //     print(name.toString());
  //   });
  // }

  Future getuser() async{
    final pref=await SharedPreferences.getInstance();
    var get=pref.getString('user_id');
    Map data={
      'user_id':get.toString()
    };
    print(data.toString());
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_user");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    setState(() {
      print(url.toString());
    });
    var res=json.decode(response.body)[0];
    setState(() {
      name=res['first_name'];
      img=res['profile_img'];
      setState(() {

      });
      first_name.text=name.toString();
      image.text=img.toString();

    });
  }
  TextEditingController first_name=TextEditingController();
  TextEditingController image=TextEditingController();
  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC40452',
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

  String? good;
  var icons;
  void time() async {
    var timeNow = DateTime.now().hour;
    if (timeNow <= 11) {
      setState((){
        good= 'Good Morning';
        icons="assets/images/sun_m.png";
      });
    } else if ((timeNow > 11) && (timeNow <= 15))
    {
      setState((){
        good= 'Good Afternoon';
        icons="assets/images/moon.png";
      });
    }
    else if ((timeNow > 15) && (timeNow <=19))
    {
      setState((){
        good= 'Good Evening';
        icons="assets/images/moon.png";
      });
    } else {
      setState((){
        good= 'Good Night';
      });
    }}

  Future <List<Details>> get_Event() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id':user_id.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_limit_event");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['details'];
      print(data.toString()+"%%%%%%%%%%");
      print(data);
      return data.map((job) => Details.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  List News_Categories=[];
  Future get_News_Categories() async {
    var url = Uri.parse("https://community.creditmywallet.in.net/api/get_news_category");
    final response = await http.post(url,headers:{"Content-Type": "application/json"});
    var res = await json.decode(response.body);
    print("response12" + response.body);

    if (response.statusCode == 200) {
      setState(() {
        News_Categories = res['status_message'];
        print("%%%%%%%%%%5555"+News_Categories.toString());
      });
    }
  }

  Future <List<Data>> getNews() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id':user_id,
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_limit_news");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type":
    "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      print(data);
      return data.map((job) => Data.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      get_banner();
      time();
      getuser();
    });
    setState(() {
      get_News_Categories();
      getNews();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: img !=null?
          InkWell(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(img.toString()),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Row(
                        children: [
                          Text(good.toString()+" ",
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(name.toString(),
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 22,
                            width: 22,
                            child: Image.asset(icons),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                      height: 118,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //color: Colors.brown[100],
                        border: Border.all(color: Colors.pink,width: 0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.shade50,
                            offset:  Offset(
                              0.0,
                              0.0,
                            ),
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                          ), //BoxShadow//BoxShadow
                        ],
                      ),
                      width: 392,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        elevation: 0.0,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    child: Image.asset(
                                      "assets/images/sign.png",
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 7),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 240,
                                          child: RichText(
                                            text:  TextSpan(
                                              text: 'Hey!!  '+ "$name",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                              /*defining default style is optional */
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                    ' your profile is incompleted.\nComplete your profile to access all features of the App.',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: Colors.black54,
                                                        fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder:
                                              (BuildContext context) => BasicDetail()));


                                      /*  Navigator.pushReplacement(context, MaterialPageRoute(
                                        builder: (context)=>IconStepperDemo21()));*/
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 17, right: 20),
                                      child: Text(
                                        " Complete Now ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      )
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
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 22),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.32,
                            height: 45,
                            decoration: const BoxDecoration(
                            ),
                            child: Text(
                              "DASHBOARD",
                              style:
                              TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                              top: 22,
                              child: Container(
                                height: 2,
                                width: MediaQuery.of(context).size.width * 0.22,
                                color: Colors.black,
                              )
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                            },
                            child: utils.listviewcard(
                                text: "Birthday &\nAnniversary",
                                Images: 'assets/images/birthday.png'),

                          ),
                          InkWell(
                              onTap: () {
                                // Get.to(Registration());
                              },
                              child: utils.listviewcard(
                                  text: "News",
                                  Images: 'assets/images/news.png')),
                          InkWell(
                              onTap: () {
                              },
                              child: utils.listviewcard(
                                  text: "Events",
                                  Images: 'assets/images/events.png')),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                                onTap: () {
                                },
                                child: utils.listviewcard(
                                    text: "Matrimony",
                                    Images: 'assets/images/matrimony.png')),
                            InkWell(
                                onTap: () {
                                  // Get.to(Registration());
                                },
                                child: utils.listviewcard(
                                    text: "Blood bank",
                                    Images: 'assets/images/bloodbank.png')),
                            InkWell(
                                onTap: () {
                                  // Get.to(Registration());
                                },
                                child: utils.listviewcard(
                                    text: "Job Search",
                                    Images: 'assets/images/jobs.png')),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () {
                                // Get.to(Registration());
                              },
                              child: utils.listviewcard(
                                  Images: 'assets/images/business.png',
                                  text: "   Vadval \nBussiness")),
                          GestureDetector(
                              onTap: () {
                                // Get.to(Registration());
                              },
                              child: utils.listviewcard(
                                  text: "Search",
                                  Images: 'assets/images/membersearch.png')),
                          GestureDetector(
                              onTap: () {
                                // Get.to(Registration());
                              },
                              child: utils.listviewcard(
                                  text: "Open Forum",
                                  Images: 'assets/images/openforum.png')),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () {
                                // Get.to(Registration());
                              },
                              child: utils.listviewcard(
                                  text: "   Vedval\n Sanskriti",
                                  Images: 'assets/images/matrimony.png')),
                          InkWell(
                              onTap: () {
                                // Get.to(Registration());
                              },
                              child: utils.listviewcard(
                                  text: "Hire a Vedval",
                                  Images: 'assets/images/bloodbank.png')),
                          InkWell(
                              onTap: () {
                                // Get.to(Registration());
                              },
                              child: utils.listviewcard(
                                  text: "Business\n   Leads",
                                  Images: 'assets/images/jobs.png')),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height:25,
                            width: MediaQuery.of(context).size.width * 0.32,
                            decoration: BoxDecoration(
                            ),
                            child: Text(
                              "Recent News",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Positioned(
                              top: 22,
                              child: Container(
                                height: 2,
                                width: MediaQuery.of(context).size.width * 0.22,
                                color: Colors.black,
                              )
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder <List<Data>>(
                    future: getNews(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Data>? data = snapshot.data;
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data!.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 7.7 / 4,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 3,
                              crossAxisCount: 1),
                          itemBuilder: (BuildContext, int index) {
                            return Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.95,
                              child: Card(
                                color: Color(0xffFCFCFC),
                                shape:
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 2,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.6,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width * 0.35,
                                                height: 35,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(
                                                          30)),
                                                  color: Color(0xffF6F6F6),
                                                  child: Center(
                                                      child: Text(
                                                        data[index].categoryName
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 12),
                                                      )),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0.55,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 10),
                                                    child: Text(
                                                      data[index].title.toString(),
                                                      style: TextStyle(
                                                          color: Color(0xff000000),
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 14),
                                                    ),
                                                  )),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Republic",
                                                      style: TextStyle(fontSize: 10),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      data[index].addedTime.toString(),
                                                      style: TextStyle(fontSize: 10),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text(
                                                      data[index].addedDate.toString(),
                                                      style: TextStyle(fontSize: 10),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          margin: EdgeInsets.only(top: 15),
                                          width: MediaQuery.of(context).size.width * 0.25,
                                          height: MediaQuery.of(context).size.height * 0.15,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      data[index].img.toString()),
                                                  fit: BoxFit.fill
                                              )
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15, right: 15),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async{

                                            },
                                            icon: data[index].likeStatus!="0"?
                                            Icon(Icons.favorite_border):
                                            Icon(Icons.favorite,color: Colors.red,),
                                          ),

                                          Text(data[index].likes.toString()),
                                          Spacer(),
                                          IconButton(
                                              onPressed: (){
                                              },
                                              icon: Icon(Icons.comment_bank_outlined)
                                          ),

                                          Text(data[index].comments.toString()),
                                          Spacer(),
                                          IconButton(
                                              onPressed: (){},
                                              icon: Icon(Icons.share)
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Text("No News");
                    }),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Stack(
                          children: [
                            Container(
                              height:25,
                              width: MediaQuery.of(context).size.width * 0.38,
                              decoration: BoxDecoration(
                              ),
                              child: Text(
                                "Popular Topics",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                                top: 22,
                                child: Container(
                                  height: 2,
                                  width: MediaQuery.of(context).size.width * 0.28,
                                  color: Colors.black,
                                )
                            )
                          ]
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                News_Categories.length!=0?
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 125.0,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: News_Categories.length,
                      itemBuilder: (BuildContext context,int index)
                      {
                        return InkWell(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(
                            //     builder: (context)=>NewsCatagory(
                            //       Categorey_id: News_Categories[index]['category_id'].toString(),
                            //       tittle5: News_Categories[index]['category_name'].toString(),
                            //     )));
                          },
                          child: Container(
                              width: 100,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundImage: NetworkImage(News_Categories[index]['category_img'].toString()),
                                  ),
                                  SizedBox(
                                    height:10,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 20),
                                    child: Text(News_Categories[index]['category_name'].toString(),
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  )
                                ],
                              )),
                        );
                      }
                  ),
                ): Text("No News Categories"),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Stack(
                          children: [
                            Container(
                              height:25,
                              width: MediaQuery.of(context).size.width * 0.17,
                              decoration: BoxDecoration(
                              ),
                              child: Text(
                                "Events",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                                top: 22,
                                child: Container(
                                  height: 2,
                                  width: MediaQuery.of(context).size.width * 0.11,
                                  color: Colors.black,
                                )
                            )
                          ]
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                FutureBuilder <List<Details>>(
                    future: get_Event(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Details>? data = snapshot.data;
                        return data?.length!=0?
                        GridView.builder(
                          shrinkWrap: true,
                          physics:  NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: data!.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 5/ 8,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 3,
                              crossAxisCount: 2
                          ),
                          itemBuilder: (BuildContext, int index) {
                            return data.length!=0?
                            Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Card(
                                        shape:
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.14,
                                          width: MediaQuery.of(context).size.width * 0.42,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image: NetworkImage(data[index].img.toString()),
                                                  fit: BoxFit.fill
                                              )
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.4,
                                          height: 34,
                                          child: Text(data[index].description.toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(left: 12),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.42,
                                          height: 15,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(data[index].eventTime.toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.black54),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.07,
                                              ),
                                              Text(data[index].eventDate.toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.black54),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ):
                            Text("No Events");
                          },
                        ):
                        Text("No Events") ;
                      }
                      return Text("No Events");
                    }),
              ],
            ),
            onTap: (){
              Fluttertoast.showToast(msg: "Complete your kyc Details",
                  toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);

            },
          ):
          CardLoading(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
        ),
      ),
    );
  }
}


