import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/auth/my_blood_request_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BloodRequest extends StatefulWidget {
  const BloodRequest({Key? key}) : super(key: key);

  @override
  State<BloodRequest> createState() => _BloodRequestState();
}

class _BloodRequestState extends State<BloodRequest> {

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC96746',
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

  var blood_banner=[];
  Future my_blood_banner() async{
    Map data={
      "screen_id": 'SC39883'
    };
    Uri url=Uri.parse("https://community.creditmywallet.in.net/api/get_banner");
    var body=jsonEncode(data);
    var response=await http.post(url,headers: {"Content-Type":"application/json"}, body:body);
    var res=jsonDecode(response.body)['data'];
    setState(() {
      blood_banner=res;
    });
  }

  Future<List<StatusMessage>> mybloodrequest() async{
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      "user_id":user_id.toString()
    };
    Uri url=Uri.parse("https://community.creditmywallet.in.net/api/my_blood_req");
    var body=jsonEncode(data);
    var response=await http.post(url,headers: {"Content-Type":"application/json"}, body:body);
    if(response.statusCode==200)
      {
        List data=jsonDecode(response.body)['status_message'];
        print("%%%%%%%%%%%%%%%%"+data.toString());
        return
          data.map((data)  =>  StatusMessage.fromJson(data)).toList();
      } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      get_banner();
      my_blood_banner();
      mybloodrequest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 252, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 252, 255),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),

        title: const Text(
          "My Blood Request",
          style: TextStyle(
              color: Color(0xff000000),
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
      ),
      body:  Column(
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
          SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: 45,
                      decoration: const BoxDecoration(
                      ),
                      child: Text(
                        "My Requests",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 22,
                        child: Container(
                          height: 2,
                          width: MediaQuery.of(context).size.width * 0.20,
                          color: Colors.black,
                        )
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 21,
          ),
          FutureBuilder <List<StatusMessage>>(
              future: mybloodrequest(),
              builder: (context, snapshot) {
                if(snapshot.hasData)
                {
                  List<StatusMessage>? data = snapshot.data;
                  return Expanded(child: ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.92,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 23, top: 21, bottom: 19),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Request Id:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Color(0xff000000)),
                                            ),
                                            Text(data[index].reqId.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Color(0xff000000)),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Unit Request:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: Color(0xff000000)),
                                            ),
                                            Text("  "+data[index].unit.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Container(
                                            height: 35, width: 154,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                gradient:  LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    colors: [Colors.blue.shade100, Colors.blue])),
                                            child: MaterialButton(
                                              onPressed: () async{
                                                var dio1 = Dio();
                                                var formData = FormData.fromMap({
                                                  'user_id': data[index].userId.toString(),
                                                  "req_id": data[index].reqId.toString(),
                                                });
                                                print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                                var response = await dio1.post('https://community.creditmywallet.in.net/api/comp_blood_req'
                                                    ,data: formData);
                                                var res=response.data;
                                                var msg=res["status_message"];
                                                setState(() {
                                                  print("%%%%%%%%%PPPPPPPPP%%%%%%"+res.toString());
                                                });
                                                if(res["status_message"]=="Marked As Complete")
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
                                              child: data[index].completeStatus!='0'?
                                              Text(
                                                "Make As Complete",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12,
                                                    color: Color(0xffFFFFFF)),
                                              ):
                                              Text(
                                                "Completed",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12,
                                                    color: Color(0xffFFFFFF)),
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 50, width: 48.99,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [Colors.pink.shade50, Colors.pink.shade400]
                                              )
                                          ),
                                          child: Center(
                                            child: Text(data[index].bloodType.toString() ,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white70,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Container(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Text(
                                              " Requested\nBlood Group",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff000000),
                                                  fontSize: 14),
                                            ),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }));
                }
                else{
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text("No Blood Request"),
                      )
                    ],
                  );
                }
              }
          ),
          SizedBox(
            height: 13,
          ),
        ],
      ),
    );
  }
}
