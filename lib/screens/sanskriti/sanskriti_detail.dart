import 'dart:convert';
import 'package:communityapp/screens/auth/sanskriti_details_model.dart';
import 'package:communityapp/screens/comments.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SanskritiDetail extends StatefulWidget {
  String? post_id;


  SanskritiDetail({required this.post_id});

  @override
  State<SanskritiDetail> createState() => _SanskritiDetailState();
}

class _SanskritiDetailState extends State<SanskritiDetail> {


  String? like;
  int? cr_likle;

  Future <List<ResponseUserRegister>> sanskriti_details() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      "user_id":user_id.toString(),
      "post_id":"${widget.post_id.toString()}"
    };
    print(data.toString());
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/sanskriti_post_details");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type":
    "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      print(data);
      return data.map((job) => ResponseUserRegister.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC89944',
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

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffEEEEEE),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Sanskriti Details",
          style: TextStyle(
              color: Color(0xff000000),
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              children: [
                FutureBuilder <List<ResponseUserRegister>>(
                    future: sanskriti_details(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ResponseUserRegister>? data = snapshot.data;
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: data!.length,
                          itemBuilder: (BuildContext context, int index) {
                           return Container(
                               width: MediaQuery.of(context).size.width * 0.9,
                               height: MediaQuery.of(context).size.height,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height*0.2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(data[index].img.toString()),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    height: 19.58,
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
                                              'sanskriti_post_id':data[index].sansPostId.toString(),
                                            });
                                            print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                            var response = await dio1.post('https://community.creditmywallet.in.net/api/like_sanskriti_post',
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
                                                  builder: (context)=>Comments(userid: data[index].userId.toString(),
                                                    post_id: data[index].sansPostId.toString(),
                                                    total_comme: data[index].countComment.toString(),)));
                                            },
                                            icon: Icon(Icons.comment_bank_outlined)
                                        ),

                                        Text(data[index].countComment.toString()),
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(data[index].title.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff000000)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 11,
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width * 0.9,
                                      height: MediaQuery.of(context).size.height * 0.15,
                                      child: Text(data[index].discussionTopic.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Color(0xff000000)),
                                      )),
                                  SizedBox(
                                    height: 46,
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
                                    height: 37,
                                  )
                                ],
                              )
                            );
                          },
                        );
                      }
                      return Center(
                        child: Text("No Details"),
                      );
                    }),
              ],
            )
        ),
      ),
    );
  }
}
