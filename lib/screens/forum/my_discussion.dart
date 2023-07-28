import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/forum/post_forum.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDiscussion extends StatefulWidget {
  const MyDiscussion({Key? key}) : super(key: key);

  @override
  State<MyDiscussion> createState() => _MyDiscussionState();
}

class _MyDiscussionState extends State<MyDiscussion> {

  List my_discussion=[];
  Future my_discussin_topic() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id':user_id.toString()
    };
    var url = Uri.parse("https://community.creditmywallet.in.net/api/view_forum_list");
    var body=jsonEncode(data);
    final response = await http.post(url,headers:{"Content-Type": "application/json"},body:body
    );
    var res = await json.decode(response.body);
    print("response12" + response.body);

    if (response.statusCode == 200) {
      setState(() {
        my_discussion = res['response_data'];
        print("%%%%%%%%%%5555"+my_discussion.toString());
      });
    }
  }

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC96774',
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
    setState(() {
      my_discussin_topic();
    });
    setState(() {
      get_banner();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF8F5F5),
        appBar: AppBar(
          backgroundColor: Colors.brown[50],
          toolbarHeight: 70,
          leading:  IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Padding(
              padding: EdgeInsets.only(left: 30),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          title: Text(
            "My Discussion",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Color(0xff000000)),
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
        ),
        body: Column(
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
                            "My Discussion",
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
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              my_discussion.length!=0?
              Expanded(
                  child: ListView.builder(
                      itemCount: my_discussion.length,
                      itemBuilder: (BuildContext contex,int index){
                        return Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: 73,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffF1F1F1),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Container(
                                      width: 58,
                                      height: 58,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: const DecorationImage(
                                              image: AssetImage("assets/images/uf.png"),
                                              fit: BoxFit.fill)),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 13),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Text(my_discussion[index]['discussion_catg'].toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff3E3E3E)),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    child:  Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            child: Image.asset(
                                              "assets/images/edit.png",
                                              height: 16,
                                              width: 16,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Edit",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12,
                                                color: Color(0xffDEA806)),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder:
                                          (context) => PostForum(
                                            name: 'edit',
                                            forum_id: my_discussion[index]['forumId'].toString(),
                                            tittle: my_discussion[index]['title'].toString(),
                                            topic: my_discussion[index]['topic_catID'].toString(),
                                            discussion: my_discussion[index]['discussion_catg'].toString(),
                                            user_id: my_discussion[index]['userID'].toString(),
                                          )));
                                    },
                                  ),
                                  InkWell(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 15, bottom: 10),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.12,
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                "assets/images/delete.png",
                                                height: 15,
                                                width: 15,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Delete",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12,
                                                  color: Color(0xffEF0F0F)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () async{
                                      setState(() {

                                      });
                                      var dio= Dio();
                                      var formData = FormData.fromMap({
                                        "user_id": my_discussion[index]['userID'].toString(),
                                        'forum_id': my_discussion[index]['forumId'].toString(),
                                      });
                                      print(formData.fields.toString());
                                      setState(() {

                                      });
                                      var response = await dio.post('https://community.creditmywallet.in.net/api/delete_forum',data: formData);
                                      setState(() {

                                      });
                                      var res=response.data;
                                      var msg=res['status_message'];
                                      setState(() {

                                      });

                                      if(res["status_message"]=="Deleted Successfuly")
                                      {
                                        setState(() {
                                          Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM);
                                        });
                                      }
                                      else {
                                        setState(() {
                                          Fluttertoast.showToast(
                                              msg: msg.toString(), toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM);
                                        });
                                      }
                                      setState(() {

                                      });

                                    },

                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  )
              ):
                  Center(
                    child: Text("No Discussion Topics"),
                  )


            ]
        )
    );
  }
}
