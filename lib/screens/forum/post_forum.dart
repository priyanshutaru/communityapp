import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/forum/my_discussion.dart';
import 'package:communityapp/screens/profile_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostForum extends StatefulWidget {
/*  const PostForum({Key? key}) : super(key: key);*/
String? name,forum_id,tittle,topic,discussion,user_id;


PostForum({required this.name, required this.forum_id,required  this.tittle,required this.topic,
  required this.discussion, required this.user_id});

  @override
  State<PostForum> createState() => _PostForumState();
}

class _PostForumState extends State<PostForum> {
  String? dropdownvalue;
  int? categories;
  TextEditingController tittle=TextEditingController();
  TextEditingController discussion=TextEditingController();
  String? edit_tittle="";
  String? edit_discussion="";

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC96460',
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

  List forum_cat=[];
  Future get_forum_cat() async {
    var url = Uri.parse("https://community.creditmywallet.in.net/api/forum_category");
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var res = await json.decode(response.body);
    print("response12" + response.body);

    if (response.statusCode == 200) {
      setState(() {
        forum_cat = res['data'];
        print("%%%%%%%%%%5555"+forum_cat.toString());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    get_banner();
    get_forum_cat();
    setState(() {
      edit_tittle="${widget.tittle}";
      edit_discussion="${widget.discussion}";
      tittle.text=edit_tittle.toString();
      discussion.text=edit_discussion.toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 238, 238),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 252, 255),
        elevation: 0,
        leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
        title:  Text(
          "New Open Forum Topics",
          style: TextStyle(
              color: Color(0xff000000),
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(
              height: 5,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 30,
                  width: 295,
                  child: RichText(
                    text: TextSpan(
                      text: ' वाडवळ  पाचकळशी ',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffFF8900),
                          fontWeight: FontWeight.bold),
                      /*defining default style is optional */
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Community Discussion*',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff000000),
                                fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 19,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: Color(0xffDED9D9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 42,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 35),
                      child: Row(
                        children: [
                          Text(
                            "Title",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xff7A7A7A)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        controller: tittle,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none
                            ),
                            hintText: 'Correct way to right a Blog',
                            hintStyle: TextStyle(
                                fontSize: 14, color: Color(0xff878383))),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 35),
                      child: Row(
                        children: [
                          Text(
                            "Topics Catogaries",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 3),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .85,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white70),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: dropdownvalue,
                            hint: Text("        Topics Categories"),
                            icon: Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(Icons.arrow_drop_down),
                            ),
                            items: forum_cat.map((item) {
                              return DropdownMenuItem(
                                value: item['id'].toString(),
                                child: Padding(
                                  padding:  EdgeInsets.only(left: 20),
                                  child: Text(
                                    item['f_name'].toString(),
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 35),
                      child: Row(
                        children: [
                          Text(
                            "Discussion Topics",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        controller: discussion,
                        maxLines: 199,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20,top: 10),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: [
                        Container(
                            height: 45,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  end: Alignment.topLeft,
                                  colors: [
                                    Colors.blue.shade400,
                                    Colors.blue.shade100,
                                  ],
                                )
                            ),
                            child: MaterialButton(
                              onPressed: () async{
                                if("${widget.name}"=="add")
                                {
                                  final pref = await SharedPreferences
                                      .getInstance();
                                  var user_id = pref.getString('user_id');
                                  var dio = Dio();
                                  var formData = FormData.fromMap({
                                    'user_id': user_id.toString(),
                                    'title': tittle.text,
                                    'topic_category_id': dropdownvalue,
                                    "discussion_category": discussion.text
                                        .toString(),
                                  });
                                  print(formData.fields.toString());
                                  var response = await dio.post(
                                      'https://community.creditmywallet.in.net/api/post_forum',
                                      data: formData);
                                  var res = response.data;
                                  var msg = res['status_message'];
                                  setState(() {
                                    print("%%%%%%%%%%%%^^^^^^^^" +
                                        response.toString());
                                  });
                                  if (res['status_message']=="Forum Added Successfully") {
                                    setState(() {
                                      Fluttertoast.showToast(
                                          msg: msg.toString(),
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM);
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder:
                                          (context) => MyDiscussion()));
                                    });
                                  }
                                  else {
                                    setState(() {
                                      Fluttertoast.showToast(
                                          msg: msg.toString(),
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM);
                                    });
                                  }
                                }
                                else if("${widget.name}"=="edit")
                                {
                                  final pref = await SharedPreferences
                                      .getInstance();
                                  var user_id = pref.getString('user_id');
                                  var dio = Dio();
                                  var formData = FormData.fromMap({
                                    'forum_id':"${widget.forum_id}",
                                    'user_id': user_id,
                                    'title': tittle.text,
                                    'topic_category_id': categories,
                                    "discussion_category": discussion.text.toString(),
                                    'topic_category_id':"${widget.topic}",
                                  });
                                  print(formData.fields.toString());
                                  var response = await dio.post(
                                      'https://community.creditmywallet.in.net/api/edit_forum', data: formData);
                                  var res = response.data;
                                  var msg = res['status_message'];
                                  setState(() {
                                    print("%%%%%%%%%%%%^^^^^^^^" +
                                        response.toString());
                                  });
                                  if (res['status_message'] =="Updated Successfully" ) {
                                    setState(() {
                                      Fluttertoast.showToast(
                                          msg: msg.toString(),
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM);
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder:
                                          (context) => MyDiscussion()));
                                    });
                                  }
                                  else {
                                    setState(() {
                                      Fluttertoast.showToast(
                                          msg: msg.toString(),
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM);
                                    });
                                  }
                                }
                              },
                              child: Text("Post Now",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            ),
                          ),

                      ],
                    ),
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
          ],
        ),
      ),
    );
  }
}
