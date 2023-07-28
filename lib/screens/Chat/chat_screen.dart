import 'dart:convert';
import 'package:card_loading/card_loading.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/Chat/chat_detail.dart';
import 'package:communityapp/screens/Chat/chat_list_horizontal_model.dart';
import 'package:communityapp/screens/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  Future <List<Chat_horizontal>> chat_vertical() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id':user_id,
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/chat_lists");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type":
    "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['response'];
      print(data);
      return data.map((job) => Chat_horizontal.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  List recent=[];
  Future recent_chat() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id':user_id,
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/recent_chats");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type":
    "application/json"},body: body);
    var res = await json.decode(response.body)['response'];
    print("response12" + response.body);

    if (response.statusCode == 200) {
      setState(() {
        recent = res;
        print("%%%%%%%%%%5555"+recent.toString());
      });
    }
  }
  TextEditingController search=TextEditingController();
  String search_string="";

  @override
  void initState() {
    super.initState();
    recent_chat();
    chat_vertical();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.white,
                  child: TextFormField(
                    textInputAction: TextInputAction.search,
                    controller: search,
                    onChanged: (String? value){
                      setState(() {
                        search_string=value.toString();
                      });
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(14),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "Search messages......"),
                  ),
                ),
              ),
              SizedBox(
                height: 11,
              ),
              Padding(
                padding: EdgeInsets.only(left: 28),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.32,
                          height: 30,
                          decoration: BoxDecoration(
                          ),
                          child: Text(
                            "Recent Chats",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
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
              recent.length!=0?
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                height: 90,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recent.length,
                    itemBuilder: (BuildContext context,int index)
                    {
                      return  InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => ChatDetail(
                                    userid: recent[index]['user_id'].toString(),
                                    name: recent[index]['first_name'].toString(),
                                    img: recent[index]['photo'].toString(),
                                  )
                              ));
                        },
                        child: Container(
                          width: 70,
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.amber,
                                backgroundImage: NetworkImage(recent[index]['photo'].toString()),
                                radius: 30,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 50, top: 30),
                                  child: CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.green,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(recent[index]['first_name'].toString()+""+recent[index]['middle_name'].toString(),
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ):
                  Text("No Recent Chat"),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: 25,
                          decoration: BoxDecoration(
                          ),
                          child: Text(
                            "Chats",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                            top: 22,
                            child: Container(
                              height: 2,
                              width: MediaQuery.of(context).size.width * 0.43,
                              color: Colors.black,
                            )
                        )
                      ],
                    )

                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),

              FutureBuilder <List<Chat_horizontal>>(
                  future: chat_vertical(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Chat_horizontal>? data = snapshot.data;
                      return data!.length!=0?
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 32 / 6,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 3,
                            crossAxisCount: 1),
                        itemBuilder: (BuildContext, int index) {
                          late String postion=data[index].firstName.toString();
                          if(search.text.isEmpty)
                          {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatDetail(
                                          userid: data[index].userId.toString(),
                                          name: data[index].firstName.toString(),
                                          img: data[index].photo.toString(),
                                        )
                                    ));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Container(
                                    width: 100,
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 1),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  CircleAvatar(
                                                      backgroundColor: Colors.amber,
                                                      backgroundImage: NetworkImage(data[index].photo.toString()),
                                                      radius: 28,
                                                      child: const Padding(
                                                        padding: EdgeInsets.only(left: 60, top: 55),
                                                        child: CircleAvatar(
                                                          radius: 2,
                                                          backgroundColor: Colors.green,
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(data[index].firstName.toString()+" "+data[index].middleName.toString(),
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black54,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width * 0.50,
                                                        height: 35,
                                                        child: Text(data[index].lastMessage.toString(),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.black26,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Column(
                                                    children: [
                                                      Text(data[index].duration.toString(),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: 7),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          else if(postion.toLowerCase().contains(search.text.toLowerCase()))
                          {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatDetail(
                                          userid: data[index].userId.toString(),
                                          name: data[index].firstName.toString(),
                                          img: data[index].photo.toString(),
                                        )
                                    ));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Container(
                                    width: 100,
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  CircleAvatar(
                                                      backgroundColor: Colors.amber,
                                                      backgroundImage: NetworkImage(data[index].photo.toString()),
                                                      radius: 28,
                                                      child: const Padding(
                                                        padding: EdgeInsets.only(left: 60, top: 55),
                                                        child: CircleAvatar(
                                                          radius: 2,
                                                          backgroundColor: Colors.green,
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(data[index].firstName.toString()+" "+data[index].middleName.toString(),
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black54,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width * 0.50,
                                                        height: 35,
                                                        child: Text(data[index].lastMessage.toString(),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.black26,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Column(
                                                    children: [
                                                      Text(data[index].duration.toString(),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.normal,
                                                            fontSize: 7),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      data[index].unseenMsg!=0?
                                                      CircleAvatar(
                                                        backgroundColor: Colors.green,
                                                        radius: 10,
                                                        child: Text(data[index].unseenMsg.toString(),
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 10),
                                                        ),
                                                      ):
                                                      Text(""),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          else
                          {
                            return Container();
                          }
                        },
                      ):
                      Text("No Chats");
                    }
                    return CardLoading(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _chat(img,
      String text,) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 70,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amber,
                  backgroundImage: AssetImage(img),
                  radius: 30,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 50, top: 30),
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _members(img, String name, String chat, var time, var messages) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        width: 100,
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 3, bottom: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Loginpage()));
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.amber,
                            backgroundImage: AssetImage(img),
                            radius: 28,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 60, top: 55),
                              child: CircleAvatar(
                                radius: 2,
                                backgroundColor: Colors.green,
                              ),
                            )),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.55,
                            height: 35,
                            child: Text(
                              chat,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            time,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 12),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 10,
                            child: Text(
                              messages,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}
