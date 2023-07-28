import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/membersearch/advance_search_model.dart';
import 'package:communityapp/screens/membersearch/member_search_profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'member_search_model.dart';


class MemberSearchResult extends StatefulWidget {
  String? name,first_name,last_name,shakha,gender,membership,profession,qualification,district;
  MemberSearchResult({
    required this.name,
    required this.first_name,
    required this.last_name,
    required this.shakha,
    required this.gender,
    required this.membership,
    required this.profession,
    required this.qualification,
    required this.district,
  });

  @override
  State<MemberSearchResult> createState() => _MemberSearchResultState();
}

class _MemberSearchResultState extends State<MemberSearchResult> {


  Future <List<Data>> member_search1() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id': user_id.toString(),
      'first_name':"${widget.first_name}",
      'last_name':"${widget.last_name}",
      'shakha':"${widget.shakha}",
    };
    print(data.toString());
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/member_search");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      print("eohjhkhkdvjhxvxvjh%%%%%%%%%%"+data.toString()+"eohjhkhkdvjhxvxvjh%%%%%%%%%%");
      print(data);
      return data.map((job) => Data.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }


  Future <List<Advance_Data>> Advance_search() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id': user_id.toString(),
      'first_name':"${widget.first_name}",
      'last_name':"${widget.last_name}",
      'shakha':"${widget.shakha}",
      'gender': "${widget.gender}",
      'membership':"${widget.membership}",
      'profession':"${widget.profession}",
      'qualification':"${widget.qualification}",
      'district':"${widget.district}",
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/advance_member_search");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      print("eohjhkhkdvjhxvxvjh%%%%%%%%%%"+data.toString()+"eohjhkhkdvjhxvxvjh%%%%%%%%%%");
      print(data);
      return data.map((job) => Advance_Data.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC38898',
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

  String? me_name,me_last;
  int? me_total;
  Future get_meber_search() async{
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id': user_id,
      'first_name':"${widget.first_name}",
      'last_name':"${widget.last_name}",
      'shakha':"${widget.shakha}",
    };
    print(data.toString());
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/member_search");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    var res=jsonDecode(response.body);
    setState(() {
      me_name=res['data'][0]['first_name'];
      me_last=res['data'][0]['last_name'];
      me_total=res['total_result_found'];
    });
  }

  String? ad_name,ad_last;
  int? ad_total;
  Future get_advance_search() async{
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id': user_id.toString(),
      'first_name':"${widget.first_name}",
      'last_name':"${widget.last_name}",
      'shakha':"${widget.shakha}",
      'gender': "${widget.gender}",
      'membership':"${widget.membership}",
      'profession':"${widget.profession}",
      'qualification':"${widget.qualification}",
      'district':"${widget.district}",
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/advance_member_search");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    var res=jsonDecode(response.body);
    setState(() {
      ad_name=res['data'][0]['first_name'];
      ad_last=res['data'][0]['last_name'];
      ad_total=res['total_result_found'];
    });
  }


  @override
  void initState() {
    super.initState();
    get_banner();
    get_meber_search();
    get_advance_search();
    Advance_search();
    member_search1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 247, 252),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color.fromARGB(255, 228, 238, 247),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Member Search Result",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xff000000)),
        ),
      ),
      body: Column(
        children: [
          "${widget.name}"=="Search"?
          Padding(
            padding: EdgeInsets.only(top: 10, left: 15),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  me_name!=null?Text(
                    "Hey!! "+me_name![0].toUpperCase().toString()+me_name!.replaceRange(0, 1, "")+" "+me_last![0].toUpperCase().toString()+me_last!.replaceRange(0, 1, ""),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff615F5F)),
                  ):
                  Text(
                    "Hey!! ",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff615F5F)),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  me_total!=null?
                  Text(me_total.toString()+" matches results found",
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff878383)),
                  ):
                  Text(
                    "0  matches results found",
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff878383)),
                  )
                ],
              ),
            ),
          ):
          Padding(
            padding: EdgeInsets.only(top: 10, left: 15),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ad_name==null?Text(
                    "Hey!! "+ad_name![0].toUpperCase().toString()+ad_name!.replaceRange(0, 1, "")+" "+ad_last![0].toUpperCase().toString()+ad_last!.replaceRange(0, 1, ""),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff615F5F)),
                  ):
                  Text(
                    "Hey!! ",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff615F5F)),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  ad_total!=null?
                  Text(ad_total.toString()+" matches results found",
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff878383)),
                  ):
                  Text(
                    "0  matches results found",
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff878383)),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 11,
          ),
          "${widget.name}"=="Search"?
          FutureBuilder <List<Data>>(
              future: member_search1(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Data>? data = snapshot.data;
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
                                  ))
                              );
                            },
                            child: Container(
                              child: Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.22,
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
                                                height: 60,
                                                width: 60,
                                                alignment: Alignment.topCenter,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(40)
                                                ),
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
                                                        data[index].lastName.toString(),
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
                                                    Text(data[index].districtName.toString(),
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
                                                var dio1 = Dio();
                                                final pref=await SharedPreferences.getInstance();
                                                var user_id=pref.getString('user_id');
                                                var formData = FormData.fromMap({
                                                  'user_id': user_id.toString(),
                                                  'followed_id' : data[index].userId.toString()
                                                });
                                                print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                var response = await dio1.post('https://community.creditmywallet.in.net/api/follow',
                                                    data: formData);
                                                var res=response.data;
                                                setState((){
                                                  print(response.toString()+"%%^^^&*()");
                                                });
                                                setState(() {

                                                });
                                              },
                                              icon: data[index].likeStatus.toString()!='0'?
                                              Icon(Icons.favorite_border):
                                              Icon(Icons.favorite,color: Colors.red,),
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
              }):
              // "${widget.name}"=='Advance Search'?
                FutureBuilder <List<Advance_Data>>(
              future: Advance_search(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Advance_Data>? data = snapshot.data;
                  return  Expanded(
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
                                                height: 60,
                                                width: 60,
                                                alignment: Alignment.topCenter,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(40)
                                                ),
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
                                                var dio1 = Dio();
                                                final pref=await SharedPreferences.getInstance();
                                                var user_id=pref.getString('user_id');
                                                var formData = FormData.fromMap({
                                                  'user_id': user_id,
                                                  'followed_id' : data[index].userId.toString()
                                                });
                                                print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                var response = await dio1.post('https://community.creditmywallet.in.net/api/follow',
                                                    data: formData);
                                                var res=response.data;
                                                setState((){
                                                  print(response.toString()+"%%^^^&*()");
                                                });
                                                setState(() {});
                                              },
                                              icon: data[index].likeStatus.toString()!='0'?
                                              Icon(Icons.favorite_border):
                                              Icon(Icons.favorite,color: Colors.red,),
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
                  ));
                }
                return Text("No Data Found");
              }),
              // :Text("No Data Found"),
          SizedBox(
            height: 14,
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
