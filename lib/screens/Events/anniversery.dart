import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Events/anniversary_wish.dart';
import 'package:communityapp/screens/auth/get_anniversery_model.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/Chat/chat_detail.dart';
import 'package:communityapp/screens/Events/birthdaywish.dart';
import 'package:communityapp/screens/auth/get_birthday_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Anniversary extends StatefulWidget {
  const Anniversary({Key? key}) : super(key: key);

  @override
  State<Anniversary> createState() => _AnniversaryState();
}

class _AnniversaryState extends State<Anniversary> {


int? day;

  Future my_birthday() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id':user_id,
    };
    var url = Uri.parse("https://community.creditmywallet.in.net/api/my_birthday_day");
    var body=jsonEncode(data);
    final response = await http.post(url,headers:{"Content-Type": "application/json"},body: body);
    var res = await json.decode(response.body)['remain'];
    setState(() {
      day=res;
    });
  }

  Future <List<Birthday>> get_Birthday() async {
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_birtday");
    final response = await http.get(url, headers: {"Content-Type":
    "application/json"});
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['details'];
      print(data);
      return data.map((job) => Birthday.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future <List<Anniversery>> get_Anniversery() async {
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_ann");
    final response = await http.get(url, headers: {"Content-Type":
    "application/json"});
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['details'];
      print(data);
      return data.map((job) => Anniversery.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

List Banner=[];
Future get_banner() async {
  Map data={
    'screen_id':'SC57440',
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

String? name,middle_name;
Future getuser() async{
  final pref=await SharedPreferences.getInstance();
  var get=pref.getString('user_id');
  Map data={
    'user_id':get.toString()
  };
  Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_user");
  var body=jsonEncode(data);
  var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
  setState(() {
    print(url.toString());
  });
  var res=json.decode(response.body)[0];
  setState(() {
    name=res['first_name'];
    middle_name=res['last_name'];
  });
}

  @override
  void initState() {
    super.initState();
    setState(() {
      getuser();
      my_birthday();
      get_Birthday();
      get_Anniversery();
      get_banner();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 240, 240),
      body:  SafeArea(
        child: Banner.length!=0? SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 231, 230, 230),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_new_outlined),
                        )),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          "Birthday & Anniversary",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       name!=null?
                       Text(
                          "Hi!! "+name![0].toUpperCase().toString()+name!.replaceRange(0, 1, "")+" "+middle_name![0].toUpperCase().toString()+middle_name!.replaceRange(0, 1, ""),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black54),
                        ):
                           Text(""),
                        SizedBox(
                          height: 3,
                        ),
                        day!=null?Text(
                          "Your birthday is "+day.toString()+" days away",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ):
                        Text(
                          "0",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [
                          Colors.blue,
                          Colors.white,
                        ],
                      )),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>BirthdayWish()));
                      },
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Today's Birthday",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          Container(
                              height: 30,
                              width: 30,
                              child: Image.asset("assets/images/arrow.png")),
                        ],
                      ))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder <List<Birthday>>(
                  future: get_Birthday(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Birthday>? data = snapshot.data;
                      return data!.length!=0?
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 28 / 8,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 3,
                            crossAxisCount: 1),
                        itemBuilder: (BuildContext, int index) {
                          return Card(
                            color: Color.fromARGB(255, 241, 240, 240),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [

                                Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child: Container(
                                    // color: Color(0xffF8F5F5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 15, right: 15),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Colors.brown[100],
                                                radius: 30,
                                                backgroundImage: NetworkImage(data[index].profileImg.toString()),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(data[index].firstName.toString()+" "+data[index].lastName.toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(data[index].districtName.toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black45),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text("turning "+data[index].turning.toString()+" years old",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color.fromARGB(255, 149, 196, 152)),
                                                  )
                                                ],
                                              ),
                                              Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context)=>ChatDetail(
                                                        userid: data[index].userId.toString(),
                                                        name: data[index].firstName.toString(),
                                                        img: data[index].profileImg.toString(),
                                                      )));
                                                },
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                              height: 30,
                                                              width: 30,
                                                              child: Image.asset(
                                                                "assets/images/send.png",
                                                              )),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            "Send Wishes",
                                                            style:
                                                            TextStyle(fontSize: 12, color: Colors.blue),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider()
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ):
                      Text(" No Member Born Today!!");
                    }
                    return Text(" No Member Born Today!!");
                  }
                  ),
              SizedBox(
                height: 20,
              ),

              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.blue,
                          Colors.white,
                        ],
                      )),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>AnyversaryWish()));
                      },
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Today's Anniversary",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          Container(
                              height: 30,
                              width: 30,
                              child: Image.asset("assets/images/arrow.png")),
                        ],
                      )
                      )
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder <List<Anniversery>>(
                  future: get_Anniversery(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Anniversery>? data = snapshot.data;
                      return data!.length!=0?
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 34 / 8,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 3,
                            crossAxisCount: 1),
                        itemBuilder: (BuildContext, int index) {
                          return Card(
                            color: Color.fromARGB(255, 241, 240, 240),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.all(0),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 15, right: 15),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Colors.brown[100],
                                                radius: 30,
                                                backgroundImage: NetworkImage(data[index].profileImg.toString()),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(data[index].firstName.toString()+" "+data[index].lastName.toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(data[index].districtName.toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black45),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(data[index].dob.toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color.fromARGB(255, 149, 196, 152)),
                                                  )
                                                ],
                                              ),
                                              Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context)=>ChatDetail(
                                                        userid: data[index].userId.toString(),
                                                        name: data[index].firstName.toString(),
                                                        img: data[index].profileImg.toString(),
                                                      )));
                                                },
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                            height: 30,
                                                            width: 30,
                                                            child: Image.asset(
                                                              "assets/images/send.png",
                                                            )),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            "Send Wishes",
                                                            style:
                                                            TextStyle(fontSize: 12, color: Colors.blue),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider()
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ):
                      Text("No Member Married Today!!");
                    }
                    return Text("No Member Married Today!!");
                  }),
              SizedBox(
                height: 10
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
        ):
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        // you can replace this with Image.asset
                        'assets/images/splash.png',
                        fit: BoxFit.cover,
                        height: 70,
                        width: 70,
                      ),
                      // you can replace
                      Container(
                        height: 80,
                        width: 80,
                        child:
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                          strokeWidth: 1.5,

                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text( 'Finding Peoples...',style: TextStyle(color: Colors.pink,fontSize: 17),),
                ]
            ),
          ],
        )
      ),
    );
  }
}

