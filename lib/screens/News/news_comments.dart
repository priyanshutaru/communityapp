import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/auth/get_news_comment_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../membersearch/member_search_profile.dart';


class NewsComments extends StatefulWidget {
  /*const NewsComments({Key? key}) : super(key: key);*/
  String? post_id,total_comment;
  NewsComments({required this.post_id,required this.total_comment});

  @override
  State<NewsComments> createState() => _NewsCommentsState();
}

class _NewsCommentsState extends State<NewsComments> {
  String? user_id;
  TextEditingController comment=TextEditingController();
  Future <List<NewsComment>> get_news_comment() async {
    Map data={
      "news_id":"${widget.post_id.toString()}"
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_news_comment");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type":
    "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      print(data);
      return data.map((job) => NewsComment.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }
  @override
  void initState(){
    super.initState();
      setState(() {
        get_news_comment();
        user();
      });
  }
  void user() async{
    final pref=await SharedPreferences.getInstance();
    user_id=pref.getString('user_id');
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F5F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffEEEEEE),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )),
        title: Text(
          "Comments",
          style: TextStyle(
              color: Color(0xff000000),
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, top: 16),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/chat.png",
                    fit: BoxFit.fill,
                    height: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("${widget.total_comment}",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder <List<NewsComment>>(
                  future: get_news_comment(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<NewsComment>? data = snapshot.data;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics:  NeverScrollableScrollPhysics(),
                        itemCount: data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 24/ 8,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 3,
                            crossAxisCount: 1
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return  InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>MemberSearchProfile(
                                    user_id: data[index].userId.toString(),
                                  )));
                            },
                            child: Padding(
                              padding:  EdgeInsets.only(left: 15, right: 15),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                Text(data[index].firstName.toString()+" "+data[index].middleName.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                ),
                                                Text(data[index].date.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold, color: Colors
                                                      .black45),
                                                )
                                              ],
                                            ),
                                            Spacer(),
                                            user_id==data[index].userId ?
                                            IconButton(
                                                onPressed: () async{
                                                  var dio= Dio();
                                                  var formData = FormData.fromMap({
                                                    "comment_id":data[index].commentId.toString()
                                                  });
                                                  print(formData.fields.toString());
                                                  setState(() {

                                                  });
                                                  var response = await dio.post('https://community.creditmywallet.in.net/api/trash_news_comment',data: formData);
                                                  setState(() {

                                                  });
                                                  var res=response.data;
                                                  var msg=res['data'];
                                                },
                                                icon: Icon(Icons.delete)
                                            ):
                                            Text(""),
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
                                                                Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                              'report_type':"2",
                                                                              'parent_id':data[index].userId.toString(),
                                                                              'reported_by':user_id.toString(),
                                                                              'reason':"It's spam",
                                                                              'content_reported':data[index].commentId.toString(),
                                                                              'report_for':"2",
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
                                                                              'report_type':"2",
                                                                              'parent_id':data[index].userId.toString(),
                                                                              'reported_by':user_id.toString(),
                                                                              'reason': "Nudity or sexual activity",
                                                                              'content_reported':data[index].commentId.toString(),
                                                                              'report_for':"2",
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
                                                                              'report_type':"2",
                                                                              'parent_id':data[index].userId.toString(),
                                                                              'reported_by':user_id.toString(),
                                                                              'reason': "Hate speech or symbols",
                                                                              'content_reported':data[index].commentId.toString(),
                                                                              'report_for':"2",
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
                                                                              'report_type':"2",
                                                                              'parent_id':data[index].userId.toString(),
                                                                              'reported_by':user_id.toString(),
                                                                              'reason': "False information",
                                                                              'content_reported':data[index].commentId.toString(),
                                                                              'report_for':"2",
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
                                                                              'report_type':"2",
                                                                              'parent_id':data[index].userId.toString(),
                                                                              'reported_by':user_id.toString(),
                                                                              'reason': "I just don't like it",
                                                                              'content_reported':data[index].commentId.toString(),
                                                                              'report_for':"2",
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
                                                                              'report_type':"2",
                                                                              'parent_id':data[index].userId.toString(),
                                                                              'reported_by':user_id.toString(),
                                                                              'reason': "Bullying or harassment",
                                                                              'content_reported':data[index].commentId.toString(),
                                                                              'report_for':"2",
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
                                                                              'report_type':"2",
                                                                              'parent_id':data[index].userId.toString(),
                                                                              'reported_by':user_id.toString(),
                                                                              'reason': "Scam or fraud",
                                                                              'content_reported':data[index].commentId.toString(),
                                                                              'report_for':"2",
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
                                                                        child: Text("Scam or fraud",
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
                                                                              'report_type':"2",
                                                                              'parent_id':data[index].userId.toString(),
                                                                              'reported_by':user_id.toString(),
                                                                              'reason': "Violence or dangerous organizations",
                                                                              'content_reported':data[index].commentId.toString(),
                                                                              'report_for':"2",
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
                                                                              'report_type':"2",
                                                                              'parent_id':data[index].userId.toString(),
                                                                              'reported_by':user_id.toString(),
                                                                              'reason': "Intellctual property violation",
                                                                              'content_reported':data[index].commentId.toString(),
                                                                              'report_for':"2",
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
                                                                              'report_type':"2",
                                                                              'parent_id':data[index].userId.toString(),
                                                                              'reported_by':user_id.toString(),
                                                                              'reason': "Sale of illegal or regulated goods",
                                                                              'content_reported':data[index].commentId.toString(),
                                                                              'report_for':"2",
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
                                                                              'report_type':"2",
                                                                              'parent_id':data[index].userId.toString(),
                                                                              'reported_by':user_id.toString(),
                                                                              'reason': "Suicide or self-injury",
                                                                              'content_reported':data[index].commentId.toString(),
                                                                              'report_for':"2",
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
                                                                              'report_type':"2",
                                                                              'parent_id':data[index].userId.toString(),
                                                                              'reported_by':user_id.toString(),
                                                                              'reason': "Eating disorders",
                                                                              'content_reported':data[index].commentId.toString(),
                                                                              'report_for':"2",
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
                                                                              'report_type':"2",
                                                                              'parent_id':data[index].userId.toString(),
                                                                              'reported_by':user_id.toString(),
                                                                              'reason': "Something else",
                                                                              'content_reported': data[index].commentId.toString(),
                                                                              'report_for':"2",
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
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 15,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                  );
                                                },
                                                icon: Icon(Icons.more_vert,)),
                                          ],
                                        ),
                                      ),
                                      Expanded(child: Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Text(data[index].comment.toString()),
                                      )
                                      )
                                      ,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: Text("No Comments"),
                    );
                  }),
            ),
            SizedBox(
              height: 90 ,
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(left: 20, right: 20,top: 30),
        child: TextFormField(
          controller: comment,
          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              contentPadding: EdgeInsets.all(14),
              hintText: "comment here........",
              suffixIcon:  IconButton(
                onPressed: () async{
                  final pref=await SharedPreferences.getInstance();
                  var user_id=pref.getString('user_id');
                  var dio= Dio();
                  var formData = FormData.fromMap({
                    'user_id': user_id,
                    'news_id' :"${widget.post_id}",
                    'comment':comment.text.toString()
                  });
                  print(formData.fields.toString());
                  var response = await dio.post('https://community.creditmywallet.in.net/api/add_news_comment',data: formData);
                  var res=response.data;
                  comment.clear();
                  setState(() {
                    print(response.toString()+"&&&***(((()))");
                  });
                },
                icon: Icon(Icons.send,color: Colors.black,),
              ),
             /* prefixIcon: const Icon(,
                color: Colors.black,
              )*/
          ),
        ),
      ),
    );
  }
}

