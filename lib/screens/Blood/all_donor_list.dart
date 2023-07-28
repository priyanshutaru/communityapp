import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/auth/all_donor_list_model.dart';
import 'package:communityapp/screens/membersearch/member_search_profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AllDonorList extends StatefulWidget {
  const AllDonorList({Key? key}) : super(key: key);

  @override
  State<AllDonorList> createState() => _AllDonorListState();
}

class _AllDonorListState extends State<AllDonorList> {
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

  int? tot;

  Future all_donor_count() async{
    Uri url=Uri.parse("https://community.creditmywallet.in.net/api/all_doners");
    var response=await http.post(url,headers: {"Content-Type":"application/json"});
    var res5=jsonDecode(response.body);
    setState(() {
      tot=res5['count'];
      if(tot!=null)
        {
          tot=tot;
        }
      else
        {
          tot=0;
        }
      print(tot.toString()+"gygigyu"+res5.toString()+"bhbhfbvbvh");
    });
  }

  Future<List<StatusMessage>> all_donor() async{
    Uri url=Uri.parse("https://community.creditmywallet.in.net/api/all_doners");
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

  String? add1;
  Future<List<StatusMessage>> search_all_donor() async{
    Map data={
      'city':district,
      'blood_type':dropdownvalue,
    };
    Uri url=Uri.parse("https://community.creditmywallet.in.net/api/filter_doners");
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

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC48975',
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
    all_donor_count();
    setState(() {
      get_banner();
      get_city();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xffF8F5F5),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        title: Text(
          "All Donor List",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xff000000),
              fontSize: 15),
        ),
      ),
      body:Column(
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
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 14, right: 11),
              child:  Container(
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
                            padding: EdgeInsets.only(left: 165),
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
                        value: item['districtid'].toString(),
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
                          add1=num;
                          search_all_donor();
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
            Padding(
              padding: EdgeInsets.only(left: 19),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Total Donors: "+tot.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xff000000),
                      fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            district==null?
            FutureBuilder <List<StatusMessage>>(
                future: all_donor(),
                builder: (context, snapshot) {
                  if(snapshot.hasData)
                  {
                    List<StatusMessage>? data = snapshot.data;
                    return Expanded(child: ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 11, right: 10),
                            child: Container(
                              height: 130,
                              width: 348,
                              child: Card(
                                color: Color(0xffFFFFFF),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              image: const DecorationImage(
                                                  image:
                                                  AssetImage("assets/images/radha.png"),
                                                  fit: BoxFit.fill)),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(data[index].firstName.toString()+" ",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 14,
                                                      color: Color(0xff3E3E3E)),
                                                ),
                                                Text(data[index].lastName.toString()!="null"?data[index].lastName.toString():"",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 14,
                                                      color: Color(0xff3E3E3E)),
                                                ),
                                              ],
                                            ),

                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Proffesion: ",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Color(0xff000000)),
                                                ),
                                                Text(
                                                  "Students: ",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Color(0xff000000)),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.only(right: 10),
                                                    child: Icon(
                                                      Icons.location_on,
                                                      color: Colors.red,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                Text(data[index].districtTitle.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Color(0xff878383)),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              height: 50, width: 48.99,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  gradient: LinearGradient(
                                                      begin: Alignment.topRight,
                                                      end: Alignment.bottomLeft,
                                                      colors: [Colors.pink.shade50, Colors.pink.shade400]
                                                  ),
                                               // color: Colors.pink.shade400
                                              ),
                                              child: Center(
                                                child: Text(data[index].userF1BloodGroup.toString(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w700,
                                                      color: Color(0xffFFFFFFD9)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height:MediaQuery.of(context).size.height*0.06,
                                          width:MediaQuery.of(context).size.width*0.65,
                                        ),
                                        InkWell(
                                          child: Container(
                                            height: 28, width: 90.08,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    colors: [
                                                      Colors.blue.shade300,
                                                      Colors.blue.shade400
                                                    ])),
                                            child: Center(
                                              child: Text(
                                                "View Profile",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context)=>MemberSearchProfile(
                                                    user_id: data[index].userId.toString())));
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }));
                  }
                  else{
                    return Center(
                          child: Text("No Blood Request"),
                        );
                  }
                }
            ):
             FutureBuilder <List<StatusMessage>>(
                    future: search_all_donor(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData)
                      {
                        List<StatusMessage>? data = snapshot.data;
                        return Expanded(child: ListView.builder(
                            itemCount: data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(left: 11, right: 10),
                                child: Container(
                                  height: 130,
                                  width: 348,
                                  child: Card(
                                    color: Color(0xffFFFFFF),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              height: 55,
                                              width: 55,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  image: const DecorationImage(
                                                      image:
                                                      AssetImage("assets/images/radha.png"),
                                                      fit: BoxFit.fill)),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(data[index].firstName.toString()+" ",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 14,
                                                          color: Color(0xff3E3E3E)),
                                                    ),
                                                    Text(data[index].lastName.toString()!="null"?data[index].lastName.toString():"",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 14,
                                                          color: Color(0xff3E3E3E)),
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Proffesion: ",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 14,
                                                          color: Color(0xff000000)),
                                                    ),
                                                    Text(
                                                      "Students: ",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 14,
                                                          color: Color(0xff000000)),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(right: 10),
                                                        child: Icon(
                                                          Icons.location_on,
                                                          color: Colors.red,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(data[index].districtTitle.toString(),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 12,
                                                          color: Color(0xff878383)),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
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
                                                    child: Text(data[index].userF1BloodGroup.toString(),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w700,
                                                          color: Color(0xffFFFFFFD9)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height:MediaQuery.of(context).size.height*0.06,
                                              width:MediaQuery.of(context).size.width*0.65,
                                            ),
                                            InkWell(
                                              child: Container(
                                                height: 28, width: 90.08,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    gradient: LinearGradient(
                                                        begin: Alignment.topRight,
                                                        end: Alignment.bottomLeft,
                                                        colors: [
                                                          Colors.blue.shade300,
                                                          Colors.blue.shade400
                                                        ])),
                                                child: Center(
                                                  child: Text(
                                                    "View Profile",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(
                                                    builder: (context)=>MemberSearchProfile(
                                                        user_id: data[index].userId.toString())));
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }));
                      }
                      else{
                        return Center(
                          child: Text("No Blood Request"),
                        );
                      }
                    }
                )

          ],
        ),
    );
  }
  Widget donorCard(img, String name, String proffesion, String address) {
    return Container(
      child: Container(
        height:MediaQuery.of(context).size.height*0.25,
        width:MediaQuery.of(context).size.width*0.95,
        child: Card(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(height: 80, width: 80, child: Image.asset(img)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Proffesion: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black45),
                          ),
                          Text(
                            proffesion,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          Text(address),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height:MediaQuery.of(context).size.height*0.1,
                        width:MediaQuery.of(context).size.width*0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.red, Colors.white])),
                        child: const Center(
                          child: Text(
                            "B+",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    height:MediaQuery.of(context).size.height*0.06,
                    width:MediaQuery.of(context).size.width*0.5,

                  ),
                  Container(
                    height:MediaQuery.of(context).size.height*0.06,
                    width:MediaQuery.of(context).size.width*0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Colors.blue, Colors.white])),
                    child: const Center(
                      child: Text(
                        "B+",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


