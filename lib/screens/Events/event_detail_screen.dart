import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/Events/anniversery.dart';
import 'package:communityapp/screens/Events/birthdaywish.dart';
import 'package:communityapp/screens/Chat/chat_screen.dart';
import 'package:communityapp/screens/membersearch/member_search_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventDetailSscreen extends StatefulWidget {
  String? event_id,user_id,description,profileImg,date,time,state,city,title,firstname,lastname,img;
  EventDetailSscreen({
    required this.event_id,
    required this.user_id,
    required this.description,
    this.date,
    this.profileImg,
    this.time,
    this.state,
    this.city,
    this.title,
    this.firstname,
    this.lastname,
    this.img,
  });

  @override
  State<EventDetailSscreen> createState() => _EventDetailSscreenState();
}

class _EventDetailSscreenState extends State<EventDetailSscreen> {

  String? event_time,evennt_date,image,tittle,description,location,city,user_id;


  Future get_event_details() async{
    Map data={
      'event_id':"${widget.event_id}"
    };
    Uri url=Uri.parse("https://community.creditmywallet.in.net/api/get_event_detail");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    var res=jsonDecode(response.body)['details'];
    setState(() {
      user_id=res['user_id'];
      city=res['name'];
      event_time=res['event_time'];
      evennt_date=res['event_date'];
      tittle=res['title'];
      description=res['description'];
      image=res['img'];
      location=res['location'];
      print(res.toString()+"77777777777777");
    });
  }

  List event=[];
  Future get_Event() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id':user_id.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_event");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    var res = json.decode(response.body)['details'];
    setState(() {
      event=res;
    });
  }

  String? first_name,last_name,profile_img;
  Future getuser() async{
    Map data={
      'user_id': "${widget.user_id}"
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_user");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    var res=json.decode(response.body)[0];
    setState(() {
      first_name=res['first_name'];
      last_name=res['last_name'];
      profile_img=res['profile_img'];
    });
  }


  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC62737',
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

  @override
  void initState() {
    super.initState();
    get_event_details();
    getuser();
    get_Event();
    get_banner();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xffE8EFF3),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        shape: RoundedRectangleBorder(),
        elevation: 0,
        centerTitle: true,
        title:  Text(
          "Event Discription",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xff000000),
              fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                height: 203,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  //color: Colors.red,
                  image: DecorationImage(
                      image: NetworkImage("${widget.img}"),
                      fit: BoxFit.cover
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Card(
                  elevation: 5,
                  color: Color(0xffF6F6F6E5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text('Time and Venue Details',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                        textAlign: TextAlign.start
                        ,
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: Colors.black45,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text("Time:"+ " "+"${widget.time.toString()}",
                                style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black45),),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: Colors.black45,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Date:"+ " "+"${widget.date}",
                              style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black45),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12,),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: Colors.black45,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text("${widget.city.toString()}"+" "+"${widget.state}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black45),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text("${widget.title}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text("${widget.description}",
                    style: TextStyle(color: Color(0xff989595), fontSize: 14),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        Colors.green,
                        Colors.white,
                      ],
                    )),
                child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>MemberSearchProfile(user_id: "${widget.user_id}",)));
                    },
                    child: Center(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(image.toString()),
                                            fit: BoxFit.fill),
                                        shape: BoxShape.circle
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Contact Person",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.36,
                                        height: 30,
                                        child: Text(first_name.toString()+" "+last_name.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                SizedBox(
                                  height: 60,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context)=>MemberSearchProfile(
                                              user_id: "${widget.user_id}")
                                      ));
                                    },
                                    child: Text(
                                      "View Profile",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      onPressed: () {
                                        // Navigator.push(context, MaterialPageRoute(
                                        //     builder: (context)=>BirthdayWish()));
                                      },
                                      icon: const Icon(
                                        Icons.double_arrow_outlined,
                                        color: Colors.blue,
                                      )),
                                ),
                              ],
                            )
                          ],
                        )
                    )
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Padding(
                padding: EdgeInsets.only(left: 22),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.48,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: Colors.black54,
                                width: 2.0, // This would be the width of the underline
                              ))),
                      child: Text(
                        "Upcomming Events",
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Montserrat",
                            fontSize: 18,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              event.length!=0?
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                height: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1
                    ),
                    itemCount: event.length,
                    itemBuilder: (BuildContext context,int index)
                    {
                      return Container(
                          width: 150,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Image.network(event[index]['img'].toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(event[index]['title'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black54),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text(event[index]['description'].toString(),
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                            color: Colors.black45),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                      );
                    }
                ),
              ):
              Text("No Event"),
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

