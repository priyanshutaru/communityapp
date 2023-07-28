import 'dart:convert';
import 'package:communityapp/screens/Events/event_coment.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Events/event_detail_screen.dart';
import 'package:communityapp/screens/auth/get_event_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {


  Future <List<Details>> get_Event() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id':user_id.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_event");
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

  Future <List<Details>> search_event() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id':user_id,
      'city_id':district.toString(),
      'event_date':dob.toString()
    };
    print(district.toString());
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/search_event");
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

  String? dob;
  late DateTime _myDateTime;

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC91729',
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

  String? location;
  String? district;
  List get_city_list=[];
  Future  get_city() async{
    var url="https://community.creditmywallet.in.net/api/get_state";
    http.Response response=await http.post(Uri.parse(url));
    var res=jsonDecode(response.body)['state'];
    setState(() {
      print("%%%%%%%%%%%%"+res.toString());
      get_city_list=res;
      print(get_city_list.toString()+"%%%%%%%%%%%%%%%%");
    });

  }
  List get_district_list=[];
  Future  get_District() async{
    Map data={
      "state_id":location.toString(),
    };
    setState(() {
    });
    var url="https://community.creditmywallet.in.net/api/get_dist";
    var body1=jsonEncode(data);
    http.Response response=await http.post(Uri.parse(url),headers: {"Content-Type":"application/json"}, body: body1);
    var res=jsonDecode(response.body)['state'];
    setState(() {
      print("%%%%%FFFFFFFFFFFf%%%%%%%"+res.toString());
      get_district_list=res;
      print(get_district_list.toString()+"%%%%%%%%%%%%%%%%");
    });

  }

  String? event_time;
  String? event_dt_time;
  String eventformat_day(event_time) {
    event_dt_time = DateFormat.jm().format(DateFormat("hh:mm").parse(event_time!));
    return " ${event_dt_time}";
  }

  @override
  void initState() {
    super.initState();
    get_banner();
    get_city();
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
          "Events",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xff000000),
              fontSize: 16),
        ),
      ),
      body:  Banner.length!=0? SafeArea(
        child: Column(
          children: [
            Banner.length!=0?
            Center(
              child: CarouselSlider(
                options: CarouselOptions(
                    aspectRatio: 2.2,
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
              height: 7,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3, bottom: 3),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: location,
                    hint: Text("      State"),
                    icon: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    items: get_city_list.map((item) {
                      return DropdownMenuItem(
                        value: item['state_id'].toString(),
                        child: Padding(
                          padding:  EdgeInsets.only(left: 30),
                          child: Text(
                            item['state_title'].toString(),
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        setState((){
                          location = newValue! as String?;
                          print(location.toString());
                          get_District();
                        });
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3, bottom: 3),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: district,
                    hint: Text("      District"),
                    icon: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    items: get_district_list.map((item) {
                      return DropdownMenuItem(
                        value: item['districtid'].toString(),
                        child: Padding(
                          padding:  EdgeInsets.only(left: 30),
                          child: Text(
                            item['district_title'].toString(),
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        setState((){
                          district = newValue! as String?;
                          print(district.toString());
                        });
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
               InkWell(
              onTap: () async{
                _myDateTime= (await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2050),
                ))!;
                setState(() {
                  dob=DateFormat('yyyy-MM-dd').format(_myDateTime);
                });
              },
              child: Padding(
                padding:  EdgeInsets.only(top: 3, bottom: 3),
                child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 18,
                        ),
                        Container(
                            child: Image.asset(
                              "assets/images/year.png",
                              height: 22,
                            )
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        dob!=null?
                        Text(dob.toString()):
                        Text("Date"),
                      ],
                    )
                ),
              ),
            ),
            dob==null?
            FutureBuilder <List<Details>>(
                future: get_Event(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Details>? data = snapshot.data;
                    return data?.length!=0 ?
                    Expanded(
                        child: ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        event_time=data[index].eventTime.toString();
                        return  InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>EventDetailSscreen(
                                  event_id: data[index].eventId.toString(),
                                  user_id: data[index].host.toString(),
                                  description: data[index].description.toString(),
                                  time: data[index].eventTime.toString(),
                                  date: data[index].eventDate.toString(),
                                  profileImg:data[index].profileImg.toString(),
                                  city: data[index].city.toString(),
                                  img: data[index].img.toString(),
                                  state: data[index].location.toString(),
                                  title: data[index].title.toString(),
                                  firstname: data[index].firstName.toString(),
                                  lastname: data[index].lastName.toString(),
                                )
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Card(
                                color: Color(0xffF5F1F1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 2,
                                child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 20),
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(data[index].profileImg.toString()),
                                                        fit: BoxFit.fill),
                                                  shape: BoxShape.circle
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 11,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(data[index].firstName.toString()+" "+data[index].lastName.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14,
                                                      color: Color(0xff000000)),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right: 100),
                                                  child: Text(data[index].addedDate.toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Color(0xff979797)),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: EdgeInsets.only(right: 15),
                                              child: Icon(Icons.arrow_forward_ios),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Row(
                                            children: [
                                              Text(data[index].title.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Color(0xff615F5F)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3.56,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month,
                                                size: 17,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(data[index].eventDate.toString()+"  at  "+eventformat_day(event_time).toString(),
                                                style: TextStyle(
                                                    color: Color(0xffFF8900),
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // height: 70,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 22, top: 6.29, right: 20),
                                            child: Text(data[index].description.toString(),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff989595)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 15, right: 15),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () async{
                                                  var dio1 = Dio();
                                                  final pref=await SharedPreferences.getInstance();
                                                  var user_id=pref.getString('user_id');
                                                  var formData = FormData.fromMap({
                                                    'user_id': user_id.toString(),
                                                    'event_id':data[index].eventId.toString(),
                                                  });
                                                  print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                  var response = await dio1.post('https://community.creditmywallet.in.net/api/like_event',
                                                      data: formData);
                                                  var res=response.data;
                                                  setState((){
                                                    print(response.toString()+"%%^^^&*()");
                                                    var like=res["reaponse_data"];
                                                  });
                                                  setState(() {

                                                  });
                                                },
                                                icon: data[index].likeStatus!="0"?
                                                Icon(Icons.favorite_border):
                                                Icon(Icons.favorite,color: Colors.red,),
                                              ),
                                              Text(data[index].likes.toString()),
                                              Spacer(),
                                              IconButton(
                                                  onPressed: (){
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context)=>event_Comment(
                                                          event_id: data[index].eventId.toString(),
                                                          comment_count: data[index].totalComments.toString(),)
                                                    ));
                                                  },
                                                  icon: Icon(Icons.comment_bank_outlined)
                                              ),

                                              Text(data[index].totalComments.toString()),
                                              Spacer(),
                                              IconButton(
                                                  onPressed: () async{
                                                    await Share.share(data[index].img.toString()+"\n"+
                                                        data[index].title.toString()+"\n"+
                                                        "https://httpscommunity.page.link/community_share");
                                                  },
                                                  icon: Icon(Icons.share)
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    )
                              ),
                            ),
                          ),
                        );
                      },
                    )
                    ):

                    Text("No Event");
                  }
                  return Text("No Event");
                }
                )
                :
                FutureBuilder <List<Details>>(
                future: search_event(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Details>? data = snapshot.data;
                    return data?.length!=0?
                    Expanded(
                        child: ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return  InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>EventDetailSscreen(
                                      event_id: data[index].eventId.toString(),
                                      user_id: data[index].host.toString(),
                                      description: data[index].description.toString(),
                                    )
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  // width: MediaQuery.of(context).size.width * 0.9,
                                  child: Card(
                                      color: Color(0xffF5F1F1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)),
                                      elevation: 2,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: 20),
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(data[index].profileImg.toString()),
                                                          fit: BoxFit.fill),
                                                      shape: BoxShape.circle
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 11,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(data[index].firstName.toString()+" "+data[index].lastName.toString(),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Color(0xff000000)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 100),
                                                    child: Text(data[index].addedDate.toString(),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color(0xff979797)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: EdgeInsets.only(right: 15),
                                                child: Icon(Icons.arrow_forward_ios),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: [
                                                Text(data[index].title.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14,
                                                      color: Color(0xff615F5F)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3.56,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_month,
                                                  size: 17,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(data[index].eventDate.toString()+"  at  "+data[index].eventTime.toString(),
                                                  style: TextStyle(
                                                      color: Color(0xffFF8900),
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            // height: 70,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 22, top: 6.29, right: 20),
                                              child: Text(data[index].description.toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff989595)),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 15, right: 15),
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () async{
                                                    var dio1 = Dio();
                                                    final pref=await SharedPreferences.getInstance();
                                                    var user_id=pref.getString('user_id');
                                                    var formData = FormData.fromMap({
                                                      'user_id': user_id,
                                                      'event_id':data[index].eventId.toString(),
                                                    });
                                                    print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                    var response = await dio1.post('https://community.creditmywallet.in.net/api/like_event',
                                                        data: formData);
                                                    var res=response.data;
                                                    setState((){
                                                      print(response.toString()+"%%^^^&*()");
                                                      var like=res["reaponse_data"];
                                                    });
                                                    setState(() {

                                                    });
                                                  },
                                                  icon: data[index].likeStatus!="0"?
                                                  Icon(Icons.favorite_border):
                                                  Icon(Icons.favorite,color: Colors.red,),
                                                ),
                                                Text(data[index].likes.toString()),
                                                Spacer(),
                                                IconButton(
                                                    onPressed: (){
                                                      Navigator.push(context, MaterialPageRoute(
                                                          builder: (context)=>event_Comment(
                                                            event_id: data[index].eventId.toString(),
                                                            comment_count: data[index].totalComments.toString(),)
                                                      ));
                                                    },
                                                    icon: Icon(Icons.comment_bank_outlined)
                                                ),

                                                Text(data[index].totalComments.toString()),
                                                Spacer(),
                                                IconButton(
                                                    onPressed: () async{
                                                      await Share.share(data[index].img.toString()+"\n"+
                                                          data[index].title.toString()+"\n"+
                                                          "https://httpscommunity.page.link/community_share");
                                                    },
                                                    icon: Icon(Icons.share)
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      )
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                    ):
                    Text("No Events");
                  }
                  return Text("No Events");
                }),
          ],
        ),
      ):  Row(
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
                Text( 'Loading Events...',style: TextStyle(color: Colors.pink,fontSize: 17),),
              ]
          ),
        ],
      )
    );
  }
}
