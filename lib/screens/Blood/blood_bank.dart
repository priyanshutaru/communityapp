import 'dart:convert';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../auth/blood_bank_model.dart';

class BloodBank extends StatefulWidget {
  const BloodBank({Key? key}) : super(key: key);

  @override
  State<BloodBank> createState() => _BloodBankState();
}

class _BloodBankState extends State<BloodBank> {
  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC35384',
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


  String dropdownvalue1 = 'Location';

  var items1 = [
    'Location',
    'Lucknow',
    'Delhi',
    'Kanpur',
    'Pryagraj',
  ];

  Future<List<StatusMessage>> getBloodbank() async{
    Uri url=Uri.parse("https://community.creditmywallet.in.net/api/blood_bank");
    var response=await http.post(url,headers: {"Content-Type":"application/json"});
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

  Future<List<StatusMessage>> search_getBloodbank() async{
    Map data={
      'city':district,
      'name':search.text.toString(),
    };
    Uri url=Uri.parse("https://community.creditmywallet.in.net/api/blood_bank");
    var body=jsonEncode(data);
    var response=await http.post(url,headers: {"Content-Type":"application/json"},body: body);
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

  TextEditingController search=TextEditingController();


  @override
  void initState() {
    super.initState();
    setState(() {
      get_banner();
      getBloodbank();
      get_city();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 237, 243, 247),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 237, 243, 247),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Blood Banks",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xff000000),
              fontSize: 16),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),

            Container(
              padding: EdgeInsets.only(top: 3, bottom: 3),
              height: 40,
              width: MediaQuery.of(context).size.width * .93,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                controller: search,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14.0),
                  border: InputBorder.none,
                  hintText: "Search Blood Bank",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xff878383),
                      fontSize: 14),
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
                width: MediaQuery.of(context).size.width * .93,
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
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3, bottom: 3),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * .93,
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
                          search_getBloodbank();
                        });
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),


           district==null?
           FutureBuilder <List<StatusMessage>>(
                future: getBloodbank(),
                builder: (context, snapshot) {
                  if(snapshot.hasData)
                  {
                    List<StatusMessage>? data = snapshot.data;
                    return Expanded(
                        child: ListView.builder(
                            itemCount: data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 95,
                                width: 348,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  color: Color(0xffFFFFFF),
                                  elevation: 1,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(data[index].img.toString()),
                                                      fit: BoxFit.fill
                                                  )
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left: 5),
                                                  child: Text(data[index].name.toString(),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 14,
                                                        color: Color(0xff3E3E3E)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Colors.red,
                                                      size: 15,
                                                    ),
                                                    Text(data[index].city.toString(),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 12,
                                                          color: Color(0xff878383)),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 6),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Image.asset(
                                                        "assets/images/call.png",
                                                        fit: BoxFit.fill,
                                                        height: 13,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                          width:MediaQuery.of(context).size.width*0.25,
                                                          child: Text(
                                                            "+91-"+data[index].phone.toString(),
                                                            style: const TextStyle(
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 11.8,
                                                                color: Color(0xff878383)),
                                                          )),
                                                      InkWell(
                                                        onTap: () async{
                                                          final number=data[index].phone.toString();
                                                          await FlutterPhoneDirectCaller.callNumber(number);
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 50),
                                                          child: Container(
                                                            width: 90.08,
                                                            height: 29.32,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(20),
                                                                gradient: const LinearGradient(
                                                                    begin: Alignment.topLeft,
                                                                    end: Alignment.bottomRight,
                                                                    colors: [Colors.white, Colors.blue])),
                                                            child: Center(
                                                              child: Text(
                                                                "Contact",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: 10,
                                                                    color: Colors.white70),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                    );
                  }
                  else{
                    return
                      Center(
                        child: Text("No Blood Request"),
                      );
                  }
                }
            ):
           FutureBuilder <List<StatusMessage>>(
               future: search_getBloodbank(),
               builder: (context, snapshot) {
                 if(snapshot.hasData)
                 {
                   List<StatusMessage>? data = snapshot.data;
                   return Expanded(
                       child: ListView.builder(
                           itemCount: data!.length,
                           itemBuilder: (BuildContext context, int index) {
                             return Container(
                               height: 95,
                               width: 348,
                               child: Card(
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(15)),
                                 color: Color(0xffFFFFFF),
                                 elevation: 1,
                                 child: Column(
                                   children: [
                                     SizedBox(
                                       height: 9,
                                     ),
                                     Padding(
                                       padding: EdgeInsets.only(left: 10),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                         children: [
                                           Container(
                                             height: 45,
                                             width: 45,
                                             decoration: BoxDecoration(
                                                 shape: BoxShape.circle,
                                                 image: DecorationImage(
                                                     image: NetworkImage(data[index].img.toString()),
                                                     fit: BoxFit.fill
                                                 )
                                             ),
                                           ),
                                           Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Padding(
                                                 padding: EdgeInsets.only(left: 5),
                                                 child: Text(data[index].name.toString(),
                                                   style: TextStyle(
                                                       fontWeight: FontWeight.w700,
                                                       fontSize: 14,
                                                       color: Color(0xff3E3E3E)),
                                                 ),
                                               ),
                                               SizedBox(
                                                 height: 3,
                                               ),
                                               Row(
                                                 mainAxisAlignment: MainAxisAlignment.start,
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Icon(
                                                     Icons.location_on,
                                                     color: Colors.red,
                                                     size: 15,
                                                   ),
                                                   Text(data[index].city.toString(),
                                                     style: TextStyle(
                                                         fontWeight: FontWeight.w400,
                                                         fontSize: 12,
                                                         color: Color(0xff878383)),
                                                   ),
                                                 ],
                                               ),
                                               Padding(
                                                 padding: EdgeInsets.only(left: 6),
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                   children: [
                                                     Image.asset(
                                                       "assets/images/call.png",
                                                       fit: BoxFit.fill,
                                                       height: 13,
                                                     ),
                                                     SizedBox(
                                                       width: 5,
                                                     ),
                                                     Container(
                                                         width:MediaQuery.of(context).size.width*0.25,
                                                         child: Text(
                                                           "+91-"+data[index].phone.toString(),
                                                           style: const TextStyle(
                                                               fontWeight: FontWeight.w400,
                                                               fontSize: 11.8,
                                                               color: Color(0xff878383)),
                                                         )),

                                                     Padding(
                                                       padding: EdgeInsets.only(left: 50),
                                                       child: Container(
                                                         width: 90.08,
                                                         height: 29.32,
                                                         decoration: BoxDecoration(
                                                             borderRadius: BorderRadius.circular(20),
                                                             gradient: const LinearGradient(
                                                                 begin: Alignment.topLeft,
                                                                 end: Alignment.bottomRight,
                                                                 colors: [Colors.white, Colors.blue])),
                                                         child: Center(
                                                           child: Text(
                                                             "Contact",
                                                             style: TextStyle(
                                                                 fontWeight: FontWeight.w700,
                                                                 fontSize: 10,
                                                                 color: Colors.white70),
                                                           ),
                                                         ),
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               )
                                             ],
                                           ),
                                         ],
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             );
                           })
                   );
                 }
                 else{
                   return
                     Center(
                       child: Text("No Blood Request"),
                     );
                 }
               }
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
      )
    );
  }
}


