import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Business/business_info.dart';
import 'package:communityapp/screens/Business/search_bussiness_model.dart';
import 'package:communityapp/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:communityapp/screens/auth/my_bussiness_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BusinessList extends StatefulWidget {
  const BusinessList({Key? key}) : super(key: key);

  @override
  State<BusinessList> createState() => _BusinessListState();
}

class _BusinessListState extends State<BusinessList> {

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

  String? Category;
  String? sub_Category;
  String? location;
  String? district;

  Future <List<Data>> my_Bussiness() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      "user_id":user_id.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/my_business");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      print(data.toString()+"%%%%%%%%%%");
      return data.map((job1) => Data.fromJson(job1)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future <List<Search_Bussiness>> search_bussiness() async {
    Map data={
      'category_id':Category,
      'sub_category_id':sub_Category,
      'shakha_id' :current_shakha
    };
    print(data.toString());
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/search_business");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['status_message'];
      print(data.toString()+"%%%%%%%%%%");
      return data.map((job1) => Search_Bussiness.fromJson(job1)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }


  List currentShakha=[];
  String? current_shakha;
  Future getCurrentShakha() async{
    var url="https://community.creditmywallet.in.net/api/get_current_shakha";
    http.Response response=await http.get(Uri.parse(url));
    var res=jsonDecode(response.body)['response_data'];
    setState(() {
      print("%%%%%%%%%%%%"+res.toString());
      currentShakha=res;
      print(currentShakha.toString()+"%%%%%%%%%%%%%%%%");
    });
  }


  List bussiness_Category=[];
  Future  bussi_Category() async{
    var url="https://community.creditmywallet.in.net/api/get_business_cat";
    http.Response response=await http.post(Uri.parse(url));
    var res=jsonDecode(response.body)['data'];
    setState(() {
      print("%%%%%%%%%%%%"+res.toString());
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

  @override
  void initState() {
    super.initState();
    setState(() {
      get_banner();
      getCurrentShakha();
      bussi_Category();
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
      body: Banner.length!=0? SingleChildScrollView(
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
                          value: current_shakha,
                          hint: Text("      Shakha Name"),
                          icon: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.arrow_drop_down),
                          ),
                          items: currentShakha.map((item) {
                            return DropdownMenuItem(
                              value: item['shakha_id'].toString(),
                              child: Padding(
                                padding:  EdgeInsets.only(left: 30),
                                child: Text(
                                  item['shakha_name'].toString(),
                                  style: TextStyle(color: Colors.black54,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              setState((){
                                current_shakha = newValue! as String?;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                 /* SizedBox(
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
                          value: district,
                          hint: Text("      District"),
                          icon: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.arrow_drop_down),
                          ),
                          items: get_district_list.map((item) {
                            return DropdownMenuItem(
                              value: item['districtid'].toString(),
                              child: Padding(
                                padding:  EdgeInsets.only(left: 30),
                                child: Text(
                                  item['district_title'].toString(),
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              setState((){
                                district = newValue! as String?;
                                print(Category.toString());
                                print(sub_Category.toString());
                                print(district.toString());
                              });
                              setState(() {
                                search_bussiness();
                                });
                            });
                          },
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
            SizedBox(
              height: 21,
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
            current_shakha==null?
            FutureBuilder <List<Data>>(
                future: my_Bussiness(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Data>? data = snapshot.data;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics:  NeverScrollableScrollPhysics(),
                      itemCount: data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 17/ 8,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 3,
                          crossAxisCount: 1
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        print(data[index].businessName.toString()+"%%%%%%%%%%%");
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>BusinessInfo(
                                  bussiness_id: data[index].businessId.toString(),
                                )
                            )
                            );
                          },
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: Container(
                                        height: 125, width: 90,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(data[index].profileImg.toString()),
                                              fit: BoxFit.fill),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 12, right: 10),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.58,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(data[index].businessName.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: Color(0xff3E3E3E)),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  child: Image.asset(
                                                    "assets/images/locationc.png",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(data[index].city.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Color(0xff878383)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    height: 20,
                                                    width: 20,
                                                    child: Image.asset(
                                                      "assets/images/cs.png",
                                                      fit: BoxFit.fill,
                                                    )),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(data[index].category.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Color(0xff878383)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    height: 20,
                                                    width: 20,
                                                    child: Image.asset(
                                                      "assets/images/aaaa.png",
                                                      fit: BoxFit.fill,
                                                    )),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "5+ Years",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Color(0xff878383)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  child: Image.asset(
                                                    "assets/images/alarm.png",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(data[index].openingTime.toString()+
                                                    "-"
                                                    +data[index].closingTime.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 10,
                                                      color: Color(0xff878383)),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context)=>BusinessInfo(
                                                          bussiness_id: data[index].businessId.toString(),
                                                        ))
                                                    );
                                                  },
                                                  child: Container(
                                                    child: Center(
                                                      child: Text(
                                                        "View Profile",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                    height: 28,
                                                    width: 76,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(30),
                                                        gradient: LinearGradient(
                                                            begin: Alignment.bottomLeft,
                                                            end: Alignment.bottomRight,
                                                            colors: [
                                                              Colors.blue.shade100,
                                                              Colors.blue.shade400
                                                            ])),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Text("No Register Bussiness");
                }
            ):
            FutureBuilder <List<Search_Bussiness>>(
                future: search_bussiness(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Search_Bussiness>? data = snapshot.data;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics:  NeverScrollableScrollPhysics(),
                      itemCount: data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 17/ 8,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 3,
                          crossAxisCount: 1
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        print(data[index].businessName.toString()+"%%%%%%%%%%%");
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>BusinessInfo(
                                  bussiness_id: data[index].businessId.toString(),
                                )
                            )
                            );
                          },
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: Container(
                                        height: 125, width: 90,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(data[index].profileImg.toString()),
                                              fit: BoxFit.fill),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 12, right: 10),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.58,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(data[index].businessName.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: Color(0xff3E3E3E)),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  child: Image.asset(
                                                    "assets/images/locationc.png",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(data[index].city.toString(),
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
                                            Row(
                                              children: [
                                                Container(
                                                    height: 20,
                                                    width: 20,
                                                    child: Image.asset(
                                                      "assets/images/cs.png",
                                                      fit: BoxFit.fill,
                                                    )),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(data[index].categoryName.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Color(0xff878383)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    height: 20,
                                                    width: 20,
                                                    child: Image.asset(
                                                      "assets/images/aaaa.png",
                                                      fit: BoxFit.fill,
                                                    )),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "5+ Years",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Color(0xff878383)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  child: Image.asset(
                                                    "assets/images/alarm.png",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(data[index].openingTime.toString()+
                                                    "-"
                                                    +data[index].closingTime.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 10,
                                                      color: Color(0xff878383)),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context)=>BusinessInfo(
                                                          bussiness_id: data[index].businessId.toString(),
                                                        ))
                                                    );
                                                  },
                                                  child: Container(
                                                    child: Center(
                                                      child: Text(
                                                        "View Profile",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                    height: 28,
                                                    width: 76,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(30),
                                                        gradient: LinearGradient(
                                                            begin: Alignment.bottomLeft,
                                                            end: Alignment.bottomRight,
                                                            colors: [
                                                              Colors.blue.shade100,
                                                              Colors.blue.shade400
                                                            ])),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Text("No Register Bussiness");
                }
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
                Text( 'Searching Business ...',style: TextStyle(color: Colors.pink,fontSize: 17),),
              ]
          ),
        ],
      )
    );
  }
}


