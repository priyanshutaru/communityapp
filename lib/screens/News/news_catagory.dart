import 'dart:convert';
import 'package:communityapp/screens/News/news_comments.dart';
import 'package:communityapp/screens/auth/get_news_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/News/news_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsCatagory extends StatefulWidget {
  String? Categorey_id,tittle5;
  NewsCatagory({required this.Categorey_id,required this.tittle5});

  @override
  State<NewsCatagory> createState() => _NewsCatagoryState();
}

class _NewsCatagoryState extends State<NewsCatagory> {
  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC31845',
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

  Future <List<Data>> getNews() async{
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      "user_id":user_id.toString(),
      "category_id": "${widget.Categorey_id}"
    };
    print("gigyigyigyi"+data.toString());
    Uri url=Uri.parse("https://community.creditmywallet.in.net/api/get_category_news");
    var body1=jsonEncode(data);
    final response = await http.post(url,headers:{"Content-Type": "application/json"},body:body1);
    print(response);
    if(response.statusCode==200){
      List data=json.decode(response.body)['data'];
      return data.map((job) =>  Data.fromJson(job)).toList();
    }
    else{
      throw Exception('Unexpected error occured!');
    }
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffEEEEEE),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          toolbarHeight: 70,
          title: Text("${widget.tittle5}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xff000000)),
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
        ),
        body:  Column(
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
              FutureBuilder <List<Data>>(
                  future: getNews(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      List<Data>? data = snapshot.data;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            news_time=data[index].addedTime.toString();
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>NewsDetails(
                                      news_id: data[index].newsId.toString(),
                                      tittle5: data[index].categoryName.toString(),
                                      to_comment: data[index].comments.toString(),
                                    )
                                )
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: Card(
                                  color: Color(0xffFCFCFC),
                                  shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  elevation: 2,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.35,
                                                  height: 35,
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(30)),
                                                    color: Color(0xffF6F6F6),
                                                    child: Center(
                                                        child: Text(
                                                          data[index].categoryName.toString(),
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.w500, fontSize: 12),
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                    width: MediaQuery.of(context).size.width * 0.55,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(left: 10),
                                                      child: Text(data[index].title.toString(),
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
                                                    image: NetworkImage(data[index].img.toString()),
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
                                                onPressed: (){},
                                                icon: Icon(Icons.share)
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Text("No News");
                  })
            ]
        )
    );
  }
}


