import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Job/job_detail.dart';
import 'package:communityapp/screens/Job/job_search.dart';
import 'package:communityapp/screens/auth/get_job_post_model.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForumJobList extends StatefulWidget {
  const ForumJobList({Key? key}) : super(key: key);

  @override
  State<ForumJobList> createState() => _ForumJobListState();
}

class _ForumJobListState extends State<ForumJobList> {

  Future <List<Job_Post>> job_post() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id':user_id.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/my_jobs");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type":
    "application/json"},body:body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      print(data);
      return data.map((job) => Job_Post.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC69593',
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
    job_post();
    get_banner();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      appBar: AppBar(
        toolbarHeight: 2,
        backgroundColor: Color(0xffEEEEEE),
        elevation: 0,
      ),
      body: SafeArea(
        child:Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.09,
                decoration: BoxDecoration(
                    color: Colors.brown[50],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      InkWell(
                        child: Container(
                          child: Icon(Icons.arrow_back_ios_new_outlined),
                        ),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        child: const Text(
                          "My Job Post",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xff000000)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
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
              SizedBox(
                height: 10,
              ),
             /* Padding(
                padding: EdgeInsets.only(left: 22),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: 45,
                            decoration: const BoxDecoration(
                            ),
                            child: Text(
                              "My Job Post",
                              style:
                              TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>JobDetaile()));
                            },
                            child: Container(
                              child: Stack(
                                children: [
                                  Container(
                                    child: Center(
                                        child: Text(
                                          "Create Jobs    ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                    height: 40,
                                    width: MediaQuery.of(context).size.width * 0.35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: const LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.bottomRight,
                                            colors: [Colors.blue, Colors.blue])),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      left: 100,
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
                        ]
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
              ),*/
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    "My Job Post",
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
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>JobDetaile()));
                        },
                        child: Container(
                          child: Stack(
                            children: [
                              Container(
                                child: Center(
                                    child: Text(
                                  "Create Jobs    ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: const LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Colors.blue, Colors.blue])),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 100,
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
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              FutureBuilder <List<Job_Post>>(
                  future: job_post(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Job_Post>? data = snapshot.data;
                      return Expanded(
                          child: ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (BuildContext, int index) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.13,
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: InkWell(
                                  onTap: () {
                                    // Get.to(JobSearch());
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.1,
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        decoration: BoxDecoration(
                                           // borderRadius: BorderRadius.circular(15),
                                          image: DecorationImage(
                                            image: NetworkImage(data[index].img.toString(),),
                                            fit: BoxFit.fill
                                          ),
                                          shape: BoxShape.circle
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(data[index].subcategoryName.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Color(0xff3E3E3E)),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(data[index].districtTitle.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13,
                                                  color: Color(0xff878383)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10, bottom: 10),
                                        child: Column(
                                          children: [
                                            Icon(Icons.arrow_forward_ios),
                                            Spacer(),
                                            data[index].userStatus.toString()=="0"?
                                                InkWell(
                                                  onTap: () async{
                                                    var dio1 = Dio();
                                                    var formData = FormData.fromMap(
                                                        {
                                                          'job_id': data[index].jobId.toString(),
                                                        });
                                                    print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                    var response = await dio1.post('https://community.creditmywallet.in.net/api/my_jobs_deac',data: formData);
                                                    var res=response.data;
                                                    var msg=res["meassage"];
                                                    setState(() {
                                                      print("%%%%%%%%%%%%%%%"+res.toString());
                                                    });
                                                    if(res["meassage"]=="Job Updated Successfully")
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
                                                  child: Text(
                                                    "De-Activate",
                                                    style: TextStyle(
                                                        color: Color(0xffEF0F0F),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ):
                                            InkWell(
                                              onTap: () async{
                                                var dio1 = Dio();
                                                var formData = FormData.fromMap(
                                                    {
                                                      'job_id': data[index].jobId.toString(),
                                                    });
                                                print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                var response = await dio1.post('https://community.creditmywallet.in.net/api/my_jobs_deac',data: formData);
                                                var res=response.data;
                                                var msg=res["meassage"];
                                                setState(() {
                                                  print("%%%%%%%%%%%%%%%"+res.toString());
                                                });
                                                if(res["meassage"]=="Job Updated Successfully")
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
                                              child: Text(
                                                "Activate",
                                                style: TextStyle(
                                                    color: Color(0xffEF0F0F),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        },
                      )
                      );
                    }
                    return Text("No Posted Job");
                  }),

            ],
          ),
        ),
    );
  }
}
