
import 'dart:convert';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Business/business_info.dart';
import 'package:communityapp/screens/Business/search_bussiness_model.dart';
import 'package:communityapp/screens/auth/get_hire_a_vadaval_model.dart';
import 'package:communityapp/screens/auth/search_hire_vadaval.dart';
import 'package:communityapp/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:communityapp/screens/auth/my_bussiness_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC86858',
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

List get_quali_list=[];
  String? qId;
  Future  get_Qualifications() async{
    var url="https://community.creditmywallet.in.net/api/get_qua";
    http.Response response=await http.post(Uri.parse(url));
    var res=jsonDecode(response.body)['details'];
    setState(() {
      print("%%%%%%%%%%%%"+res.toString());
      get_quali_list=res;
      print(get_quali_list.toString()+"%%%%%%%%%%%%%%%%");
    });
  }

  String? Category;
  String? sub_Category;
  String? location;
  String? district;
 List vadval_lists = [];
 String? qualification;
  Future vadval_list() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      "user_id":user_id.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/hire_a_vadval_random");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    var res = await json.decode(response.body)['vadval'];
    if (response.statusCode == 200) {
        vadval_lists = res;
       qualification = res['qualification'];
      // print(data.toString()+"%%%%%%%%%%");
      // return data.map((job1) => Vadval.fromJson(job1)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

List search = [];
String? name;
  Future search_vadval() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      "user_id":user_id.toString(),
      'category':Category,
      'sub_category':sub_Category,
      'qualification':qId,
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/hire_a_vadval");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    var res = await json.decode(response.body)['list'];
    if (response.statusCode == 200) {
      setState(() {
       search = res; 
       name = res['name'];
      });
      // print(data.toString()+"%%%%%%%%%%");
      // return data.map((job1) => Search_Vadaval.fromJson(job1)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }


  // Future <List<Search_Vadaval>> search_vadval() async {
  //   Map data={
  //     'category':Category,
  //     'sub_category':sub_Category,
  //     'qualification':qId,
  //   };
  //   print(data.toString());
  //   Uri url = Uri.parse("https://community.creditmywallet.in.net/api/hire_a_vadval");
  //   var body=jsonEncode(data);
  //   final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
  //   // print("hdjhwdhwjhdwhdf"+response.body.toString());
  //   if (response.statusCode == 200) {
  //     List data = json.decode(response.body)['status_message'];
  //     print(data.toString()+"%%%%%%%%%%");
  //     return data.map((job1) => Search_Vadaval.fromJson(job1)).toList();
  //   }
  //   else {
  //     throw Exception('Unexpected error occured!');
  //   }
  // }



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
      // print("%%%%%FFFFFFFFFFFf%%%%%%%"+res.toString());
      bussiness_Sub_Category=res;
      print(bussiness_Sub_Category.toString()+"%%%%%%%%%%%%%%%%");
    });

  }

  @override
  void initState() {
    super.initState();
    setState(() {
      get_banner();
      bussi_Category();
      search_vadval();
      get_Qualifications();
      // vadval_list();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F8FB),
      appBar: AppBar(
        backgroundColor: Color(0xffF4F8FB),
        elevation: 0,
        toolbarHeight: 10,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>Dashboard()));
                    },
                    icon: Icon(Icons.arrow_back_ios)
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: 'Search business here....',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
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
            Padding(
              padding: EdgeInsets.only(left: 22),
              child: Row(
                children: [
                      Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 25,
                              decoration: BoxDecoration(
                              ),
                              child: Text("Search Business by",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff000000)),
                              ),
                            ),
                            Positioned(
                                top: 22,
                                child: Container(
                                  height: 2,
                                  width: MediaQuery.of(context).size.width * 0.25,
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
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
                                    padding:  EdgeInsets.only(left: 30),
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
                    height: 10,
                  ),
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
                          hint: Text("      Qualification"),
                          icon: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.arrow_drop_down),
                          ),
                          items: get_quali_list.map((item) {
                            return DropdownMenuItem(
                              value: item['q_id'].toString(),
                              child: Padding(
                                padding:  EdgeInsets.only(left: 30),
                                child: Text(
                                  item['qualification'].toString(),
                                  style: TextStyle(color: Colors.black54,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              setState((){
                                qId = newValue! as String?;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 21,
            ),
                 SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient:  LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [Colors.blue, Colors.blue.shade100]
                      )
                  ),
                child: InkWell(
                  onTap: () {
                        setState(() {
                         this. search_vadval();
                         
                        });
                  },
                  child: Text(
                    "Search",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xffFFFFFF)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 22),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: 25,
                        decoration: BoxDecoration(
                        ),
                        child: Text(
                          "Search Results:",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff000000)),
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
            SizedBox(
              height: 9,
            ),
                 qualification!=null?
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: GridView.builder(
                        shrinkWrap: true,
                        physics:  NeverScrollableScrollPhysics(),
                        itemCount: search.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 17/ 8,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 3,
                            crossAxisCount: 1
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          print(search[index].name.toString()+"%%%%%%%%%%%");
                          return Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(search[index].qualification.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Color(0xff878383)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                    ),
                      ):
                          Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: GridView.builder(
                        shrinkWrap: true,
                        physics:  NeverScrollableScrollPhysics(),
                        itemCount: vadval_lists.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 17/ 8,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 3,
                            crossAxisCount: 1
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          print(vadval_lists[index].name.toString()+"%%%%%%%%%%%");
                          return Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(vadval_lists[index].qualification.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Color(0xff878383)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                    ),
                      ),
          ],
        ),
      ),
    );
  }
}
