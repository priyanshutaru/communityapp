import 'dart:convert';
import 'package:communityapp/screens/Business/business_profile.dart';
import 'package:communityapp/screens/auth/my_bussiness_model.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Business/business_list.dart';
import 'package:communityapp/screens/Business/business_registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyBusiness extends StatefulWidget {
  const MyBusiness({Key? key}) : super(key: key);

  @override
  State<MyBusiness> createState() => _MyBusinessState();
}

class _MyBusinessState extends State<MyBusiness> {


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

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC77918',
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
      my_Bussiness();
      get_banner();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F8FB),
      appBar: AppBar(
          backgroundColor: Color(0xffF4F8FB),
          elevation: 0,
          leading:IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:  Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xff000000),
                  size: 20,
                )),
          title: Text(
            "My Business",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xff000000),
                fontSize: 16),
          )),
      body: SingleChildScrollView(
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
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.32,
                                height: 45,
                                decoration: BoxDecoration(
                                ),
                                child: Text(
                                  "My Business",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
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
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>BusinessRegistration(
                              bussiness_id: '',
                              name: 'Add',
                            )));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Container(
                          child: Stack(
                            children: [
                              Container(
                                child: Center(
                                    child: Text(
                                      "Create Business",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                          color: Colors.white),
                                    )),
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Colors.blue, Colors.blue])),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 110,
                                ),
                                child: CircleAvatar(
                                  backgroundImage:
                                  AssetImage("assets/images/upload.png"),
                                  radius: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 11,
              ),

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
                                childAspectRatio: 20/ 8,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 3,
                                crossAxisCount: 1
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=>BusinessProfile(
                                        bussines_id: data[index].businessId.toString(),
                                      )));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  width: MediaQuery.of(context).size.width * 0.95,
                                  height: MediaQuery.of(context).size.height*0.2,
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    color: Color(0xffFFFFFF),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Container(
                                            height: 100,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(data[index].profileImg.toString()),
                                                  fit: BoxFit.fill),
                                              borderRadius: BorderRadius.circular(20),
                                              //color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20, top: 20),
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
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Colors.pink.shade300,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 6,
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
                                                  height: 6,
                                                ),
                                                Divider(),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    data[index].userStatus.toString()=="0"?
                                                    InkWell(
                                                      onTap: ()async{
                                                        var dio1 = Dio();
                                                        var formData = FormData.fromMap(
                                                            {
                                                              'business_id': data[index].businessId.toString(),
                                                            });
                                                        print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                        var response = await dio1.post('https://community.creditmywallet.in.net/api/business_active_de',data: formData);
                                                        var res=response.data;
                                                        var msg=res["status_code"];
                                                        setState(() {
                                                          print("%%%%%%%%%%%%%%%"+res.toString());
                                                        });
                                                        if(res["status_code"]=="Status Updated Successfully")
                                                        {
                                                          Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                              gravity: ToastGravity.BOTTOM);
                                                        }
                                                        else
                                                        {
                                                          Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                              gravity: ToastGravity.BOTTOM);
                                                        }
                                                      },
                                                      child:  Container(
                                                        child: Center(
                                                            child: Text(
                                                              "De-Activate",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: Color(0xff707070),
                                                                  fontWeight: FontWeight.w700),
                                                            )),
                                                        height: 24.64,
                                                        width: MediaQuery.of(context).size.width * 0.25,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(30),
                                                            gradient: LinearGradient(
                                                                begin: Alignment.bottomLeft,
                                                                end: Alignment.bottomRight,
                                                                colors: [
                                                                  Colors.white,
                                                                  Colors.pink.shade300
                                                                ])),
                                                      ),
                                                    ):
                                                    InkWell(
                                                      onTap: ()async{
                                                        var dio1 = Dio();
                                                        var formData = FormData.fromMap(
                                                            {
                                                              'business_id': data[index].businessId.toString(),
                                                            });
                                                        print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                        var response = await dio1.post('https://community.creditmywallet.in.net/api/business_active_de',data: formData);
                                                        var res=response.data;
                                                        var msg=res["status_code"];
                                                        setState(() {
                                                          print("%%%%%%%%%%%%%%%"+res.toString());
                                                        });
                                                        if(res["status_code"]=="Status Updated Successfully")
                                                        {
                                                          Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                              gravity: ToastGravity.BOTTOM);
                                                        }
                                                        else
                                                        {
                                                          Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                              gravity: ToastGravity.BOTTOM);
                                                        }
                                                      },
                                                      child:  Container(
                                                        child: Center(
                                                            child: Text(
                                                              "Activate",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: Color(0xff707070),
                                                                  fontWeight: FontWeight.w700),
                                                            )),
                                                        height: 24.64,
                                                        width: MediaQuery.of(context).size.width * 0.25,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(30),
                                                            gradient: LinearGradient(
                                                                begin: Alignment.bottomLeft,
                                                                end: Alignment.bottomRight,
                                                                colors: [
                                                                  Colors.white,
                                                                  Colors.pink.shade300
                                                                ])),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(context, MaterialPageRoute(
                                                            builder: (context)=>BusinessRegistration(
                                                              bussiness_id: data[index].businessId.toString(),
                                                              name: 'Edit',
                                                            ))
                                                        );
                                                      },
                                                      child: Container(
                                                        child: Center(
                                                            child: Text(
                                                              "Manage",
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 10,
                                                                  fontWeight: FontWeight.w700),
                                                            )),
                                                        height: 24.86,
                                                        width: MediaQuery.of(context).size.width * 0.25,
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
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 19,
                                                ),
                                              ],
                                            ),
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
                    return Text("No Register Bussiness");
                  }),
            ],
          ),
      ),
    );
  }
}
