import 'dart:convert';
import 'package:communityapp/screens/sanskriti/sanskriti_detail.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/auth/get_sanskrity_vedaval_model.dart';
import 'package:communityapp/screens/Vadval/vadval_strong.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class VadavalSanskriti extends StatefulWidget {
  const VadavalSanskriti({Key? key}) : super(key: key);

  @override
  State<VadavalSanskriti> createState() => _VadavalSanskritiState();
}

class _VadavalSanskritiState extends State<VadavalSanskriti> {
  List<String> _images = ["assets/images/slider.png"];



  Future <List<Vedabal>> vedabal_sanskrity() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id':user_id.toString(),
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_sanskriti_post");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['status_message'];
     // print(data.toString()+"%%%%%%%%%%");
      return data.map((job1) => Vedabal.fromJson(job1)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }


  List get_sanskriti_po_cat_list=[];
  Future get_vedaval_post_cat1() async {
    var url = Uri.parse("https://community.creditmywallet.in.net/api/get_sanskriti_post_cat");
    final response = await http.post(url,headers:{"Content-Type": "application/json"});
    var res = await json.decode(response.body);
    print("response12" + response.body);

    if (response.statusCode == 200) {
      setState(() {
        get_sanskriti_po_cat_list = res['status_message'];
        print("%%%%%%%%%%5555"+get_sanskriti_po_cat_list.toString());
      });
    }
  }

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC55722',
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
      get_vedaval_post_cat1();
      vedabal_sanskrity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F8FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffEEEEEE),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff000000),
              size: 20,
            )),
        title: Text(
          "Vadaval Sanskriti",
          style: TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
      ),
      body: get_sanskriti_po_cat_list.length!=0? SingleChildScrollView(
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
              padding: EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.32,
                        height: 25,
                        decoration: BoxDecoration(
                        ),
                        child: Text(
                          "Popular Topics",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w700),
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
              height: 10,
            ),

            get_sanskriti_po_cat_list.length!=0?
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: 125.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: get_sanskriti_po_cat_list.length,
                  itemBuilder: (BuildContext context,int index)
                  {
                    return InkWell(
                      onTap:(){
                      /*  Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>SanskritiDetail(
                              post_id: get_sanskriti_po_cat_list[index]['topic_id'].toString(),
                            )));*/
                      } ,
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                                width: 100,
                                child: Card(
                                  color: Color(0xfffD9D9D9),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 5,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.08,
                                        width: MediaQuery.of(context).size.width * 0.18,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: NetworkImage(get_sanskriti_po_cat_list[index]['topic_img'].toString()),
                                                fit: BoxFit.fill)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                       padding: EdgeInsets.symmetric(horizontal: 5),
                                        child: Text(get_sanskriti_po_cat_list[index]['topic_name'].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 13,
                                                color: Color(0xff3E3E3E))),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ):
            Text("No Popular Topics"),

            SizedBox(
              height: 10,
            ),

            Container(
              height: 25,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.07,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ))),
                    child: Text(
                      "All",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width/1.23,
                    height: 25.0,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: get_sanskriti_po_cat_list.length,
                        itemBuilder: (BuildContext context,int index)
                        {
                          return Container(
                            margin: EdgeInsets.only(left: 7),
                            child: InkWell(

                              onTap: () {
                               /* Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>SanskritiDetail(
                                      post_id: get_sanskriti_po_cat_list[index]['topic_id'].toString(),
                                    )));*/
                              },
                              child: Text(get_sanskriti_po_cat_list[index]['topic_name'].toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff000000)),
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 19,
            ),
            Container(
              child: Column(
                children: [
                  FutureBuilder <List<Vedabal>>(
                      future: vedabal_sanskrity(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Vedabal>? data = snapshot.data;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics:  NeverScrollableScrollPhysics(),
                            itemCount: data!.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 16/ 6.5,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 3,
                                crossAxisCount: 1
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=>SanskritiDetail(
                                        post_id: data[index].sansPostId.toString(),
                                      )
                                  )
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  height: 135,
                                  width: MediaQuery.of(context).size.width * 0.95,
                                  child: Card(
                                    elevation: 2,
                                    color: Color(0xffFCFCFC),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(data[index].img.toString()),
                                                  fit: BoxFit.fill
                                              )
                                          ),
                                          height: 100,
                                          width: MediaQuery.of(context).size.width * 0.20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10, left: 18),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.55,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 21,
                                                  width: 110,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(30),
                                                      gradient: const LinearGradient(
                                                          begin: Alignment.bottomRight,
                                                          end: Alignment.bottomLeft,
                                                          colors: [Colors.amber, Colors.white])),
                                                  child: Center(
                                                    child: Text(data[index].topicCatName.toString(),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          color: Color(0xff000000),
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 9,
                                                ),
                                                Container(
                                                  //height: 53,
                                                  child: Text(data[index].discussionTopic.toString(),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 13,
                                                        color: Color(0xff000000)),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Container(
                                                  child: Text(data[index].createdAt.toString().replaceRange(10, 19, ""),
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 10,
                                                        color: Color(0xff333333)),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.07,
                                                child: Image.asset("assets/images/arroww.png"),
                                              ),
                                              Spacer(),
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.07,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return Text("No Vedabal SansKriti");
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 39,
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
                Text( 'Vadval Sanskriti...',style: TextStyle(color: Colors.pink,fontSize: 17),),
              ]
          ),
        ],
      )
    );
  }
}
