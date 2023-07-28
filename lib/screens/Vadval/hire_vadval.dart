import 'dart:convert';
import 'package:communityapp/screens/Vadval/vadval_profile.dart';
import 'package:communityapp/screens/auth/get_hire_a_vadaval_model.dart';
import 'package:communityapp/screens/auth/search_hire_vadaval.dart';
import 'package:communityapp/screens/membersearch/member_search_profile.dart';
import 'package:communityapp/screens/myProfile.dart';
import 'package:communityapp/screens/profile_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Vadval/vadval_strong.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HireAVadval extends StatefulWidget {
  const HireAVadval({Key? key}) : super(key: key);

  @override
  State<HireAVadval> createState() => _HireAVadvalState();
}

class _HireAVadvalState extends State<HireAVadval> {

  String dropdownvalue4 = 'Clerical';
  var items4 = [
    'Clerical',
    'Technical',
  ];
  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC67569',
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

  String? Category;
  String? sub_Category;
  String? location;
  String? district;
  List get_quali_list=[];
  String? qId;
  String? quali;
  Future  get_Qualifications() async{
    var url="https://community.creditmywallet.in.net/api/get_qua";
    http.Response response=await http.post(Uri.parse(url));
    var res=jsonDecode(response.body)['details'];
    setState(() {
      print("%%%%%%%%%%%%"+res.toString());
      get_quali_list=res;
      quali = res['q_id'];
      print(quali.toString()+"hgvshdsdhsg");
      print(get_quali_list.toString()+"%%%%%%%%%%%%%%%%");
    });
  }

  List get_city_list=[];
  Future  get_city() async{
    var url="https://community.creditmywallet.in.net/api/get_state";
    http.Response response=await http.post(Uri.parse(url));
    var res=jsonDecode(response.body)['state'];
    setState(() {
      print("%%%%%%%%%%%%"+res.toString());
      get_city_list=res;
      print(get_city_list.toString()+"%%%%%%%%%%%%%%%%");
    });

  }

  List get_district_list=[];
  Future  get_District() async{
    Map data={
      "state_id":location.toString(),
    };
    setState(() {
      print(Category.toString()+"BBBBBBBBBBBBBBB");
    });
    var url="https://community.creditmywallet.in.net/api/get_dist";
    var body1=jsonEncode(data);
    http.Response response=await http.post(Uri.parse(url),headers: {"Content-Type":"application/json"}, body: body1);
    var res=jsonDecode(response.body)['state'];
    setState(() {
      print("%%%%%FFFFFFFFFFFf%%%%%%%"+res.toString());
      get_district_list=res;
      print(get_district_list.toString()+"%%%%%%%%%%%%%%%%");
    });

  }

  List bussiness_Category=[];
  Future  bussi_Category() async{
    var url="https://community.creditmywallet.in.net/api/get_business_cat";
    http.Response response=await http.post(Uri.parse(url));
    var res=jsonDecode(response.body)['data'];
    setState(() {
      // print("%%%%%%%%%%%%"+res.toString());
      bussiness_Category=res;
      print(bussiness_Category.toString()+"%%%%%%%%%%%%%%%%");
    });

  }

  List bussiness_Sub_Category=[];
  Future  bussi_Sub_Category() async{
    Map data={
      "category_id":Category.toString(),
    };
    setState(() {
      print(Category.toString()+"BBBBBBBBBBBBBBB");
    });
    var url="https://community.creditmywallet.in.net/api/get_business_sub_cat";
    var body1=jsonEncode(data);
    http.Response response=await http.post(Uri.parse(url),headers: {"Content-Type":"application/json"}, body: body1);
    var res=jsonDecode(response.body)['data'];
    setState(() {
      print("%%%%%FFFFFFFFFFFf%%%%%%%"+res.toString());
      bussiness_Sub_Category=res;
      print(bussiness_Sub_Category.toString()+"%%%%%%%%%%%%%%%%");
    });

  }


