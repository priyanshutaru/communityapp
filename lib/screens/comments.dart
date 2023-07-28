import 'dart:convert';
import 'package:communityapp/screens/membersearch/member_search_profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/auth/get_comment_sanskriti_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Comments extends StatefulWidget {
  String? userid,post_id,total_comme;
  Comments({
    required this.userid,
    required this.post_id,
    required this.total_comme
  });

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  TextEditingController comment=TextEditingController();


  Future <List<Comment>> get_comment() async {
    Map data={
      "post_id":"${widget.post_id.toString()}"
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_s_post_comm");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type":
    "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      print(data);
      return data.map((job) => Comment.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      print("${widget.post_id}");
    });
  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 235, 233, 233),
        leading:IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ) ,
        title: Text(
          "Comments",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
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
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.chat_sharp,
                    size: 22,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("${widget.total_comme}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder <List<Comment>>(
                  future: get_comment(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Comment>? data = snapshot.data;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics:  NeverScrollableScrollPhysics(),
                        itemCount: data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 23/ 8,
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
                                                Text(data[index].firstName.toString()+" "+data[index].lastName.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                ),
                                                Text(data[index].dob.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold, color: Colors
                                                      .black45),
                                                )
                                              ],
                                            ),
                                            Spacer(),
                                            "${widget.userid}"==data[index].userId ?
                                            IconButton(
                                                onPressed: () async{
                                                  var dio= Dio();
                                                  var formData = FormData.fromMap({
                                                    'post_id':data[index].postId.toString(),
                                                    "comment_id":data[index].commentId.toString()
                                                  });
                                                  print(formData.fields.toString());
                                                  setState(() {

                                                  });
                                                  var response = await dio.post('https://community.creditmywallet.in.net/api/trash_s_post_comm',data: formData);
                                                  setState(() { });
                                                  var res=response.data;
                                                  var msg=res['data'];

                                                  if(res["data"]=="Comment Deleted")
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
                                                icon: Icon(Icons.delete)
                                            ):
                                            Text(""),
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
              height: 90,
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
                      'user_id': user_id.toString(),
                      'post_id':"${widget.post_id}",
                      'comment':comment.text.toString()
                    });
                    print(formData.fields.toString());
                    var response = await dio.post('https://community.creditmywallet.in.net/api/add_s_post_comm',data: formData);
                    var res=response.data;
                    comment.clear();
                    setState(() {
                      print(response.toString()+"&&&***(((()))");
                    });
                  },
                  icon: Icon(Icons.send,color: Colors.black,),
                ),

            ),
          ),
        ),
    );
  }
}
