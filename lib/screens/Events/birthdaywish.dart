import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Chat/chat_detail.dart';
import 'package:communityapp/screens/auth/get_birthday_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class BirthdayWish extends StatefulWidget {
  const BirthdayWish({Key? key}) : super(key: key);

  @override
  State<BirthdayWish> createState() => _BirthdayWishState();
}

class _BirthdayWishState extends State<BirthdayWish> {
  String dropdownvalue = 'Short';

  // List of items in our dropdown menu
  var items = [
    'Short',
    'Earlier',
    'Favourite',
  ];


  Future <List<Birthday>> get_Birthday() async {
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_birtday");
    final response = await http.get(url, headers: {"Content-Type":
    "application/json"});
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['details'];
      print(data);
      return data.map((job) => Birthday.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC5359',
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
      get_Birthday();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 231, 230, 230),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_new_outlined),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.78,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    '     Search Birthday Here...',
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.search)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.black,
                          width: 1.0, // This would be the width of the underline
                        ))),
                        child:Padding(padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Today's Birthday",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        )
                      ),
                    ],
                  ),
                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.05,
                  //   width: MediaQuery.of(context).size.width * 0.3,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: Color(0xffF5F1F1)),
                  //   child: DropdownButtonHideUnderline(
                  //     child: DropdownButton(
                  //       value: dropdownvalue,
                  //       icon: const Icon(
                  //         Icons.arrow_drop_down,
                  //       ),
                  //       items: items.map((String items) {
                  //         return DropdownMenuItem(
                  //           value: items,
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(left: 6),
                  //             child: Text(
                  //               items,
                  //               style: TextStyle(color: Colors.black54),
                  //             ),
                  //           ),
                  //         );
                  //       }).toList(),
                  //       onChanged: (String? newValue) {
                  //         setState(() {
                  //           dropdownvalue = newValue!;
                  //         });
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder <List<Birthday>>(
                  future: get_Birthday(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Birthday>? data = snapshot.data;
                      return data!.length!=0?
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 28 / 8,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 3,
                            crossAxisCount: 1),
                        itemBuilder: (BuildContext, int index) {
                          return Card(
                            color: Color.fromARGB(255, 241, 240, 240),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [

                                Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child: Container(
                                    // color: Color(0xffF8F5F5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 15, right: 15),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Colors.brown[100],
                                                radius: 30,
                                                backgroundImage: NetworkImage(data[index].profileImg.toString()),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(data[index].firstName.toString()+" "+data[index].middleName.toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black87),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(data[index].userF1CDistrk.toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black45),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text("turning "+data[index].turning.toString()+" years old",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color.fromARGB(255, 149, 196, 152)),
                                                  )
                                                ],
                                              ),
                                              Spacer(),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context)=>ChatDetail(
                                                        userid: data[index].userId.toString(),
                                                        name: data[index].firstName.toString(),
                                                        img: data[index].profileImg.toString(),
                                                      )));
                                                },
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                            height: 30,
                                                            width: 30,
                                                            child: Image.asset(
                                                              "assets/images/send.png",
                                                            )),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            "Send Wishes",
                                                            style:
                                                            TextStyle(fontSize: 12, color: Colors.blue),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )

                                            ],
                                          ),
                                        ),
                                        Divider()
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ):
                      Text("No Birthday");
                    }
                    return Text("No Birthday");
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
