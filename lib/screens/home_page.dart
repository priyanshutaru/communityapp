import 'dart:convert';
import 'dart:developer';
import 'package:card_loading/card_loading.dart';
import 'package:communityapp/screens/Events/event_detail_screen.dart';
import 'package:communityapp/screens/Matrimony/metrimony_list.dart';
import 'package:communityapp/screens/News/news_catagory.dart';
import 'package:communityapp/screens/News/news_comments.dart';
import 'package:communityapp/screens/News/news_details.dart';
import 'package:communityapp/screens/auth/get_event_model.dart';
import 'package:communityapp/screens/auth/mymatrimony.dart' as m;
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/Utils/homepage.dart';
import 'package:communityapp/screens/Business/business_list.dart';
import 'package:communityapp/screens/Events/anniversery.dart';
import 'package:communityapp/screens/Blood/blood_bank_home.dart';
import 'package:communityapp/screens/Events/event_screen.dart';
import 'package:communityapp/screens/Matrimony/subscription_plan.dart';
import 'package:communityapp/screens/Vadval/hire_vadval.dart';
import 'package:communityapp/screens/Job/job_search_dream.dart';
import 'package:communityapp/screens/forum/open_forum.dart';
import 'package:communityapp/screens/generate_lead.dart';
import 'package:communityapp/screens/membersearch/member_search.dart';
import 'package:communityapp/screens/News/news_update.dart';
import 'package:communityapp/screens/sanskriti/sanskriti.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/get_news_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  String? news_time;
  String? news_dt_time;
  String formatTimeOfDay(news_time) {
    news_dt_time = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(news_time!));
    return " ${news_dt_time}";
  }


  String? event_time;
  String? event_dt_time;
  String eventformat_day(event_time) {
    event_dt_time = DateFormat.jm().format(DateFormat("hh:mm").parse(event_time!));
    return " ${event_dt_time}";
  }

  Future <List<Details>> get_Event() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={'user_id':user_id.toString()};
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_limit_event");
    // Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_event");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['details'];
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
    if (response.statusCode == 200) {
      setState(() {
        News_Categories = res['status_message'];
      });
    }
  }



  Future <List<Data>> getNews() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id':user_id.toString(),
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_news");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type":
    "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      return data.map((job) => Data.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }



  List banner=[];
  Future get_banner() async {
    Map data={'screen_id':'SC62737'};
    var url = Uri.parse("https://community.creditmywallet.in.net/api/get_banner");
    var body=jsonEncode(data);
    final response = await http.post(url,
        headers:{"Content-Type": "application/json"},body: body);
    var res =json.decode(response.body);
    setState(() {
      banner = res;
    });
  }



  var name;
  var img;
  Future get_user() async{
    final pref=await SharedPreferences.getInstance();
    var get=pref.getString('user_id');
    Map data={'user_id':get.toString()};
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_user_prof");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    var res=json.decode(response.body)['basic_details'];
    if(response.statusCode==200){
      setState(() {
        img = res['profile_img'];
        name = res['first_name'];
      });
    }
  }
  var subscribe_status1;
  Future Matrimoney_Statuss () async{
    final pref=await SharedPreferences.getInstance();
    var get=pref.getString('user_id');
    Map data={'user_id':get.toString()};
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/my_matrimony");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    var res=json.decode(response.body)['matrimony_status'];

    if(response.statusCode==200){
        setState(() {
        subscribe_status1 = res;
        print("mmmmamsmxmxmxmxmxmxmxm" + " = " + subscribe_status1.toString());

      });
    }
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
        icons="assets/images/sun_m.png";
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
        icons="assets/images/moon.png";
      });
    }}

   String?skin;
  // var subscribe_status1;
 // List<m.Response> ? subscribe_status = [];
 //  Future my_matrimony() async{
 //    final pref=await SharedPreferences.getInstance();
 //    var get=pref.getString('user_id');
 //    Map data={'user_id':get.toString()};
 //    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/my_matrimony");
 //    var body=jsonEncode(data);
 //    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
 //    var res=json.decode(response.body)['details'];
 //    // m.MyMatrimony result = m.MyMatrimony.fromJson(jsonDecode(response.body));
 //    print(res.toString());
 //    if(response.statusCode==200){
 //      setState(() {
 //        subscribe_status1 = res['matrimony_status'];
 //        print(res.toString());
 //      });
 //    }
 //  }
  @override
  void initState() {
    super.initState();
    setState(() {
      // my_matrimony();
      Matrimoney_Statuss();
      get_banner();
      get_user();
      time();
      get_News_Categories();
      getNews();
    });
    setState(() {
      get_News_Categories();
      getNews();
      get_Event();
      Matrimoney_Statuss();
      // my_matrimony();
    });
  }
  final keyIsFirstLoaded = 'is_first_loaded';
    showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (isFirstLoaded != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(image: AssetImage("assets/images/adsImg.png"),fit: BoxFit.fill)
              ),
              child: Material(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: IconButton(onPressed: (){
                          Navigator.of(context).pop();
                          prefs.setBool(keyIsFirstLoaded, false);
                          }, icon: Icon(Icons.clear,size: 40,color: Colors.white,)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
    return Scaffold(
      backgroundColor: Color(0xffF8F5F5),
      body: 
      img!='null'?
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: SafeArea(
           child: name != null? SingleChildScrollView(
             child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(img.toString(),
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(30)
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Row(
                            children: [
                              Text(good.toString()+" ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(name.toString(),style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 22,
                                width: 22,
                                child: Image.asset(icons.toString()),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    banner.length!=0?
                    Center(
                      child: CarouselSlider(
                        options: CarouselOptions(
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            autoPlay: true,
                            viewportFraction: 1),
                        items: banner.map((item) => Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(item),
                                      fit: BoxFit.cover)),
                            ))).toList(),
                      ),
                    ):
                    Text(""),
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
                     padding: EdgeInsets.only(left: 10, right: 10),
                     child: Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             InkWell(
                               onTap: () {
                                 Navigator.push(context, MaterialPageRoute(
                                     builder: (context)=>Anniversary()));
                               },
                               child: utils.listviewcard(
                                   text: "Birthday &\nAnniversary",
                                   Images: 'assets/images/birthday.png'),
                             ),
                             InkWell(
                                 onTap: () {
                                   Navigator.push(context, MaterialPageRoute(
                                       builder: (context)=>NewsUpdate()));
                                 },
                                 child: utils.listviewcard(
                                     text: "News",
                                     Images: 'assets/images/news.png')),
                             InkWell(
                                 onTap: () {
                                   //Get.to(EventScreen());
                                   Navigator.push(context, MaterialPageRoute(
                                       builder: (context)=>EventScreen()));
                                   },
                                 child: utils.listviewcard(
                                     text: "Events",
                                     Images: 'assets/images/events.png')),
                           ],
                         ),
                         SizedBox(
                           height: 10,
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             InkWell(
                                 onTap: () {
                                   if( subscribe_status1 == "0" )
                                     {
                                       Navigator.push(context, MaterialPageRoute(
                                           builder: (context)=>MatrimonyList(
                                             looking_for: '',
                                             height: '',
                                             skin_tone: '',
                                             moon_sign: '',
                                             sun_sign: '',
                                             qualification: '',
                                             profession: '',
                                             district: '',
                                            address_name: '',
                                             name: 'Simple',
                                           )));
                                     }
                                   else if(subscribe_status1== "1")
                                     {
                                         Navigator.push(context, MaterialPageRoute(
                                           builder: (context)=>SubscriptionPlan()));
                                     }
           
                                 },
                                 child: utils.listviewcard(
                                     text: "Matrimony",
                                     Images: 'assets/images/matrimony.png')
                             ),
                             InkWell(
                                 onTap: () {
                                   Navigator.push(context, MaterialPageRoute(
                                       builder: (context)=>BloodBankHome()));
                                 },
                                 child: utils.listviewcard(
                                     text: "Blood bank",
                                     Images: 'assets/images/bloodbank.png')),
                             InkWell(
                                 onTap: () {
                                   // Get.to(JobSearchDream());
                                   Navigator.push(context, MaterialPageRoute(
                                       builder: (context)=>JobSearchDream()));
                                 },
                                 child: utils.listviewcard(
                                     text: "Job Search",
                                     Images: 'assets/images/jobs.png')),
                           ],
                         ),
                         SizedBox(
                           height: 10,
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             GestureDetector(
                                 onTap: () {
                                   Navigator.push(context, MaterialPageRoute(
                                       builder: (context)=>BusinessList()));
                                 },
                                 child: utils.listviewcard(
                                     Images: 'assets/images/business.png',
                                     text: "   Vadval \nBussiness")),
                             GestureDetector(
                                 onTap: () {
                                   Navigator.push(context, MaterialPageRoute(
                                       builder: (context)=>MemberSearch()));
                                 },
                                 child: utils.listviewcard(
                                     text: "Member\n Search",
                                     Images: 'assets/images/membersearch.png')),
                             GestureDetector(
                                 onTap: () {
                                   Navigator.push(context, MaterialPageRoute(
                                       builder: (context)=>OpenForum()));
                                 },
                                 child: utils.listviewcard(
                                     text: "Open Forum",
                                     Images: 'assets/images/openforum.png')),
                           ],
                         ),
                         SizedBox(
                           height: 10,
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             InkWell(
                                 onTap: () {
                                   //Get.to(VadavalSanskriti());
                                   Navigator.push(context, MaterialPageRoute(
                                       builder: (context)=>VadavalSanskriti()));
                                 },
                                 child: utils.listviewcard(
                                     text: "   Vadval\n Sanskriti",
                                     Images: 'assets/images/matrimony.png')),
                             InkWell(
                                 onTap: () {
                                   Navigator.push(context, MaterialPageRoute(
                                       builder: (context)=>HireAVadval(
                                        
                                       )));
                                 },
                                 child: utils.listviewcard(
                                     text: "Hire a Vadval",
                                     Images: 'assets/images/bloodbank.png')),
                             InkWell(
                                 onTap: () {
                                   Navigator.push(context, MaterialPageRoute(
                                       builder: (context)=>GenerateLead()));
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
                   height: 10,
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
                             news_time=data[index].addedTime.toString();
                             return InkWell(
                               onTap: () {
                                 Navigator.push(context, MaterialPageRoute(
                                     builder: (context) =>
                                         NewsDetails(
                                           news_id: data[index].newsId.toString(),
                                           tittle5: data[index].categoryName.toString(),
                                           to_comment: data[index].comments.toString(),
                                         )
                                 )
                                 );
                               },
                               child: Container(
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
                                                           style: TextStyle(
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
                                                       Text(formatTimeOfDay(news_time).toString(),
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
                                                 var dio1 = Dio();
                                                 final pref=await SharedPreferences.getInstance();
                                                 var user_id=pref.getString('user_id');
                                                 var formData = FormData.fromMap({
                                                   'user_id': user_id,
                                                   'news_id':data[index].newsId.toString(),
                                                 });
                                                 print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                 var response = await dio1.post('https://community.creditmywallet.in.net/api/like_news',
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
                                                       builder: (context)=>NewsComments(
                                                         post_id: data[index].newsId.toString(),
                                                         total_comment: data[index].comments.toString(),)
                                                   ));
                                                 },
                                                 icon: Icon(Icons.comment_bank_outlined)
                                             ),

                                             Text(data[index].comments.toString()),
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
                                   ),
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
                             Navigator.push(context, MaterialPageRoute(
                                 builder: (context)=>NewsCatagory(
                                   Categorey_id: News_Categories[index]['category_id'].toString(),
                                   tittle5: News_Categories[index]['category_name'].toString(),
                                 )));
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
                               childAspectRatio: 8.1/ 8,
                               mainAxisSpacing: 0,
                               crossAxisSpacing: 1,
                               crossAxisCount: 2
                           ),
                           itemBuilder: (BuildContext, int index) {
                             event_time=data[index].eventTime.toString();
                             return InkWell(
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(
                                     builder: (context)=>EventDetailSscreen(
                                       event_id: data[index].eventId.toString(),
                                       user_id: data[index].host.toString(),
                                       description: data[index].description.toString(),
                                       date:data[index].eventDate.toString(),
                                       time:data[index].eventTime.toString(),
                                       city:data[index].city.toString(),
                                       state:data[index].location.toString(),
                                       title:data[index].title.toString(),
                                       img:data[index].img.toString(),
                                       firstname:data[index].name.toString()
                                     )
                                 ));
                               },
                               child: Padding(
                                   padding: EdgeInsets.only(left: 8),
                                   child: Container(
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         Card(
                                           shape:
                                           RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                           child: Container(
                                             height: MediaQuery.of(context).size.height * 0.16,
                                             width: MediaQuery.of(context).size.width * 0.58,
                                             decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(20),
                                                 image: DecorationImage(
                                                     image: NetworkImage(data[index].img.toString()),
                                                     fit: BoxFit.fill
                                                 )
                                             ),
                                           ),
                                         ),
                                         Padding(
                                           padding: EdgeInsets.only(left: 0),
                                           child: Container(
                                             width: MediaQuery.of(context).size.width * 0.4,
                                             child: Text(data[index].title.toString(),
                                               style: TextStyle(
                                                   fontSize: 13,
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
                                                 Text(eventformat_day(event_time).toString(),
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
                               ),
                             );
                           },
                         ):
                         Text("No Events") ;
                       }
                       return Text("No Events");
                     })
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
                               height: 68,
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
                         Text( 'Refreshing Home...',style: TextStyle(color: Colors.pink,fontSize: 17),),
                       ]
                   ),
                 ],
               )
         ),
       )
             :
             // BottomSheet(onClosing: (){}, builder: ((context){
             //   return Padding(
             //     padding: const EdgeInsets.all(15.0),
             //     child: Container(
             //       height: MediaQuery.of(context).size.height*0.83,
             //       width: MediaQuery.of(context).size.width,
             //       decoration: BoxDecoration(
             //         image: DecorationImage(image: AssetImage("assets/images/adsImg.png"),fit: BoxFit.fill)
             //       ),
             //       child: Row(
             //         mainAxisAlignment: MainAxisAlignment.end,
             //         children: [
             //           Column(
             //             crossAxisAlignment: CrossAxisAlignment.end,
             //             children: [
             //               Padding(
             //                 padding: const EdgeInsets.all(8.0),
             //                 child: Container(
             //                   height: 40,width: 40,color: Colors.red,
             //                   child: Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.clear,size: 40,color: Colors.white,)))),
             //               ),
             //             ],
             //           )
             //         ],
             //       ),
             //     ),
             //   );
             // }):

       CardLoading(
         height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         borderRadius: BorderRadius.all(Radius.circular(0)),
       ),
    );
  }
  Future ads()async{
   return Container(
    child: BottomSheet(onClosing: (){}, builder: ((context){
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.83,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/images/adsImg.png"),fit: BoxFit.fill)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 40,width: 40,color: Colors.red,
                                  child: Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.clear,size: 40,color: Colors.white,)))),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                })),
   );
  }
}

