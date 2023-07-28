import 'dart:convert';
import 'package:communityapp/screens/forum/forum_comments.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/auth/get_open_forum_model.dart';
import 'package:communityapp/screens/forum/post_forum.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class open_forum_tab extends StatefulWidget {
  /*const open_forum_tab({Key? key}) : super(key: key);*/
  String? id,tittle;
  open_forum_tab({required this.id,required this.tittle});

  @override
  State<open_forum_tab> createState() => _open_forum_tabState();
}

class _open_forum_tabState extends State<open_forum_tab> {



  Future <List<ResponseData>> get_open_forum() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'id': "${widget.id}",
      'user_id':user_id,
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/open_forum");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['response_data'];
      print(data.toString()+"%%%%%%%%%%");
      print(data);
      return data.map((job) => ResponseData.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  String? like;
  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC30369',
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
      get_banner();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Color(0xffEEEEEE),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Padding(
              padding: EdgeInsets.only(left: 25),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )),
        title: Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text("${widget.tittle}",
            style: TextStyle(
                color: Color(0xff000000),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)
            )
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child:Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.32,
                              height: 25,
                              decoration: BoxDecoration(
                              ),
                              child: Text(
                                "Forum Feeds",
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
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => PostForum(
                                name: 'add',
                                forum_id: '',
                                tittle: '',
                                topic: '',
                                discussion: '',
                                user_id: '',
                              )
                          )
                      );
                    },
                    child: Container(
                      child: Stack(
                        children: [
                          Container(
                            child: Center(
                                child: Text(
                                  "Create Forum",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.blue.shade200,
                                      Colors.blue.shade400
                                    ]
                                )
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 110,
                            ),
                            child: CircleAvatar(
                              backgroundImage:
                              AssetImage("assets/images/upload.png"),
                              radius: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder <List<ResponseData>>(
                future: get_open_forum(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ResponseData>? data = snapshot.data;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child:Card(
                              elevation: 1,
                              color: Color(0xffFFFFFF),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(data[index].profileImg.toString()),
                                          radius: 25,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(data[index].firstName.toString()+
                                                " "+data[index].middleName.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                            Text(data[index].createdAt.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff3E3E3E)),
                                            )
                                          ],
                                        ),
                                        Spacer(),
                                        IconButton(
                                            onPressed: (){
                                              showModalBottomSheet(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(25),
                                                          topRight: Radius.circular(25))
                                                  ),
                                                  context: context,
                                                  isScrollControlled: true,
                                                  builder: (context) =>
                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                                        height: 640,
                                                        child: ListView(
                                                          children: [
                                                            Center(
                                                              child: Text("Report",
                                                                style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontFamily: 'SairaCondensed',
                                                                ),),
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            Divider(),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              "Why are you reporting this post?",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: 'SairaCondensed',
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text("Your report is anonymous, except if you reporting"
                                                                "an intelectual property infrigment.if someone is in"
                                                                "immediate danger, call the local emergency services - "
                                                                "dont wait",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors.black26,
                                                                fontFamily: 'SairaCondensed',
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            InkWell(
                                                              onTap: () async{
                                                                Widget onPostiveButton=TextButton(
                                                                  onPressed: (){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text("No",style: TextStyle(
                                                                      fontSize: 17,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.red),),
                                                                );
                                                                Widget onNegativeButton=TextButton(
                                                                  onPressed: ()
                                                                  async{
                                                                    final pref=await SharedPreferences.getInstance();
                                                                    var user_id=pref.getString('user_id');
                                                                    var dio=Dio();
                                                                    var formData = FormData.fromMap({
                                                                      'report_type':"0",
                                                                      'parent_id':data[index].userId.toString(),
                                                                      'reported_by':user_id.toString(),
                                                                      'reason':"It's spam",
                                                                      'content_reported':data[index].forumId.toString(),
                                                                      'report_for':"0",
                                                                    });
                                                                    print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                                    var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                                        data: formData);
                                                                    var res=response.data;
                                                                    var msg=res['status_message'];
                                                                    setState((){
                                                                      print(res.toString());
                                                                      print(response.toString()+"%%^^^&*()");
                                                                    });
                                                                    if(res['status_message']=="Report Submitted")
                                                                    {
                                                                      Navigator.pop(context);
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    else
                                                                    {
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                  },
                                                                  child: Text("Yes",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.green
                                                                    ),
                                                                  ),
                                                                );
                                                                AlertDialog dialog=new AlertDialog(
                                                                  actions: [onNegativeButton,onPostiveButton],
                                                                  title: Text("Are You Sure"),
                                                                );
                                                                showDialog(context: context, builder: (BuildContext context)
                                                                {
                                                                  return dialog;
                                                                });
                                                              },
                                                              child: Container(
                                                                height:35,
                                                                alignment: Alignment.centerLeft,
                                                                width:MediaQuery.of(context).size.width,
                                                                child: Text("It's spam",
                                                                  style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors.black,
                                                                    fontFamily: 'SairaCondensed',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () async{
                                                                Widget onPostiveButton=TextButton(
                                                                  onPressed: (){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text("No",style: TextStyle(
                                                                      fontSize: 17,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.red),),
                                                                );
                                                                Widget onNegativeButton=TextButton(
                                                                  onPressed: ()
                                                                  async{
                                                                    final pref=await SharedPreferences.getInstance();
                                                                    var user_id=pref.getString('user_id');
                                                                    var dio=Dio();
                                                                    var formData = FormData.fromMap({
                                                                      'report_type':"0",
                                                                      'parent_id':data[index].userId.toString(),
                                                                      'reported_by':user_id.toString(),
                                                                      'reason': "Nudity or sexual activity",
                                                                      'content_reported':data[index].forumId.toString(),
                                                                      'report_for':"0",
                                                                    });
                                                                    print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                                    var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                                        data: formData);
                                                                    var res=response.data;
                                                                    var msg=res['status_message'];
                                                                    setState((){
                                                                      print(res.toString());
                                                                      print(response.toString()+"%%^^^&*()");
                                                                    });
                                                                    if(res['status_message']=="Report Submitted")
                                                                    {
                                                                      Navigator.pop(context);
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    else
                                                                    {
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    setState(() {

                                                                    });
                                                                  },
                                                                  child: Text("Yes",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.green
                                                                    ),
                                                                  ),
                                                                );
                                                                AlertDialog dialog=new AlertDialog(
                                                                  actions: [onNegativeButton,onPostiveButton],
                                                                  title: Text("Are You Sure"),
                                                                );
                                                                showDialog(context: context, builder: (BuildContext context)
                                                                {
                                                                  return dialog;
                                                                });
                                                              },
                                                              child: Container(
                                                                height:35,
                                                                alignment: Alignment.centerLeft,
                                                                width:MediaQuery.of(context).size.width,
                                                                child: Text("Nudity or sexual activity",
                                                                  style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors.black,
                                                                    fontFamily: 'SairaCondensed',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () async{
                                                                Widget onPostiveButton=TextButton(
                                                                  onPressed: (){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text("No",style: TextStyle(
                                                                      fontSize: 17,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.red),),
                                                                );
                                                                Widget onNegativeButton=TextButton(
                                                                  onPressed: ()
                                                                  async{
                                                                    final pref=await SharedPreferences.getInstance();
                                                                    var user_id=pref.getString('user_id');
                                                                    var dio=Dio();
                                                                    var formData = FormData.fromMap({
                                                                      'report_type':"0",
                                                                      'parent_id':data[index].userId.toString(),
                                                                      'reported_by':user_id.toString(),
                                                                      'reason': "Hate speech or symbols",
                                                                      'content_reported':data[index].forumId.toString(),
                                                                      'report_for':"0",
                                                                    });
                                                                    print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                                    var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                                        data: formData);
                                                                    var res=response.data;
                                                                    var msg=res['status_message'];
                                                                    setState((){
                                                                      print(res.toString());
                                                                      print(response.toString()+"%%^^^&*()");
                                                                    });
                                                                    if(res['status_message']=="Report Submitted")
                                                                    {
                                                                      Navigator.pop(context);
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    else
                                                                    {
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    setState(() {

                                                                    });
                                                                  },
                                                                  child: Text("Yes",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.green
                                                                    ),
                                                                  ),
                                                                );
                                                                AlertDialog dialog=new AlertDialog(
                                                                  actions: [onNegativeButton,onPostiveButton],
                                                                  title: Text("Are You Sure"),
                                                                );
                                                                showDialog(context: context, builder: (BuildContext context)
                                                                {
                                                                  return dialog;
                                                                });
                                                              },
                                                              child: Container(
                                                                height:35,
                                                                alignment: Alignment.centerLeft,
                                                                width:MediaQuery.of(context).size.width,
                                                                child: Text("Hate speech or symbols",
                                                                  style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors.black,
                                                                    fontFamily: 'SairaCondensed',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () async{
                                                                Widget onPostiveButton=TextButton(
                                                                  onPressed: (){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text("No",style: TextStyle(
                                                                      fontSize: 17,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.red),),
                                                                );
                                                                Widget onNegativeButton=TextButton(
                                                                  onPressed: ()
                                                                  async{
                                                                    final pref=await SharedPreferences.getInstance();
                                                                    var user_id=pref.getString('user_id');
                                                                    var dio=Dio();
                                                                    var formData = FormData.fromMap({
                                                                      'report_type':"0",
                                                                      'parent_id':data[index].userId.toString(),
                                                                      'reported_by':user_id.toString(),
                                                                      'reason': "False information",
                                                                      'content_reported':data[index].forumId.toString(),
                                                                      'report_for':"0",
                                                                    });
                                                                    print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                                    var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                                        data: formData);
                                                                    var res=response.data;
                                                                    var msg=res['status_message'];
                                                                    setState((){
                                                                      print(res.toString());
                                                                      print(response.toString()+"%%^^^&*()");
                                                                    });
                                                                    if(res['status_message']=="Report Submitted")
                                                                    {
                                                                      Navigator.pop(context);
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    else
                                                                    {
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    setState(() {

                                                                    });
                                                                  },
                                                                  child: Text("Yes",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.green
                                                                    ),
                                                                  ),
                                                                );
                                                                AlertDialog dialog=new AlertDialog(
                                                                  actions: [onNegativeButton,onPostiveButton],
                                                                  title: Text("Are You Sure"),
                                                                );
                                                                showDialog(context: context, builder: (BuildContext context)
                                                                {
                                                                  return dialog;
                                                                });
                                                              },
                                                              child: Container(
                                                                height:35,
                                                                alignment: Alignment.centerLeft,
                                                                width:MediaQuery.of(context).size.width,
                                                                child: Text("False information",
                                                                  style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors.black,
                                                                    fontFamily: 'SairaCondensed',
                                                                  ),
                                                                ),
                                                              ),

                                                            ),
                                                            InkWell(
                                                              onTap: () async{
                                                                Widget onPostiveButton=TextButton(
                                                                  onPressed: (){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text("No",style: TextStyle(
                                                                      fontSize: 17,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.red),),
                                                                );
                                                                Widget onNegativeButton=TextButton(
                                                                  onPressed: ()
                                                                  async{
                                                                    final pref=await SharedPreferences.getInstance();
                                                                    var user_id=pref.getString('user_id');
                                                                    var dio=Dio();
                                                                    var formData = FormData.fromMap({
                                                                      'report_type':"0",
                                                                      'parent_id':data[index].userId.toString(),
                                                                      'reported_by':user_id.toString(),
                                                                      'reason': "I just don't like it",
                                                                      'content_reported':data[index].forumId.toString(),
                                                                      'report_for':"0",
                                                                    });
                                                                    print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                                    var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                                        data: formData);
                                                                    var res=response.data;
                                                                    var msg=res['status_message'];
                                                                    setState((){
                                                                      print(res.toString());
                                                                      print(response.toString()+"%%^^^&*()");
                                                                    });
                                                                    if(res['status_message']=="Report Submitted")
                                                                    {
                                                                      Navigator.pop(context);
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    else
                                                                    {
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    setState(() {

                                                                    });
                                                                  },
                                                                  child: Text("Yes",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.green
                                                                    ),
                                                                  ),
                                                                );
                                                                AlertDialog dialog=new AlertDialog(
                                                                  actions: [onNegativeButton,onPostiveButton],
                                                                  title: Text("Are You Sure"),
                                                                );
                                                                showDialog(context: context, builder: (BuildContext context)
                                                                {
                                                                  return dialog;
                                                                });
                                                              },
                                                              child: Container(
                                                                height:35,
                                                                alignment: Alignment.centerLeft,
                                                                width:MediaQuery.of(context).size.width,
                                                                child: Text("I just don't like it",
                                                                  style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors.black,
                                                                    fontFamily: 'SairaCondensed',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () async{
                                                                Widget onPostiveButton=TextButton(
                                                                  onPressed: (){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text("No",style: TextStyle(
                                                                      fontSize: 17,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.red),),
                                                                );
                                                                Widget onNegativeButton=TextButton(
                                                                  onPressed: ()
                                                                  async{
                                                                    final pref=await SharedPreferences.getInstance();
                                                                    var user_id=pref.getString('user_id');
                                                                    var dio=Dio();
                                                                    var formData = FormData.fromMap({
                                                                      'report_type':"0",
                                                                      'parent_id':data[index].userId.toString(),
                                                                      'reported_by':user_id.toString(),
                                                                      'reason': "Bullying or harassment",
                                                                      'content_reported':data[index].forumId.toString(),
                                                                      'report_for':"0",
                                                                    });
                                                                    print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                                    var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                                        data: formData);
                                                                    var res=response.data;
                                                                    var msg=res['status_message'];
                                                                    setState((){
                                                                      print(res.toString());
                                                                      print(response.toString()+"%%^^^&*()");
                                                                    });
                                                                    if(res['status_message']=="Report Submitted")
                                                                    {
                                                                      Navigator.pop(context);
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    else
                                                                    {
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    setState(() {

                                                                    });
                                                                  },
                                                                  child: Text("Yes",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.green
                                                                    ),
                                                                  ),
                                                                );
                                                                AlertDialog dialog=new AlertDialog(
                                                                  actions: [onNegativeButton,onPostiveButton],
                                                                  title: Text("Are You Sure"),
                                                                );
                                                                showDialog(context: context, builder: (BuildContext context)
                                                                {
                                                                  return dialog;
                                                                });
                                                              },
                                                              child: Container(
                                                                height:35,
                                                                alignment: Alignment.centerLeft,
                                                                width:MediaQuery.of(context).size.width,
                                                                child: Text("Bullying or harassment",
                                                                  style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors.black,
                                                                    fontFamily: 'SairaCondensed',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () async{
                                                                Widget onPostiveButton=TextButton(
                                                                  onPressed: (){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text("No",style: TextStyle(
                                                                      fontSize: 17,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.red),),
                                                                );
                                                                Widget onNegativeButton=TextButton(
                                                                  onPressed: ()
                                                                  async{
                                                                    final pref=await SharedPreferences.getInstance();
                                                                    var user_id=pref.getString('user_id');
                                                                    var dio=Dio();
                                                                    var formData = FormData.fromMap({
                                                                      'report_type':"0",
                                                                      'parent_id':data[index].userId.toString(),
                                                                      'reported_by':user_id.toString(),
                                                                      'reason': "Scam or fraud",
                                                                      'content_reported':data[index].forumId.toString(),
                                                                      'report_for':"0",
                                                                    });
                                                                    print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                                    var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                                        data: formData);
                                                                    var res=response.data;
                                                                    var msg=res['status_message'];
                                                                    setState((){
                                                                      print(res.toString());
                                                                      print(response.toString()+"%%^^^&*()");
                                                                    });
                                                                    if(res['status_message']=="Report Submitted")
                                                                    {
                                                                      Navigator.pop(context);
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    else
                                                                    {
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    setState(() {

                                                                    });
                                                                  },
                                                                  child: Text("Yes",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.green
                                                                    ),
                                                                  ),
                                                                );
                                                                AlertDialog dialog=new AlertDialog(
                                                                  actions: [onNegativeButton,onPostiveButton],
                                                                  title: Text("Are You Sure"),
                                                                );
                                                                showDialog(context: context, builder: (BuildContext context)
                                                                {
                                                                  return dialog;
                                                                });
                                                              },
                                                              child: Container(
                                                                height:35,
                                                                alignment: Alignment.centerLeft,
                                                                width:MediaQuery.of(context).size.width,
                                                                child: Text("cam or fraud",
                                                                  style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors.black,
                                                                    fontFamily: 'SairaCondensed',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () async{
                                                                Widget onPostiveButton=TextButton(
                                                                  onPressed: (){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text("No",style: TextStyle(
                                                                      fontSize: 17,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.red),),
                                                                );
                                                                Widget onNegativeButton=TextButton(
                                                                  onPressed: ()
                                                                  async{
                                                                    final pref=await SharedPreferences.getInstance();
                                                                    var user_id=pref.getString('user_id');
                                                                    var dio=Dio();
                                                                    var formData = FormData.fromMap({
                                                                      'report_type':"0",
                                                                      'parent_id':data[index].userId.toString(),
                                                                      'reported_by':user_id.toString(),
                                                                      'reason': "Violence or dangerous organizations",
                                                                      'content_reported':data[index].forumId.toString(),
                                                                      'report_for':"0",
                                                                    });
                                                                    print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                                    var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                                        data: formData);
                                                                    var res=response.data;
                                                                    var msg=res['status_message'];
                                                                    setState((){
                                                                      print(res.toString());
                                                                      print(response.toString()+"%%^^^&*()");
                                                                    });
                                                                    if(res['status_message']=="Report Submitted")
                                                                    {
                                                                      Navigator.pop(context);
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    else
                                                                    {
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    setState(() {

                                                                    });
                                                                  },
                                                                  child: Text("Yes",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.green
                                                                    ),
                                                                  ),
                                                                );
                                                                AlertDialog dialog=new AlertDialog(
                                                                  actions: [onNegativeButton,onPostiveButton],
                                                                  title: Text("Are You Sure"),
                                                                );
                                                                showDialog(context: context, builder: (BuildContext context)
                                                                {
                                                                  return dialog;
                                                                });
                                                              },
                                                              child: Container(
                                                                height:35,
                                                                alignment: Alignment.centerLeft,
                                                                width:MediaQuery.of(context).size.width,
                                                                child: Text("Violence or dangerous organizations",
                                                                  style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors.black,
                                                                    fontFamily: 'SairaCondensed',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () async{
                                                                Widget onPostiveButton=TextButton(
                                                                  onPressed: (){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text("No",style: TextStyle(
                                                                      fontSize: 17,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.red),),
                                                                );
                                                                Widget onNegativeButton=TextButton(
                                                                  onPressed: ()
                                                                  async{
                                                                    final pref=await SharedPreferences.getInstance();
                                                                    var user_id=pref.getString('user_id');
                                                                    var dio=Dio();
                                                                    var formData = FormData.fromMap({
                                                                      'report_type':"0",
                                                                      'parent_id':data[index].userId.toString(),
                                                                      'reported_by':user_id.toString(),
                                                                      'reason': "Intellctual property violation",
                                                                      'content_reported':data[index].forumId.toString(),
                                                                      'report_for':"0",
                                                                    });
                                                                    print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                                    var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                                        data: formData);
                                                                    var res=response.data;
                                                                    var msg=res['status_message'];
                                                                    setState((){
                                                                      print(res.toString());
                                                                      print(response.toString()+"%%^^^&*()");
                                                                    });
                                                                    if(res['status_message']=="Report Submitted")
                                                                    {
                                                                      Navigator.pop(context);
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    else
                                                                    {
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    setState(() {

                                                                    });
                                                                  },
                                                                  child: Text("Yes",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.green
                                                                    ),
                                                                  ),
                                                                );
                                                                AlertDialog dialog=new AlertDialog(
                                                                  actions: [onNegativeButton,onPostiveButton],
                                                                  title: Text("Are You Sure"),
                                                                );
                                                                showDialog(context: context, builder: (BuildContext context)
                                                                {
                                                                  return dialog;
                                                                });
                                                              },
                                                              child: Container(
                                                                height:35,
                                                                alignment: Alignment.centerLeft,
                                                                width:MediaQuery.of(context).size.width,
                                                                child: Text("Intellctual property violation",
                                                                  style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors.black,
                                                                    fontFamily: 'SairaCondensed',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () async{
                                                                Widget onPostiveButton=TextButton(
                                                                  onPressed: (){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text("No",style: TextStyle(
                                                                      fontSize: 17,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.red),),
                                                                );
                                                                Widget onNegativeButton=TextButton(
                                                                  onPressed: ()
                                                                  async{
                                                                    final pref=await SharedPreferences.getInstance();
                                                                    var user_id=pref.getString('user_id');
                                                                    var dio=Dio();
                                                                    var formData = FormData.fromMap({
                                                                      'report_type':"0",
                                                                      'parent_id':data[index].userId.toString(),
                                                                      'reported_by':user_id.toString(),
                                                                      'reason': "Sale of illegal or regulated goods",
                                                                      'content_reported':data[index].forumId.toString(),
                                                                      'report_for':"0",
                                                                    });
                                                                    print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                                    var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                                        data: formData);
                                                                    var res=response.data;
                                                                    var msg=res['status_message'];
                                                                    setState((){
                                                                      print(res.toString());
                                                                      print(response.toString()+"%%^^^&*()");
                                                                    });
                                                                    if(res['status_message']=="Report Submitted")
                                                                    {
                                                                      Navigator.pop(context);
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    else
                                                                    {
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    setState(() {

                                                                    });
                                                                  },
                                                                  child: Text("Yes",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.green
                                                                    ),
                                                                  ),
                                                                );
                                                                AlertDialog dialog=new AlertDialog(
                                                                  actions: [onNegativeButton,onPostiveButton],
                                                                  title: Text("Are You Sure"),
                                                                );
                                                                showDialog(context: context, builder: (BuildContext context)
                                                                {
                                                                  return dialog;
                                                                });
                                                              },
                                                              child: Container(
                                                                height:35,
                                                                alignment: Alignment.centerLeft,
                                                                width:MediaQuery.of(context).size.width,
                                                                child: Text("Sale of illegal or regulated goods",
                                                                  style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors.black,
                                                                    fontFamily: 'SairaCondensed',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () async{
                                                                Widget onPostiveButton=TextButton(
                                                                  onPressed: (){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text("No",style: TextStyle(
                                                                      fontSize: 17,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.red),),
                                                                );
                                                                Widget onNegativeButton=TextButton(
                                                                  onPressed: ()
                                                                  async{
                                                                    final pref=await SharedPreferences.getInstance();
                                                                    var user_id=pref.getString('user_id');
                                                                    var dio=Dio();
                                                                    var formData = FormData.fromMap({
                                                                      'report_type':"0",
                                                                      'parent_id':data[index].userId.toString(),
                                                                      'reported_by':user_id.toString(),
                                                                      'reason': "Suicide or self-injury",
                                                                      'content_reported':data[index].forumId.toString(),
                                                                      'report_for':"0",
                                                                    });
                                                                    print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                                    var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                                        data: formData);
                                                                    var res=response.data;
                                                                    var msg=res['status_message'];
                                                                    setState((){
                                                                      print(res.toString());
                                                                      print(response.toString()+"%%^^^&*()");
                                                                    });
                                                                    if(res['status_message']=="Report Submitted")
                                                                    {
                                                                      Navigator.pop(context);
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    else
                                                                    {
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    setState(() {

                                                                    });
                                                                  },
                                                                  child: Text("Yes",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.green
                                                                    ),
                                                                  ),
                                                                );
                                                                AlertDialog dialog=new AlertDialog(
                                                                  actions: [onNegativeButton,onPostiveButton],
                                                                  title: Text("Are You Sure"),
                                                                );
                                                                showDialog(context: context, builder: (BuildContext context)
                                                                {
                                                                  return dialog;
                                                                });
                                                              },
                                                              child: Container(
                                                                height:35,
                                                                alignment: Alignment.centerLeft,
                                                                width:MediaQuery.of(context).size.width,
                                                                child: Text("Suicide or self-injury",
                                                                  style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors.black,
                                                                    fontFamily: 'SairaCondensed',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () async{
                                                                Widget onPostiveButton=TextButton(
                                                                  onPressed: (){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text("No",style: TextStyle(
                                                                      fontSize: 17,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.red),),
                                                                );
                                                                Widget onNegativeButton=TextButton(
                                                                  onPressed: ()
                                                                  async{
                                                                    final pref=await SharedPreferences.getInstance();
                                                                    var user_id=pref.getString('user_id');
                                                                    var dio=Dio();
                                                                    var formData = FormData.fromMap({
                                                                      'report_type':"0",
                                                                      'parent_id':data[index].userId.toString(),
                                                                      'reported_by':user_id.toString(),
                                                                      'reason': "Eating disorders",
                                                                      'content_reported':data[index].forumId.toString(),
                                                                      'report_for':"0",
                                                                    });
                                                                    print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                                    var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                                        data: formData);
                                                                    var res=response.data;
                                                                    var msg=res['status_message'];
                                                                    setState((){
                                                                      print(res.toString());
                                                                      print(response.toString()+"%%^^^&*()");
                                                                    });
                                                                    if(res['status_message']=="Report Submitted")
                                                                    {
                                                                      Navigator.pop(context);
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    else
                                                                    {
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    setState(() {

                                                                    });
                                                                  },
                                                                  child: Text("Yes",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.green
                                                                    ),
                                                                  ),
                                                                );
                                                                AlertDialog dialog=new AlertDialog(
                                                                  actions: [onNegativeButton,onPostiveButton],
                                                                  title: Text("Are You Sure"),
                                                                );
                                                                showDialog(context: context, builder: (BuildContext context)
                                                                {
                                                                  return dialog;
                                                                });
                                                              },
                                                              child: Container(
                                                                height:35,
                                                                alignment: Alignment.centerLeft,
                                                                width:MediaQuery.of(context).size.width,
                                                                child: Text("Eating disorders",
                                                                  style: TextStyle(
                                                                    fontSize: 17,
                                                                    color: Colors.black,
                                                                    fontFamily: 'SairaCondensed',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () async{
                                                                Widget onPostiveButton=TextButton(
                                                                  onPressed: (){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text("No",style: TextStyle(
                                                                      fontSize: 17,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.red),),
                                                                );
                                                                Widget onNegativeButton=TextButton(
                                                                  onPressed: ()
                                                                  async{
                                                                    final pref=await SharedPreferences.getInstance();
                                                                    var user_id=pref.getString('user_id');
                                                                    var dio=Dio();
                                                                    var formData = FormData.fromMap({
                                                                      'report_type':"0",
                                                                      'parent_id':data[index].userId.toString(),
                                                                      'reported_by':user_id.toString(),
                                                                      'reason': "Something else",
                                                                      'content_reported': data[index].forumId.toString(),
                                                                      'report_for':"0",
                                                                    });
                                                                    print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                                    var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                                        data: formData);
                                                                    var res=response.data;
                                                                    var msg=res['status_message'];
                                                                    setState((){
                                                                      print(res.toString());
                                                                      print(response.toString()+"%%^^^&*()");
                                                                    });
                                                                    if(res['status_message']=="Report Submitted")
                                                                    {
                                                                      Navigator.pop(context);
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    else
                                                                    {
                                                                      Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                                          gravity: ToastGravity.BOTTOM);
                                                                    }
                                                                    setState(() {

                                                                    });
                                                                  },
                                                                  child: Text("Yes",
                                                                    style: TextStyle(
                                                                        fontSize: 17,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: Colors.green
                                                                    ),
                                                                  ),
                                                                );
                                                                AlertDialog dialog=new AlertDialog(
                                                                  actions: [onNegativeButton,onPostiveButton],
                                                                  title: Text("Are You Sure"),
                                                                );
                                                                showDialog(context: context, builder: (BuildContext context)
                                                                {
                                                                  return dialog;
                                                                });
                                                              },
                                                              child: Container(
                                                                  height:35,
                                                                  alignment: Alignment.centerLeft,
                                                                  width:MediaQuery.of(context).size.width,
                                                                  child: Text("Something else",
                                                                    style: TextStyle(
                                                                      fontSize: 17,
                                                                      color: Colors.black,
                                                                      fontFamily: 'SairaCondensed',
                                                                    ),
                                                                  )
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                              );
                                            },
                                            icon: Icon(Icons.more_vert))
                                      ],
                                    ),
                                  ),
                                  Text(data[index].title.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff707070)),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15, right: 15),
                                    child: Text(data[index].discussionCatg.toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff878383)),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 0, right: 15, top: 5),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                        ),
                                        IconButton(
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context)=>ForumCumment(
                                                    forum_id: data[index].forumId.toString(),
                                                    comment: data[index].comments.toString(),
                                                  )
                                              )
                                              );
                                            },
                                            icon: Icon(Icons.comment_bank_outlined)
                                        ),
                                        Text(data[index].comments.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Color(0xff000000)),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        IconButton(
                                          onPressed: () async{
                                            var dio1 = Dio();
                                            final pref=await SharedPreferences.getInstance();
                                            var user_id=pref.getString('user_id');
                                            var formData = FormData.fromMap({
                                              'user_id': user_id,
                                              'forum_id':data[index].forumId.toString(),
                                            });
                                            print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                            var response = await dio1.post('https://community.creditmywallet.in.net/api/like_forum',
                                                data: formData);
                                            var res=response.data;
                                            setState((){
                                              print(response.toString()+"%%^^^&*()");
                                              like=res["reaponse_data"];
                                            });
                                            setState(() {

                                            });
                                          },
                                          icon: data[index].likeStatus!="0"?
                                          Icon(Icons.favorite_border):
                                          Icon(Icons.favorite,color: Colors.red,),
                                        ),
                                        Text(data[index].likes.toString(),
                                          style: TextStyle(
                                              color: Color(0XFF000000),
                                              fontSize: 12
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Text("No Open FOrum");
                }),
            SizedBox(
              height: 25,
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
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