   Future <List<SearchList>> search_vadval() async {
    Map data={
      'category':Category.toString(),
      'sub_category':sub_Category.toString(),
      'qualification':qId.toString(),
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/hire_a_vadval");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['list'];
      print(data.toString()+"%%%%%%%%%%");
      return data.map((job1) => SearchList.fromJson(job1)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }



  Future <List<Vadval>> get_hire_vadaval() async {
     final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      "user_id":user_id.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/hire_a_vadval_random");
    var data1 = jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body:data1);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['vadval'];
      print("hhhh"+data.toString()+"%%%%%%%%%%");
      print(data);
      return data.map((job) => Vadval.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      get_banner();
      get_Qualifications();
      get_city();
      get_hire_vadaval();
      bussi_Category();
      bussi_Sub_Category();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F8FB),
      appBar: AppBar(
        backgroundColor: Color(0xffEEEEEE),
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        elevation: 0,
        leading: Padding(
          padding:  EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 22,
            ),
          ),
        ),
        title: Text(
          "Hire a Vadval",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xff000000)),
        ),
      ),
      body: Banner.length!=0? SingleChildScrollView(
        child: Column(
          children: [
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
            Padding(
              padding: EdgeInsets.only(left: 22),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 25,
                        decoration: BoxDecoration(
                        ),
                        child: Text(
                          "Search for Open to work condidate",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff000000)),
                        ),
                      ),
                      Positioned(
                          top: 22,
                          child: Container(
                            height: 2,
                            width: MediaQuery.of(context).size.width * 0.47,
                            color: Colors.black,
                          )
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
                 Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 3, bottom: 3),
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width/2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: Category,
                              hint: Text("      Category"),
                              icon: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(Icons.arrow_drop_down),
                              ),
                              items: bussiness_Category.map((item) {
                                return DropdownMenuItem(
                                  value: item['category_id'].toString(),
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: 30),
                                    child: Text(
                                      item['category_name'].toString(),
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  setState((){
                                    Category = newValue! as String?;
                                    bussi_Sub_Category();
                                  });
                                  print(Category.toString()+"&&&&&&&&&");
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(top: 3, bottom: 3),
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width/2.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: sub_Category,
                              hint: Text("      Sub-Category"),
                              icon: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(Icons.arrow_drop_down),
                              ),
                              items: bussiness_Sub_Category.map((item) {
                                return DropdownMenuItem(
                                  value: item['subcategory_id'].toString(),
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: 10),
                                    child: Text(
                                      item['subcategory_name'].toString(),
                                      style: TextStyle(color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  sub_Category = newValue! as String?;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            SizedBox(
              height: 20,
            ),
            //  Padding(
            //   padding: EdgeInsets.only(top: 3, bottom: 3),
            //   child: Container(
            //     height: 40,
            //     width: MediaQuery.of(context).size.width * .9,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: Colors.white),
            //     child: DropdownButtonHideUnderline(
            //       child: DropdownButton(
            //         value: location,
            //         hint: Text("      State"),
            //         icon: Padding(
            //           padding: EdgeInsets.only(right: 20),
            //           child: Icon(Icons.arrow_drop_down),
            //         ),
            //         items: get_city_list.map((item) {
            //           return DropdownMenuItem(
            //             value: item['state_id'].toString(),
            //             child: Padding(
            //               padding:  EdgeInsets.only(left: 30),
            //               child: Text(
            //                 item['state_title'].toString(),
            //                 style: TextStyle(color: Colors.black54),
            //               ),
            //             ),
            //           );
            //         }).toList(),
            //         onChanged: (newValue) {
            //           setState(() {
            //             setState((){
            //               location = newValue! as String?;
            //               print(location.toString());
            //               get_District();
            //             });
            //           });
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 3,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(top: 3, bottom: 3),
            //   child: Container(
            //     height: 40,
            //     width: MediaQuery.of(context).size.width * .9,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: Colors.white),
            //     child: DropdownButtonHideUnderline(
            //       child: DropdownButton(
            //         value: district,
            //         hint: Text("      District"),
            //         icon: Padding(
            //           padding: EdgeInsets.only(right: 20),
            //           child: Icon(Icons.arrow_drop_down),
            //         ),
            //         items: get_district_list.map((item) {
            //           return DropdownMenuItem(
            //             value: item['districtid'].toString(),
            //             child: Padding(
            //               padding:  EdgeInsets.only(left: 30),
            //               child: Text(
            //                 item['district_title'].toString(),
            //                 style: TextStyle(color: Colors.black54),
            //               ),
            //             ),
            //           );
            //         }).toList(),
            //         onChanged: (newValue) {
            //           setState(() {
            //             setState((){
            //               district = newValue! as String?;
            //               print(district.toString());
            //             });
            //           });
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 3, bottom: 3),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: qId,
                        hint: Text("      Qualifications"),
                        icon: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(Icons.arrow_drop_down),
                        ),
                        items: get_quali_list.map((item) {
                          return DropdownMenuItem(
                            value: item['q_id'].toString(),
                            child: Padding(
                              padding:  EdgeInsets.only(left: 30),
                              child: Text(
                                item['qualification'].toString(),
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                            setState((){
                              qId = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 19,
            ),
            Padding(
              padding: EdgeInsets.only(left: 22),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 25,
                        decoration: BoxDecoration(
                        ),
                        child: Text(
                          "Search Result",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff000000)),
                        ),
                      ),
                      Positioned(
                          top: 22,
                          child: Container(
                            height: 2,
                            width: MediaQuery.of(context).size.width * 0.2,
                            color: Colors.black,
                          )
                      )
                    ],
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            qId==null?
            FutureBuilder <List<Vadval>>(
                future: get_hire_vadaval(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Vadval> ? data = snapshot.data;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics:  NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 17/ 8,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 3,
                          crossAxisCount: 1
                      ),
                      itemBuilder: (BuildContext, int index) {
                        return data.length!=0?
                        InkWell(
                            onTap: () async {
                              // final pref=await SharedPreferences.getInstance();
                              // var user_id=pref.getString('user_id');
                              // Navigator.push(context, MaterialPageRoute(
                              //     builder: (context)=>VadvalProfile(
                              //       // mat_id:user_id.toString() ,
                              //
                              //     )));
                            },
                            child:  Container(
                              color: Color(0xffFFFFFF),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                       Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child:
                                               Container(
                                                height: 110, width: 90,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    image: DecorationImage(
                                                        image: NetworkImage(data[index].profileImg.toString()),
                                                        fit: BoxFit.fill)),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.65,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(data[index].firstName.toString()+" "+data[index].middleName.toString(),
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: 14,
                                                              color: Color(0xffFA6393)),
                                                        ),
                                                        TextButton(
                                                            onPressed: () async{
                                                              final pref = await SharedPreferences.getInstance();
                                                              var id = pref.getString('user_id');
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MemberSearchProfile(user_id:id.toString())));
                                                            },
                                                            child: const Text("View Profile",
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.w700,
                                                                  color: Color(0xff4D8AEB),
                                                                  fontSize: 12,
                                                                )
                                                            )
                                                        )
                                                      ],
                                                    ),
                                                    Text(data[index].qualification.toString(),
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 12,
                                                          color: Color(0xff878383)),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(data[index].profession.toString(),
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 12,
                                                          color: Color(0xff878383)),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(data[index].districtTitle.toString(),
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 12,
                                                          color: Color(0xff878383)),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        // mainAxisAlignment: MainAxisAlignment
                                                        //     .spaceBetween,
                                                        children: [
                                                          Text(data[index].categoryName.toString(),
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 12,
                                                                color: Color(0xff707070)),
                                                          ),
                                                          SizedBox(width: 30,),
                                                          Row(
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 6,
                                                                backgroundColor: Colors.green,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(data[index].subcategoryName.toString(),
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: 12,
                                                                    color: Color(0xff707070)),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: Text(data[index].bio.toString(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff989595),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                            )
                        ):Text("No Vadval to hire");
                      },
                    );
                  }
                  return Text("No Vadval to hire");
                }):
               FutureBuilder <List<SearchList>>(
                future: search_vadval(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<SearchList>? data = snapshot.data;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics:  NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 17/ 8,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 3,
                          crossAxisCount: 1
                      ),
                      itemBuilder: (BuildContext, int index) {
                        return data.length!=0?
                        InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>VadavalStrong()));
                            },
                            child: Container(
                              color: Color(0xffFFFFFF),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Container(
                                                height: 110, width: 90,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    image: DecorationImage(
                                                        image: NetworkImage(data[index].profileImg.toString()),
                                                        fit: BoxFit.fill)),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.65,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(data[index].firstName.toString()+" "+data[index].middleName.toString(),
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: 14,
                                                              color: Color(0xffFA6393)),
                                                        ),
                                                        TextButton(
                                                            onPressed: () {
                                                              // setState(() {
                                                              //   Future get_user_profile() async{
                                                              //     final pref=await SharedPreferences.getInstance();
                                                              //     var get=pref.getString('user_id');
                                                              //     Map data={
                                                              //       'user_id':get.toString()
                                                              //     };
                                                              //     Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_user_prof");
                                                              //     var body=jsonEncode(data);
                                                              //     var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
                                                              //     var res=json.decode(response.body);
                                                              //     var ms=jsonDecode(response.body)['current_shakha'];
                                                              //     print(ms.toString());
                                                              //     setState(() {
                                                              //
                                                              //     });
                                                              //   }
                                                              // });
                                                            },
                                                            child: const Text("View Profile",
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.w700,
                                                                  color: Color(0xff4D8AEB),
                                                                  fontSize: 12,
                                                                )
                                                            )
                                                        )
                                                      ],
                                                    ),
                                                    Text(data[index].qualification.toString(),
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 12,
                                                          color: Color(0xff878383)),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text("Android app developer(profession)",
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 12,
                                                          color: Color(0xff878383)),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(data[index].districtTitle.toString(),
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 12,
                                                          color: Color(0xff878383)),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(data[index].categoryName.toString(),
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 12,
                                                                color: Color(0xff707070)),
                                                          ),
                                                          Row(
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 6,
                                                                backgroundColor: Colors.green,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(data[index].subcategoryName.toString(),
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: 12,
                                                                    color: Color(0xff707070)),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: Text(data[index].bio.toString(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff989595),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                            )
                        ):Text("No Vadval to Hire ");
                      },
                    );
                  }
                  return Text("No Vadval to Hire");
                }),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ):
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      // you can replace this with Image.asset
                      'assets/images/splash.png',
                      fit: BoxFit.cover,
                      height: 70,
                      width: 70,
                    ),
                    // you can replace
                    Container(
                      height: 80,
                      width: 80,
                      child:
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                        strokeWidth: 1.5,

                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text( 'Finding Vadval...',style: TextStyle(color: Colors.pink,fontSize: 17),),
              ]
          ),
        ],
      )
    );
  }
}
