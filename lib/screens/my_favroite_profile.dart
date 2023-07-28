import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/auth/my_favorite_profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/membersearch/member_search_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyFavroiteProfile extends StatefulWidget {
  const MyFavroiteProfile({Key? key}) : super(key: key);

  @override
  State<MyFavroiteProfile> createState() => _MyFavroiteProfileState();
}

class _MyFavroiteProfileState extends State<MyFavroiteProfile> {

  Future <List<Favorite>> favorite_profile() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id': user_id,
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/my_follow");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      print("eohjhkhkdvjhxvxvjh%%%%%%%%%%"+data.toString()+"eohjhkhkdvjhxvxvjh%%%%%%%%%%");
      print(data);
      return data.map((job) => Favorite.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }


  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC6117',
    };
    var url = Uri.parse("https://community.creditmywallet.in.net/api/get_banner");
    var body=jsonEncode(data);
    final response = await http.post(url,
        headers:{"Content-Type": "application/json"},body: body);
    var res =json.decode(response.body);
    setState(() {
      Banner = res;
    });
  }

  @override
  void initState() {
    super.initState();
    get_banner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 241, 247, 252),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)
            )
        ),
        elevation: 1,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        title: Text(
          "My Favroite Profiles",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xff000000)),
        ),
      ),
      body:  Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 22),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width:
                                      2.0, // This would be the width of the underline
                                    )
                                )
                            ),
                            child: Text(
                              "My Favroit Profiles",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder <List<Favorite>>(
                future: favorite_profile(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Favorite>? data = snapshot.data;
                    return Expanded(
                      child: ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: (BuildContext context,int index){
                            return
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => MemberSearchProfile(
                                        user_id: data[index].userId.toString(),
                                      )));
                                },
                                child: Container(
                                  child: Center(
                                    child: Container(
                                      height: MediaQuery.of(context).size.height * 0.20,
                                      width: MediaQuery.of(context).size.width * 0.95,
                                      child: Card(
                                        color: Color.fromARGB(255, 228, 238, 247),
                                        shape:
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(top: 15, left: 10),
                                                  child: Container(
                                                    height: 60, width: 60,
                                                    alignment: Alignment.topCenter,
                                                    child: Image.network(data[index].profileImg.toString(),),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.55,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(top: 12, left: 10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(data[index].firstName.toString()+" "+
                                                            data[index].middleName.toString(),
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: 14,
                                                              color: Color(0xff3E3E3E)),
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(data[index].userF1CDistrk.toString(),
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 13,
                                                              color: Color(0xff989595)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () async{
                                                    },
                                                  icon: Icon(Icons.favorite,color: Colors.red,),
                                                ),
                                              ],
                                            ),
                                            Divider(),
                                            Padding(
                                              padding: EdgeInsets.only(left: 15, right: 15),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Surgeon",
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 13,
                                                        color: Color(0xff656565)),
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.push(context, MaterialPageRoute(
                                                            builder: (context) => MemberSearchProfile(
                                                              user_id: data[index].userId.toString(),)
                                                        ));
                                                      },
                                                      child: Text("View Profile",
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          color: Color(0xff4D8AEB),
                                                          fontSize: 12,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                          }
                      ),);
                  }
                  return Text("No Data Found");
                }
                ),
            SizedBox(
              height: 11,
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
    );
  }
}
