import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/News/news_catagory.dart';
import 'package:communityapp/screens/News/news_comments.dart';
import 'package:communityapp/screens/News/news_details.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/auth/get_news_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsUpdate extends StatefulWidget {
  const NewsUpdate({Key? key}) : super(key: key);

  @override
  State<NewsUpdate> createState() => _NewsUpdateState();
}

class _NewsUpdateState extends State<NewsUpdate> {
  

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

      print(data);

      return data.map((job) => Data.fromJson(job)).toList();
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

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC97125',
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

  String? news_time;
  String? news_dt_time;
  String formatTimeOfDay(news_time) {
    news_dt_time = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(news_time!));
    return " ${news_dt_time}";
  }

  @override
  void initState() {
    super.initState();
    get_banner();
    getNews();
    get_News_Categories();
    // setState(() {
    //   get_banner();
    //   getNews();
    //   get_News_Categories();
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF8F5F5),
        appBar: AppBar(
          backgroundColor: Colors.brown[50],
          toolbarHeight: 70,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            "News & Updates",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xff000000),
            ),
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)
              )
          ),
        ),
        body: Banner.length!=0? SingleChildScrollView(
            child: Column(
                children: [
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
                                  "Popular Topics",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w700),
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
                              child: Row(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 125,
                                      child: Card(
                                        color: Color(0xfffD9D9D9),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)),
                                        elevation: 1,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.08,
                                              width: MediaQuery.of(context).size.width * 0.18,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: NetworkImage(News_Categories[index]['category_img'].toString()),
                                                      fit: BoxFit.cover)),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),

                                            Text(News_Categories[index]['category_name'].toString(),textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 12,
                                                    color: Color(0xff3E3E3E))),
                                          ],
                                        ),
                                      )
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  ):
                      Text("No Popular Topics"),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 25,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.07,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  )
                              )
                          ),
                          child: Text(
                            "All",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width/1.23,
                          height: 25.0,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: News_Categories.length,
                              itemBuilder: (BuildContext context,int index)
                              {
                                return Container(
                                  margin: EdgeInsets.only(left: 7),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context)=>NewsCatagory(
                                            Categorey_id: News_Categories[index]['category_id'].toString(),
                                            tittle5: News_Categories[index]['category_name'].toString(),
                                          )));
                                    },
                                    child: Text(News_Categories[index]['category_name'].toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff000000)),
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
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
                              news_time=data[index].addedTime.toString();
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          NewsDetails(
                                            news_id: data[index].newsId.toString(),
                                            tittle5: data[index].categoryName.toString(),
                                            to_comment: data[index].comments.toString(),


                                          ))
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.95,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
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
                                                    // height: 35,
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
                                                      width: MediaQuery.of(context).size
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
                                                      )
                                                  ),
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
                                                        Container(
                                                          width: MediaQuery.of(context).size.width*0.25,
                                                          child:Text(
                                                            data[index].title.toString(),
                                                            style: TextStyle(fontSize: 10),
                                                          ) ,
                                                        ),
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
                                                    'user_id': user_id.toString(),
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
                                                          total_comment: data[index].comments.toString(),
                                                        )
                                                    ));
                                                  },
                                                  icon: Icon(Icons.comment_bank_outlined)
                                              ),

                                              Text(data[index].comments.toString()),
                                              Spacer(),
                                              IconButton(
                                                  onPressed: () async{
                                                    await Share.share(data[index].img.toString()+"\n"+ data[index].title.toString()+"\n"+"https://httpscommunity.page.link/community_share");
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
                      })
                  // Column(
                  //   children: [
                  //     InkWell(
                  //       onTap: () {
                  //         Navigator.push(context, MaterialPageRoute(
                  //             builder: (context)=>NewsCatagory(
                  //               Categorey_id: '',
                  //               tittle5: '',
                  //             )));
                  //       },
                  //       child: FutureBuilder <List<Data>>(
                  //           future: getNews(),
                  //           builder: (context, snapshot) {
                  //             if (snapshot.hasData) {
                  //               List<Data>? data = snapshot.data;
                  //               return GridView.builder(
                  //                 shrinkWrap: true,
                  //                 physics: NeverScrollableScrollPhysics(),
                  //                 itemCount: data!.length,
                  //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //                     childAspectRatio: 7.7 / 4,
                  //                     mainAxisSpacing: 4,
                  //                     crossAxisSpacing: 3,
                  //                     crossAxisCount: 1),
                  //                 itemBuilder: (BuildContext, int index) {
                  //                   news_time=data[index].addedTime.toString();
                  //                   return InkWell(
                  //                     onTap: () {
                  //                       Navigator.push(context, MaterialPageRoute(
                  //                           builder: (context) =>
                  //                               NewsDetails(
                  //                                 news_id: data[index].newsId.toString(),
                  //                                 tittle5: data[index].categoryName.toString(),
                  //                                 to_comment: data[index].comments.toString(),
                  //                               ))
                  //                       );
                  //                     },
                  //                     child: Container(
                  //                       width: MediaQuery.of(context).size.width * 0.95,
                  //                       padding: EdgeInsets.symmetric(horizontal: 5),
                  //                       child: Card(
                  //                         color: Color(0xffFCFCFC),
                  //                         shape:
                  //                         RoundedRectangleBorder(
                  //                             borderRadius: BorderRadius.circular(10)),
                  //                         elevation: 2,
                  //                         child: Column(
                  //                           children: [
                  //                             Row(
                  //                               children: [
                  //                                 Container(
                  //                                   width: MediaQuery
                  //                                       .of(context)
                  //                                       .size
                  //                                       .width * 0.6,
                  //                                   child: Column(
                  //                                     crossAxisAlignment: CrossAxisAlignment
                  //                                         .start,
                  //                                     children: [
                  //                                       Container(
                  //                                         width: MediaQuery
                  //                                             .of(context)
                  //                                             .size
                  //                                             .width * 0.35,
                  //                                         height: 35,
                  //                                         child: Card(
                  //                                           shape: RoundedRectangleBorder(
                  //                                               borderRadius: BorderRadius
                  //                                                   .circular(
                  //                                                   30)),
                  //                                           color: Color(0xffF6F6F6),
                  //                                           child: Center(
                  //                                               child: Text(
                  //                                                 data[index].categoryName
                  //                                                     .toString(),
                  //                                                 style: const TextStyle(
                  //                                                     fontWeight: FontWeight.w500,
                  //                                                     fontSize: 12),
                  //                                               )),
                  //                                         ),
                  //                                       ),
                  //                                       SizedBox(
                  //                                         height: 10,
                  //                                       ),
                  //                                       Container(
                  //                                           width: MediaQuery
                  //                                               .of(context)
                  //                                               .size
                  //                                               .width * 0.55,
                  //                                           child: Padding(
                  //                                             padding: EdgeInsets.only(left: 10),
                  //                                             child: Text(
                  //                                               data[index].title.toString(),
                  //                                               style: TextStyle(
                  //                                                   color: Color(0xff000000),
                  //                                                   fontWeight: FontWeight.w700,
                  //                                                   fontSize: 14),
                  //                                             ),
                  //                                           )
                  //                                       ),
                  //                                       SizedBox(
                  //                                         height: 10,
                  //                                       ),
                  //                                       Padding(
                  //                                         padding: EdgeInsets.only(left: 10),
                  //                                         child: Row(
                  //                                           children: [
                  //                                             Text(
                  //                                               "Republic",
                  //                                               style: TextStyle(fontSize: 10),
                  //                                             ),
                  //                                             SizedBox(
                  //                                               width: 5,
                  //                                             ),
                  //                                             Spacer(),
                  //                                             Text(formatTimeOfDay(news_time).toString(),
                  //                                               style: TextStyle(fontSize: 10),
                  //                                             ),
                  //                                             SizedBox(
                  //                                               width: 15,
                  //                                             ),
                  //                                             Text(
                  //                                               data[index].addedDate.toString(),
                  //                                               style: TextStyle(fontSize: 10),
                  //                                             )
                  //                                           ],
                  //                                         ),
                  //                                       )
                  //                                     ],
                  //                                   ),
                  //                                 ),
                  //                                 Spacer(),
                  //                                 Container(
                  //                                   margin: EdgeInsets.only(top: 15),
                  //                                   width: MediaQuery.of(context).size.width * 0.25,
                  //                                   height: MediaQuery.of(context).size.height * 0.15,
                  //                                   decoration: BoxDecoration(
                  //                                       borderRadius: BorderRadius.circular(10),
                  //                                       image: DecorationImage(
                  //                                           image: NetworkImage(
                  //                                               data[index].img.toString()),
                  //                                           fit: BoxFit.fill
                  //                                       )
                  //                                   ),
                  //                                 ),
                  //                                 SizedBox(
                  //                                   width: 20,
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                             Padding(
                  //                               padding: EdgeInsets.only(left: 15, right: 15),
                  //                               child: Row(
                  //                                 children: [
                  //                                   IconButton(
                  //                                     onPressed: () async{
                  //                                       var dio1 = Dio();
                  //                                       final pref=await SharedPreferences.getInstance();
                  //                                       var user_id=pref.getString('user_id');
                  //                                       var formData = FormData.fromMap({
                  //                                         'user_id': user_id,
                  //                                         'news_id':data[index].newsId.toString(),
                  //                                       });
                  //                                       print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                  //                                       var response = await dio1.post('https://community.creditmywallet.in.net/api/like_news',
                  //                                           data: formData);
                  //                                       var res=response.data;
                  //                                       setState((){
                  //                                         print(response.toString()+"%%^^^&*()");
                  //                                         var like=res["reaponse_data"];
                  //                                       });
                  //                                       setState(() {
                  //
                  //                                       });
                  //                                     },
                  //                                     icon: data[index].likeStatus!="0"?
                  //                                     Icon(Icons.favorite_border):
                  //                                     Icon(Icons.favorite,color: Colors.red,),
                  //                                   ),
                  //
                  //                                   Text(data[index].likes.toString()),
                  //                                   Spacer(),
                  //                                   IconButton(
                  //                                       onPressed: (){
                  //                                         Navigator.push(context, MaterialPageRoute(
                  //                                             builder: (context)=>NewsComments(
                  //                                               post_id: data[index].newsId.toString(),
                  //                                               total_comment: data[index].comments.toString(),
                  //                                             )
                  //                                         ));
                  //                                       },
                  //                                       icon: Icon(Icons.comment_bank_outlined)
                  //                                   ),
                  //
                  //                                   Text(data[index].comments.toString()),
                  //                                   Spacer(),
                  //                                   IconButton(
                  //                                       onPressed: () async{
                  //                                         await Share.share(data[index].img.toString()+"\n"+ data[index].title.toString()+"\n"+"https://httpscommunity.page.link/community_share");
                  //                                       },
                  //                                       icon: Icon(Icons.share)
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   );
                  //                 },
                  //               );
                  //             }
                  //             return Text("No News");
                  //           })
                  //     ),
                  //     SizedBox(
                  //       height: 10,
                  //     ),
                  //   ],
                  // )
                ]
            )
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
                  Text( 'Updating News...',style: TextStyle(color: Colors.pink,fontSize: 17),),
                ]
            ),
          ],
        )
    );
  }

    Widget _NewsUpdate() {
      return FutureBuilder <List<Data>>(
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
                              ))
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      padding: EdgeInsets.symmetric(horizontal: 5),
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
                                          )
                                      ),
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
                                              total_comment: data[index].comments.toString(),
                                            )
                                        ));
                                      },
                                      icon: Icon(Icons.comment_bank_outlined)
                                  ),

                                  Text(data[index].comments.toString()),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () async{
                                        await Share.share(data[index].img.toString()+"\n"+ data[index].title.toString()+"\n"+"https://httpscommunity.page.link/community_share");
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
          });
    }
  }

