import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Job/dreamjob_details.dart';
import 'package:communityapp/screens/Job/job_profile.dart';
import 'package:communityapp/screens/myProfile.dart';
import 'package:dio/dio.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/Job/job_search_result.dart';
import 'package:communityapp/screens/auth/get_job_model.dart';
import 'package:flutter/material.dart';

class JobSearchDream extends StatefulWidget {
  const JobSearchDream({Key? key}) : super(key: key);

  @override
  State<JobSearchDream> createState() => _JobSearchDreamState();
}

class _JobSearchDreamState extends State<JobSearchDream> {


  String? Category;
  String? sub_Category;
  String? location;
  String? district;


  List reco_job=[];
  Future  recommended_job() async{
    var url="https://community.creditmywallet.in.net/api/get_recomm_jobs";
    http.Response response=await http.get(Uri.parse(url),headers: {"Content-Type":"application/json"});
    var res=jsonDecode(response.body)['details'];
    setState(() {
      reco_job=res;
      print("mjhgf"+reco_job.toString()+"%%%%%%%%%%%%%%%%");
    });

  }
  

  Future <List<Details>> get_job_details() async {
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_jobs");
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['details'];
      print(data);
      return data.map((job) => Details.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
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

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC24795',
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
      get_city();
      bussi_Category();
      get_banner();
      recommended_job();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffEEEEEE),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "Find Your Dream Job",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: reco_job.length!=0? SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xffEEEEEE),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 3, bottom: 3),
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width*0.45,
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
                              width: MediaQuery.of(context).size.width*0.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: sub_Category,
                                  hint: Text("      Sub-Category"),
                                  icon: Icon(Icons.arrow_drop_down),
                                  items: bussiness_Sub_Category.map((item) {
                                    return DropdownMenuItem(
                                      value: item['subcategory_id'].toString(),
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: 7),
                                        child: Text(
                                          item['subcategory_name'].toString(),
                                          style: TextStyle(color: Colors.black54,fontSize: 15
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
                              value: location,
                              hint: Text("      State"),
                              icon: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(Icons.arrow_drop_down),
                              ),
                              items: get_city_list.map((item) {
                                return DropdownMenuItem(
                                  value: item['state_id'].toString(),
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: 30),
                                    child: Text(
                                      item['state_title'].toString(),
                                      style: TextStyle(color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  setState((){
                                    location = newValue! as String?;
                                    get_District();
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
                                  });
                                });
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: ()  async{
                          var dio1 = Dio();
                          var formData = FormData.fromMap(
                              {
                                'job_position': sub_Category,
                                'city_id':district
                              });
                          print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                          var response = await dio1.post('https://community.creditmywallet.in.net/api/search_jobs',data: formData);
                          var res=response.data;
                          var msg=res["status_message"];
                          setState(() {
                            print("%%%%%%%%%%%%%%%"+res.toString());
                          });
                          if(res["status_message"]=="Job Available")
                          {
                            Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM);
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>JobSearchResult(sub_Category: sub_Category, district: district,)));
                          }
                          else
                          {
                            Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM);
                          }

                        },
                        child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.38,
                            child: Center(
                              child: Text(
                                "Search",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black54),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient:  LinearGradient(
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft,
                                    colors: [Colors.blue, Colors.blue.shade100]))),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>JobProfile()));
                      }, child: Text(
                        "Can't find your Dream Job? Post Your Profile here",
                        style: TextStyle(color: Colors.blue, fontSize: 13),
                      ),),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Stack(
                      children: [
                        Container(
                          height:25,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                          ),
                          child: Text(
                            "Recommended Jobs",
                            style: TextStyle(
                                fontSize: 17,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Positioned(
                            top: 22,
                            child: Container(
                              height: 2,
                              width: MediaQuery.of(context).size.width * 0.3,
                              color: Colors.black,
                            )
                        )
                      ]
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            reco_job.length!=0? Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              height: 180,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: reco_job.length,
                  itemBuilder: (BuildContext context,int index)
                  {
                    return
                    Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                              child: Card(
                                color: Color(0xffF8F9F8),
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context).size.height * 0.08,
                                            width: MediaQuery.of(context).size.width * 0.15,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    image: NetworkImage(reco_job[index]['img'].toString()),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Spacer(),
                                          Container(
                                            height: 40,
                                            child: Card(
                                              color: Colors.green[50],
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30)),
                                              child: TextButton(
                                                  onPressed: () async{
                                                    final number=reco_job[index]['hr_mobile'].toString();
                                                    await FlutterPhoneDirectCaller.callNumber(number);
                                                  },
                                                  child: Text("Call",
                                                    style: const TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold),
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(reco_job[index]['subcategory_name'].toString(),
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(reco_job[index]['company_name'].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber,
                                            fontSize: 13),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 35,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.22,
                                          child: Card(
                                              color: Colors.brown[50],
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20)),
                                              child: GestureDetector(
                                                onTap: (() {}),
                                                child: Center(
                                                    child: Text("Remote",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 12),
                                                    )),
                                              )),
                                        ),
                                        Container(
                                          height: 35,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.22,
                                          child: Card(
                                              color: Colors.brown[50],
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20)),
                                              child: GestureDetector(
                                                onTap: () {
                                                },
                                                child: Center(
                                                  child: Text("Full Time",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold, fontSize: 12),
                                                  ),
                                                ),
                                              )),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
              ),
            ):
            Text("No Recommended Job"),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Stack(
                      children: [
                        Container(
                          height:25,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                          ),
                          child: Text(
                            "Latest Jobs",
                            style: TextStyle(
                                fontSize: 17,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w700),
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
                      ]
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FutureBuilder <List<Details>>(
                future: get_job_details(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Details>? data = snapshot.data;
                    return data!.length!=0?
                    GridView.builder(
                      shrinkWrap: true,
                      physics:  NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 12.5/ 8,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 3,
                          crossAxisCount: 1
                      ),
                      itemBuilder: (BuildContext, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: InkWell(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserProfile(
                              //   userId: data[index].userId.toString(),
                                       userId:data[index].firstName.toString(),
                                       profile:data[index].profileImg.toString(),
                                       native:data[index].nativShakha.toString(),
                                       current:data[index].curntShakha.toString(),
                                       gender:data[index].gender.toString(),
                                       dob:data[index].dob.toString(),
                              )));
                            },
                            child: Card(
                              color: Color(0xffF8F9F8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              elevation: 2,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.1,
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            image: DecorationImage(
                                                image: NetworkImage(data[index].img.toString()),
                                                fit: BoxFit.cover)),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.65,
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(data[index].companyName.toString(),
                                              style:  TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(data[index].districtTitle.toString(),
                                              style:
                                              TextStyle(fontSize: 13, color: Colors.black26),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(data[index].comapnyEmail.toString(),
                                              style:
                                              TextStyle(fontSize: 13, color: Colors.black26),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 8),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(data[index].subcategoryName.toString(),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w800,
                                                        fontSize: 16,
                                                        color: Color(0xff3E3E3E)),
                                                  ),
                          
                                                  Row(
                                                    children:[
                                                      Text("Vacancies : ",
                                                        style:  TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black54,
                                                            fontWeight: FontWeight.w700
                                                        ),
                                                      ),
                                                      Text(data[index].noOfVacancy.toString(),
                                                        style:  TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black38
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Posted By : ",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black54,
                                                            fontWeight: FontWeight.w700
                                                        ),
                                                      ),
                                                      Text(data[index].firstName.toString(),
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black38,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.089,
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              child: Stack(
                                                  children: [
                                                    Container(
                                                        height: MediaQuery.of(context).size.height * 0.055,
                                                        // width: MediaQuery.of(context).size.width * 0.4,
                                                        child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(30)),
                                                          color: Colors.green,
                                                          child: Center(
                                                            child: Padding(
                                                              padding: EdgeInsets.only(right: 20,left: 20),
                                                              // child: Text(data[index].firstName.toString(),
                                                              child: Text('Contact'+" "+ data[index].firstName.toString(),
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 15),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    // Positioned(
                                                    //   left: 100,
                                                    //     bottom: 18,
                                                    //     child: Container(
                                                    //     height: 47,
                                                    //     width: 47,
                                                    //     child: InkWell(
                                                    //         child: Card(
                                                    //           elevation: 5,
                                                    //           color: Colors.green,
                                                    //           shape: RoundedRectangleBorder(
                                                    //               borderRadius: BorderRadius.circular(
                                                    //                   50)),
                                                    //           child: IconButton(
                                                    //               onPressed: () async{
                                                    //                   final number=data[index].hrMobile.toString();
                                                    //                   await FlutterPhoneDirectCaller.callNumber(number);
                                                    //               },
                                                    //               icon: Icon(
                                                    //                 Icons.phone,
                                                    //                 color: Colors.white,
                                                    //               )
                                                    //           ),
                                                    //         )
                                                    //     ),
                                                    //   ),
                                                    // )
                                                  ]
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(data[index].requiredExp.toString()+" year",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold, color: Colors.black26),
                                            ),
                                            Text("Experiance",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: Colors.black54),
                                            )
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(data[index].qualificationName.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black26),
                                                ),
                                                Text("Qualification",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13,
                                                      color: Colors.black54),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(data[index].createdAt.toString().replaceRange(11, 19, ""),
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black26),
                                                ),
                                                Text("Lastdate",
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13,
                                                      color: Colors.black54),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ):Text("No Job ");
                  }
                  return Text("No Job ");
                }),
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
                Text( 'Opening Jobs...',style: TextStyle(color: Colors.pink,fontSize: 17),),
              ]
          ),
        ],
      )
    );
  }
}
