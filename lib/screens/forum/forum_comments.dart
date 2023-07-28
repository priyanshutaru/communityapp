import 'dart:convert';
import 'package:communityapp/screens/auth/open_forum_comment_model.dart';
import 'package:communityapp/screens/membersearch/member_search_profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ForumCumment extends StatefulWidget {
  String? forum_id,comment;
  ForumCumment({required this.forum_id,required this.comment});

  @override
  State<ForumCumment> createState() => _ForumCummentState();
}

class _ForumCummentState extends State<ForumCumment> {
  TextEditingController comment=TextEditingController();

  Future <List<ForumCommenmt>> forum_Comment() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      "user_id": user_id,
      "forum_id": "${widget.forum_id}",
    };
    print(data.toString());
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_forum_comment");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['response_data'];
      print(data);
      return data.map((job) => ForumCommenmt.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  String? comment_id,parent_id;
  FocusNode focusNode=FocusNode();
  bool visible=false;
  String? comment_d1;
  String? user_id;
  void user() async{
    final pref=await SharedPreferences.getInstance();
    user_id=pref.getString('user_id');
  }

  @override
  void initState() {
    super.initState();
    user();
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
            icon:  Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
      ),
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
      body:  Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, top: 16),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/chat.png",
                    fit: BoxFit.fill,
                    height: 21.55,
                    width: 25,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("${widget.comment}",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 31.64,
            ),
            FutureBuilder <List<ForumCommenmt>>(
                future: forum_Comment(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ForumCommenmt>? data = snapshot.data;
                    return Expanded(
                        child: ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>MemberSearchProfile(
                                      user_id: data[index].userId.toString(),
                                    )));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child:
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          children: [
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
                                                      Text(data[index].firstName.toString()+" "+
                                                          data[index].lastName.toString(),
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 14,
                                                            color: Color(0xff000000)),
                                                      ),
                                                      Text(data[index].postedDate.toString(),
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            color: Color(0xff979797)),
                                                      )
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  user_id==data[index].userId ?
                                                  IconButton(
                                                      onPressed: () async{
                                                        var dio2= Dio();
                                                        var formData = FormData.fromMap({
                                                          "comment_id":data[index].comntId.toString(),
                                                          'forum_id':"${widget.forum_id}",
                                                          'user_id':user_id.toString()
                                                        });
                                                        var response=await dio2.post('https://community.creditmywallet.in.net/api/delete_forum_comment',data: formData);
                                                        var res=response.data;
                                                        var msg=res['status_message'];


                                                        if(res["status_message"]=="Comment Deleted")
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
                                                      },
                                                      icon: Icon(Icons.delete,)
                                                  ):
                                                  Text(""),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 35, right: 13),
                                              child: Text(data[index].comntComment.toString(),
                                                style: TextStyle(
                                                    fontFamily: "Inter",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff989595)
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        data[index].reply!.length!=0?
                                        Visibility(
                                          visible: visible,
                                            child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 50),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(data[index].reply![index].profileImg.toString()),
                                                          fit: BoxFit.fill,
                                                        ),
                                                        borderRadius: BorderRadius.circular(40)
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(data[index].reply![index].firstName.toString()+
                                                          " "+data[index].reply![index].lastName.toString(),
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.normal,
                                                            color: Colors.black
                                                        ),),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      Text(data[index].reply![index].postedDate.toString(),
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight: FontWeight.w400,
                                                            color: Color(0xff989595)
                                                        ),),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      Text(data[index].reply![index].comntComment.toString(),
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight: FontWeight.w400,
                                                            color: Color(0xff989595)
                                                        ),)
                                                    ],
                                                  ),
                                                  Spacer(),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                        ):
                                        Container(),
                                        Padding(
                                          padding: EdgeInsets.only(left: 0, right: 15, top: 5),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 30,
                                              ),
                                              IconButton(
                                                  onPressed: (){
                                                    focusNode.requestFocus();
                                                    setState(() {
                                                      parent_id=data[index].forumCmntId.toString();
                                                      comment_id=data[index].comntId.toString();
                                                    });
                                                  },
                                                  icon: Icon(Icons.comment_bank_outlined)
                                              ),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              InkWell(
                                                child: Text("View Replys",
                                                  style:
                                                  TextStyle(
                                                      color: Color(0XFF000000),
                                                      fontSize: 12),
                                                ),
                                                onTap: (){
                                                  setState((){
                                                    comment_d1=data[index].comntId.toString();
                                                    if(visible==false)
                                                    {
                                                      setState(() {
                                                        visible=true;
                                                      });
                                                    }
                                                    else
                                                    {
                                                      setState(() {
                                                        visible=false;
                                                      });
                                                    }

                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                    );
                  }
                  return Center(
                    child: Text("No Forum Comments"),
                  );
                }),
            SizedBox(
              height: 120,
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(left: 20, right: 20,top: 30),
        child: TextFormField(
          focusNode: focusNode,
          controller: comment,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
            ),
              contentPadding: EdgeInsets.all(15),
              hintText: "comment here........",
              suffixIcon:  IconButton(
                onPressed: () async{
                  if(parent_id!=null)
                    {
                      final pref=await SharedPreferences.getInstance();
                      var user_id=pref.getString('user_id');
                      var dio= Dio();
                      var formData = FormData.fromMap({
                        'user_id': user_id,
                        'parentid': parent_id.toString(),
                        'comment_id':comment_id.toString(),
                        'comnt_comment':comment.text.toString()
                      });
                      print(formData.fields.toString());
                      var response = await dio.post('https://community.creditmywallet.in.net/api/comment_forum_reply',data: formData);
                      var res=response.data;
                      comment.clear();
                      setState(() {
                        print(response.toString()+"&&&***(((()))");
                      });
                    }
                  else
                    {
                      final pref=await SharedPreferences.getInstance();
                      var user_id=pref.getString('user_id');
                      var dio= Dio();
                      var formData = FormData.fromMap({
                        'user_id': user_id,
                        'forum_id' :"${widget.forum_id}",
                        'comnt_comment':comment.text.toString()
                      });
                      print(formData.fields.toString());
                      var response = await dio.post('https://community.creditmywallet.in.net/api/comment_forum',data: formData);
                      var res=response.data;
                      comment.clear();
                      setState(() {
                        print(response.toString()+"&&&***(((()))");
                      });
                    }
                },
                icon: Icon(Icons.send,color: Colors.black,),
              ),
          ),
        ),
      ),
    );
  }
}
