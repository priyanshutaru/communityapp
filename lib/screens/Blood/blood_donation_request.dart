import 'dart:convert';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/auth/open_blood_donation_request_model.dart';
import 'package:flutter/material.dart';

class BloodDonationRequest extends StatefulWidget {
/*  const BloodDonationRequest({Key? key}) : super(key: key);*/
String total;
BloodDonationRequest({required this.total});

  @override
  State<BloodDonationRequest> createState() => _BloodDonationRequestState();
}

class _BloodDonationRequestState extends State<BloodDonationRequest> {
  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC70965',
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

  String dropdownvalue = 'Blood Group';
  var items = [
    'Blood Group',
    'A +',
    'A -',
    'B +',
    'B -',
    'O +',
    'O -',
    'AB +',
    'AB -'
  ];
  String dropdownvalue1 = 'Location';
  var items1 = [
    'Location',
    'Lucknow',
    'Barabanki',
    'Kanpur',
    'Pryagraj',
  ];
  Future<List<Status>> opent_blood_donation() async{
    Uri url=Uri.parse("https://community.creditmywallet.in.net/api/all_blood_req");
    var response=await http.post(url,headers: {"Content-Type":"application/json"});
    if(response.statusCode==200)
    {
      List data=jsonDecode(response.body)['status_message'];
      return
        data.map((data)  =>  Status.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  String? add="";

  Future<List<Status>> sarchblood_request() async{
    Map data={
      'city':district,
      'blood_type':dropdownvalue,
    };
    Uri url=Uri.parse("https://community.creditmywallet.in.net/api/search_blood_req");
    var body=jsonEncode(data);
    var response=await http.post(url,headers: {"Content-Type":"application/json"},body: body);
    if(response.statusCode==200)
    {
      List data=jsonDecode(response.body)['status_message'];
      print("%%%%%%%%%%%%%%%%$data");
      return
        data.map((data)  =>  Status.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }



  String? location;
  String? district;

  List get_city_list=[];
  Future  get_city() async{
    var url="https://community.creditmywallet.in.net/api/get_state";
    http.Response response=await http.post(Uri.parse(url));
    var res=jsonDecode(response.body)['state'];
    setState(() {
      get_city_list=res;
    });
  }

  List get_district_list=[];
  Future  get_District() async{
    Map data={
      "state_id":location.toString(),
    };
    var url="https://community.creditmywallet.in.net/api/get_dist";
    var body1=jsonEncode(data);
    http.Response response=await http.post(Uri.parse(url),headers: {"Content-Type":"application/json"}, body: body1);
    var res=jsonDecode(response.body)['state'];
    setState(() {
      get_district_list=res;
    });

  }

  @override
  void initState() {
    super.initState();
    setState(() {
      get_city();
      get_banner();
      opent_blood_donation();
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
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        title: const Text(
          "Open Blood Donation Request",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16),
        ),
      ),
      body: Column(
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
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 14, right: 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: dropdownvalue,
                          icon: Padding(
                            padding: EdgeInsets.only(left: 170),
                            child: Icon(
                              Icons.arrow_drop_down,
                            ),
                          ),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
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
              height: 14,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3, bottom: 3),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: location,
                    hint: Text("      State"),
                    icon: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    items: get_city_list.map((item) {
                      return DropdownMenuItem(
                          value: item['state_id'].toString(),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              item['state_title'].toString(),
                              style: TextStyle(color: Colors.black54),
                            ),
                          )
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        location = newValue! as String?;
                        get_District();
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3, bottom: 3),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: district,
                    hint: Text("      District"),
                    icon: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    items: get_district_list.map((item) {
                      return DropdownMenuItem(
                        value: item['district_title'].toString(),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
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
                          var num="Add";
                          add=num;
                          sarchblood_request();
                        });
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Total "+"${widget.total}"+" blood request available",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xff000000)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 23,
            ),
            district==null?
            FutureBuilder <List<Status>>(
                future: opent_blood_donation(),
                builder: (context, snapshot) {
                  if(snapshot.hasData)
                  {
                    List<Status>? data = snapshot.data;
                    return Expanded(
                        child: ListView.builder(
                            itemCount: data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 183, width: 338,
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  color: Color(0xffFFFFFF),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 65, width: 55,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  image: DecorationImage(
                                                      image: NetworkImage(data[index].profileImg.toString()), fit: BoxFit.cover)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 13),
                                              child: Container(
                                                height: 90,
                                                width:MediaQuery.of(context).size.width*0.7,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width:MediaQuery.of(context).size.width*0.38,
                                                            child: Text(data[index].firstName.toString()+" "+data[index].lastName.toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w700,
                                                                  color: Color(0xff3E3E3E)),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          InkWell(
                                                            onTap: () async{
                                                              final number=data[index].mobile.toString();
                                                              await FlutterPhoneDirectCaller.callNumber(number);
                                                            },
                                                            child: Padding(
                                                              padding: EdgeInsets.only(right: 10),
                                                              child: Container(
                                                                height: 25, width: 96,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(25),
                                                                    gradient: LinearGradient(
                                                                        begin: Alignment.topRight,
                                                                        end: Alignment.bottomLeft,
                                                                        colors: [Colors.blue, Colors.blue.shade100])),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Contact",
                                                                    style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 12,
                                                                        fontWeight: FontWeight.w700),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.location_on,
                                                            color: Color(0xffFA6393),
                                                            size: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          Text(data[index].city.toString(),
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w400,
                                                                color: Color(0xff878383),
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 6,
                                                      ),
                                                      Container(
                                                        width:MediaQuery.of(context).size.width*0.55,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text("Posted by: "+data[index].createdAt.toString().replaceRange(11, 19, "").toString(),
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 12,
                                                                  color: Color(0xff000000)),
                                                            ),
                                                            Text("",
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 12,
                                                                  color: Color(0xff000000)),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Requested Blood Group",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xff000000),
                                                      fontWeight: FontWeight.w400),
                                                ),
                                                const SizedBox(
                                                  height: 9,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Unit Requested :  ",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color(0xff000000),
                                                      ),
                                                    ),
                                                    Text(data[index].unit.toString(),
                                                      style:  TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Container(
                                              height: 50, width: 48.99,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  gradient: LinearGradient(
                                                      begin: Alignment.topRight,
                                                      end: Alignment.bottomLeft,
                                                      colors: [Colors.pink.shade50, Colors.pink.shade400],
                                                  )
                                              ),
                                              child: Center(
                                                child: Text(data[index].bloodType.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })
                    );
                  }
                  else{
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Center(
                    child: Text("No Blood Donation Request"),
                  )
                      ],
                    );
                  }
                }
            ):
            FutureBuilder <List<Status>>(
                    future: sarchblood_request(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData)
                      {
                        List<Status>? data = snapshot.data;
                        return Expanded(
                            child: ListView.builder(
                                itemCount: data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: 183, width: 338,
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                      color: Color(0xffFFFFFF),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                Container(
                                                  // height: 90,
                                                  // width: Get.width * 0.2,
                                                  height: 65, width: 55,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      image: DecorationImage(
                                                          image: NetworkImage(data[index].profileImg.toString()), fit: BoxFit.cover)),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 13),
                                                  child: Container(
                                                    height: 90,
                                                    width:MediaQuery.of(context).size.width*0.7,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 10),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width:MediaQuery.of(context).size.width*0.38,
                                                                child: Text(data[index].firstName.toString()+" "+data[index].lastName.toString(),
                                                                  style: TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w700,
                                                                      color: Color(0xff3E3E3E)),
                                                                ),
                                                              ),
                                                              Spacer(),
                                                              InkWell(
                                                                onTap: () async{
                                                                  final number=data[index].mobile.toString();
                                                                  await FlutterPhoneDirectCaller.callNumber(number);
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(right: 10),
                                                                  child: Container(
                                                                    height: 25, width: 96,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(25),
                                                                        gradient: LinearGradient(
                                                                            begin: Alignment.topRight,
                                                                            end: Alignment.bottomLeft,
                                                                            colors: [Colors.blue, Colors.white])),
                                                                    child: Center(
                                                                      child: Text(
                                                                        "Contact",
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 10,
                                                                            fontWeight: FontWeight.w700),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.location_on,
                                                                color: Color(0xffFA6393),
                                                                size: 20,
                                                              ),
                                                              SizedBox(
                                                                width: 2,
                                                              ),
                                                              Text(data[index].city.toString(),
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w400,
                                                                    color: Color(0xff878383),
                                                                    fontSize: 12),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 6,
                                                          ),
                                                          Container(
                                                            width:MediaQuery.of(context).size.width*0.55,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text("Posted by: "+data[index].createdAt.toString().replaceRange(11, 19, "").toString(),
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: 12,
                                                                      color: Color(0xff000000)),
                                                                ),
                                                                Text("",
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: 12,
                                                                      color: Color(0xff000000)),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Requested Blood Group",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Color(0xff000000),
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                    const SizedBox(
                                                      height: 9,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Unit Requested :  ",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w400,
                                                            color: Color(0xff000000),
                                                          ),
                                                        ),
                                                        Text(data[index].unit.toString(),
                                                          style:  TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Container(
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
                                                    child: Text(data[index].bloodType.toString(),
                                                      style: TextStyle(
                                                          color: Colors.white70,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })
                        );
                      }
                      else{
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text("No Blood Donation Request"),
                            )
                          ],
                        );
                      }
                    }
                ),

          ],
        ),
    );
  }
}


