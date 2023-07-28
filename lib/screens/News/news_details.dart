import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/News/news_comments.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/get_news_details_model.dart';

class NewsDetails extends StatefulWidget {
  String? news_id,tittle5,to_comment;
  NewsDetails({
    required this.news_id,
    required this.tittle5,
    required this.to_comment,


  });

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  String? likeStatus;
  String? tittle;
  String? img;
  String? description;
  Future getNewsDetails() async{
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      "news_id": "${widget.news_id}".toString(),
      'user_id':user_id.toString()
    };
    Uri url=Uri.parse("https://community.creditmywallet.in.net/api/get_news_details");
    print("^^^^^^^^"+data.toString()+url.toString());
    var body1=jsonEncode(data);
    var response = await http.post(url,headers: {"Content-Type":"application/json"}, body:body1);
      var res=jsonDecode(response.body)['status_message'];
      setState((){
        tittle=res['title'];
        img=res['img'];
        description=res['description'];
      });
  }


  Future <List<StatusMessage>> news_details() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      "news_id": "${widget.news_id}".toString(),
      'user_id':user_id.toString()
    };
    Uri url=Uri.parse("https://community.creditmywallet.in.net/api/get_news_details");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type":
    "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['status_message'];
      return data.map((job) => StatusMessage.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xffF8F5F5),
        elevation: 0,
        leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
        title: Text("${widget.tittle5}",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body : Container(
        height: MediaQuery.of(context).size.height*0.9,
        child: FutureBuilder <List<StatusMessage>>(
              future: news_details(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<StatusMessage>? data = snapshot.data;
                  return data?.length!=0?
                  ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      likeStatus=data[index].likeStatus.toString();
                      return Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 11,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(data[index].title.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff000000)),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 229,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(data[index].img.toString()),
                                    fit: BoxFit.fill
                                )
                            ),
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              children: [
                                Container(
                                  // height: MediaQuery.of(context).size.height*0.33,
                                  child: Text(data[index].description.toString(),
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)
                                    ,   textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(
                                  height: 78,
                                ),
                                
                                Container(
                                  height: 60,

                                  decoration: BoxDecoration(
                                      color: Color(0xffE8E6E6),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20, right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () async{
                                            var dio1 = Dio();
                                            final pref=await SharedPreferences.getInstance();
                                            var user_id=pref.getString('user_id');
                                            var formData = FormData.fromMap({
                                              'user_id': user_id,
                                              'news_id':"${widget.news_id}"
                                            });
                                            print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                            var response = await dio1.post('https://community.creditmywallet.in.net/api/like_news',
                                                data: formData);
                                            var res=response.data;
                                            setState((){
                                              print(response.toString()+"%%^^^&*()");
                                              var like=res["reaponse_data"];
                                            });
                                          },
                                          icon: data[index].likeStatus!="0"?
                                          Icon(Icons.favorite_border):
                                          Icon(Icons.favorite,color: Colors.red,),
                                        ),

                                         Text(data[index].likes.toString()),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context)=>NewsComments(
                                                  post_id: "${widget.news_id}",
                                                  total_comment: "${widget.to_comment}",)
                                            ));
                                          },
                                          child: Container(
                                              height: 40,
                                              width: MediaQuery.of(context).size.width * 0.55,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 106, 150, 226),
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child:
                                              Center(
                                                child:  Text("Add a Comment",
                                                  style:  TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white70,
                                                      fontWeight: FontWeight.w700),),
                                              )
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async{
                                            await Share.share(img.toString()+"\n"+
                                                tittle.toString()+"\n"+
                                                "https://httpscommunity.page.link/community_share");
                                          },
                                          child: Container(
                                              height: 40,
                                              child: Image.asset(
                                                "assets/images/share1.png",
                                                height: 30,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ):
                  Text("No News Details") ;
                }
                return Text("No News Details");
              }),
      ),
    );
  }
}
