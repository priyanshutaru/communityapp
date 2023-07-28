import 'dart:convert';
import 'package:communityapp/screens/Chat/chat_list_horizontal_model.dart';
import 'package:communityapp/screens/Chat/get_message_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatDetail extends StatefulWidget {
  String? userid,name,img;

   ChatDetail({required this.userid, required this.name, required this.img});

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {

  TextEditingController comment=TextEditingController();
  String? user_id;
  Future <List<Response_Message>> get_message() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'sender_id':user_id,
      'receiver_id':"${widget.userid}"
    };
    print(data.toString());
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_message");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type":
    "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['response'];
      print(data);
      return data.map((job) => Response_Message.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }


  String? chat;
  String? chat_dt_time;
  String formatTimeOfDay(chat) {
    chat_dt_time = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(chat!));
    return " ${chat_dt_time}";
  }

  @override
  void initState() {
    super.initState();
    msg_user_id();
    setState(() {
    });
  }
  void msg_user_id() async{
    final pref=await SharedPreferences.getInstance();
    user_id=pref.getString('user_id');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.brown[100],
        toolbarHeight: 70,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage("${widget.img.toString()}"),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.name}",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: Colors.black),
            ),

          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                )),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child:  Column(
            children: [
              FutureBuilder <List<Response_Message>>(
                  future: get_message(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Response_Message>? data = snapshot.data;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 22 / 4,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 3,
                            crossAxisCount: 1),
                        itemBuilder: (BuildContext, int index) {
                          chat=data[index].sendTime.toString();
                          return Container(
                            padding: EdgeInsets.only(top: 5),
                            child: data[index].userId!=user_id?
                            Padding(
                              padding: EdgeInsets.only(bottom: 1),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrange.shade200,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(16)
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(12),
                                            child: Text(data[index].sendMsg.toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontFamily: 'SairaCondensed'
                                              ),),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(formatTimeOfDay(chat).toString(),
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    color: Colors.white
                                                ),),
                                              SizedBox(
                                                width: 70,
                                              )
                                            ],
                                          )

                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ):
                            Padding(
                              padding: EdgeInsets.only(bottom: 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey.shade300,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                            bottomLeft: Radius.circular(16),
                                            bottomRight: Radius.circular(0)
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(12),
                                            child: Text(data[index].sendMsg.toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontFamily: 'SairaCondensed'
                                              ),),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [

                                              Text(formatTimeOfDay(chat).toString(),
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    color: Colors.white
                                                ),),

                                            ],
                                          )

                                        ],
                                      )
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Text("No Message");
                  }),
              SizedBox(
                height: 90,
              )
            ],
          ),
        )
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(left: 0,top: 30),
        child: Row(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Container(
                height: 48,
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.brown[50]),
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    //textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.multiline,
                    maxLines: 20,
                    controller: comment,
                    decoration: InputDecoration(
                      hintText: 'Share your emotion here...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () async{
                  final pref=await SharedPreferences.getInstance();
                  var user_id=pref.getString('user_id');
                  var dio= Dio();
                  var formData = FormData.fromMap({
                    'sender_id': user_id,
                    'receiver_id':"${widget.userid}",
                    'send_msg':comment.text
                  });
                  print(formData.fields.toString());
                  var response = await dio.post('https://community.creditmywallet.in.net/api/send_message',data: formData);
                  setState(() {
                    var res=response.data;
                    print(res.toString());
                  });
                  comment.clear();
                  setState(() {

                  });
                },
                icon: Icon(Icons.send))

          ],
        ),
      ),
    );
  }
}
