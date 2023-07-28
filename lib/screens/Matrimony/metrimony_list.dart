import 'dart:convert';
import 'package:card_loading/card_loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Business/business_info.dart';
import 'package:communityapp/screens/Matrimony/advance_filter_model.dart';
import 'package:communityapp/screens/Matrimony/advance_filter_page.dart';
import 'package:communityapp/screens/Matrimony/matrimony_profile.dart';
import 'package:communityapp/screens/Matrimony/subscription_plan.dart';
import 'package:communityapp/screens/auth/mymatrimony.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class MatrimonyList extends StatefulWidget {
/*  const MatrimonyList({Key? key}) : super(key: key);*/
String? looking_for,address_name,height,skin_tone,moon_sign,sun_sign,qualification,profession,district,name;
String? mat_id;
MatrimonyList({
  required this.looking_for,
  required this.address_name,
  required this.height,
  required this.skin_tone,
  required this.moon_sign,
  required this.sun_sign,
  required this.qualification,
  required this.profession,
  required this.district,
  this.mat_id,
  required this.name
});
  @override
  State<MatrimonyList> createState() => _MatrimonyListState();
}
class _MatrimonyListState extends State<MatrimonyList> {
  String dropdownvalue = 'Groom/Bride';
  var items = [
    'Groom/Bride',
    'Groom',
    'Bride',
  ];
String? subscription_id;
Future  matrimony_profile() async {
     final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id': user_id,
      "mat_id": "${widget.mat_id}",
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/view_matrimony");
    var body=jsonEncode(data);
    final response = await http.post(url,headers: {"Content-Type": "application/json"},body: body);
    var res = json.decode(response.body);
       setState(() {
        subscription_id = res['subscribe_status'];
      });
  }

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC11548',
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
  String? gender;
  String? gnder;
  Future getuser() async{
    final pref=await SharedPreferences.getInstance();
    var get=pref.getString('user_id');
    Map data={
      'user_id':get.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_user");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    var res=json.decode(response.body)[0];
    setState(() {
      gender=res['gender'];
      if(gender=="0")
        {
          setState(() {
            gnder="Bride";
          });
        }
      else if(gender=="1")
        {
          setState(() {
            gnder="Groom";
          });
        }
    });
  }

Future <List<Response>> my_matrimony() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={"user_id":user_id.toString()};
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/my_matrimony");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['response'];
      print(data.toString()+"%%%%%%%%%%");
      return data.map((job1) => Response.fromJson(job1)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

Future <List<Filtter_Model>> advance_search_filter() async {
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'looking_for':"0",
      'address': "${widget.district.toString()}",
      'skin_tone': "${widget.skin_tone.toString()}",
      'sun_sign': "${widget.sun_sign.toString()}",
      'moon_sign': "${widget.moon_sign.toString()}",
      'height': "${widget.height.toString()}",
      'education': "${widget.qualification.toString()}",
      'profession': "${widget.profession.toString()}",
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/advance_filter_matrimony");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      print(data.toString()+"%%%%%%%%%%");
      return data.map((job1) => Filtter_Model.fromJson(job1)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  // List advance_filter=[];
  // Future advance_search_filter() async {
  //   Map data = {
  //     'looking_for': '0',
  //     'address': "${widget.district}",
  //     'skin_tone': "${widget.skin_tone}",
  //     'sun_sign': "${widget.sun_sign}",
  //     'moon_sign': "${widget.moon_sign}",
  //     'height': "${widget.height}",
  //     'education': "${widget.qualification}",
  //     'profession': "${widget.profession}",
  //     'name':"${widget.name}"
  //   };
  //   setState(() {
  //     print(data.toString()+"vjnvjnndvnm");
  //   });
  //   Uri url = Uri.parse("https://community.creditmywallet.in.net/api/advance_filter_matrimony");
  //   var body = jsonEncode(data);
  //   final response = await http.post(
  //       url, headers: {"Content-Type": "application/json"}, body: body);
  //   print(response);
  //   if (response.statusCode == 200) {
  //     var res = json.decode(response.body);
  //     setState(() {
  //       advance_filter = res['data'];
  //       print(advance_filter.toString()+"olfcfv m,");
  //     });
  //   }
  // }


  List search=[];
  Future search_matrimony() async {
    Map data = {
      'looking_for': "${widget.looking_for}",
      //'looking_for': "1",
    };
    print(data.toString()+"vvjhvjhh");
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/search_matrimony");
    var body = jsonEncode(data);
    final response = await http.post(
        url, headers: {"Content-Type": "application/json"}, body: body);
    print(response);
    if (response.statusCode == 200) {
      var res = json.decode(response.body)['data'];
      setState(() {
        search = res;
        print(data);
      });
    }
  }
  String? ht;

  @override
  void initState() {
    super.initState();
    get_banner();
    getuser();
    my_matrimony();
    search_matrimony();
    advance_search_filter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF4F8FB),
        body: Banner.length!=0? SingleChildScrollView(
          child: Column(
              children: [
                SizedBox(
                  height: 30,
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
                )
                :CardLoading(height: MediaQuery.of(context).size.height),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * .45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Center(
                            child: Text(gnder.toString(),
                              style: TextStyle(
                                  fontSize: 16 ,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff878383)),
                            ),
                          )

                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>AdvanceFilterPage(
                            brid_or_groom: gnder.toString(),))
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Center(child: Text("Advance Search")),
                        ),
                      ),
                    )
                  ],
                ),
                "${widget.name}"!="Filter"?
                FutureBuilder <List<Response>>(
                future: my_matrimony(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Response>? data = snapshot.data;
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
                        return 
                        InkWell(
                          onTap: () {
                            setState(() {
                              ht = data[index].height.toString() ;
                            });
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>MatrimonyProfile(
                                  mat_id: data[index].matId.toString(),
                                )
                            ),
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
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20,),
                                          Container(
                                            height: 100, width: 90,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(data[index].profile.toString()),
                                                  fit: BoxFit.fill),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),  
                                        ],
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
                                            Row(
                                              children: [
                                                Text(data[index].name.toString() ,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 17,
                                                      color: Colors.pink),
                                                ),
                                                Spacer(),
                                                Icon(Icons.keyboard_arrow_right,size: 30,)
                                              ],
                                            ),
                                            Text("Skin Tone: "+data[index].skinTone.toString(),style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black54),),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Text("DOB: "+data[index].dob.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Color(0xff878383)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              children: [

                                                Text("Height: "+ data[index].height.toString() + " fit",style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: Color(0xff878383)),)

                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Text("Sun Sign: "+
                                                    data[index].sunSign.toString(),
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
                                                
                                                Text("Moon Sign: "+
                                                  data[index].moonSign.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Color(0xff878383)),
                                                ),
                                              ],
                                            ),
                                            // SizedBox(
                                            //   height: 5,
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     Text("Profession: "+data[index].profession.toString(),
                                            //          style: TextStyle(
                                            //           fontWeight: FontWeight.w400,
                                            //           fontSize: 12,
                                            //           color: Color(0xff878383)),
                                            //     ),
                                            //
                                            //   ],
                                            // ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            //  Row(
                                            //   children: [
                                            //     Text(data[index].addressName.toString(),
                                            //          style: TextStyle(
                                            //           fontWeight: FontWeight.w400,
                                            //           fontSize: 12,
                                            //           color: Color(0xff878383)),
                                            //     ),
                                            //
                                            //   ],
                                            // ),
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
                  return Text("No Register Matrimony");
                }
                )
                :
               FutureBuilder <List<Filtter_Model>>(
                future: advance_search_filter(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Filtter_Model>? data = snapshot.data;
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
                        return 
                        InkWell(
                          onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>MatrimonyProfile(
                                  mat_id: data[index].matId.toString(),
                                )
                            ),
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
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20,),
                                          Container(
                                            height: 100, width: 90,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(data[index].profile.toString()),
                                                  fit: BoxFit.fill),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),  
                                        ],
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
                                            Row(
                                              children: [
                                                Text(data[index].name.toString() ,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 17,
                                                      color: Colors.pink),
                                                ),
                                                Spacer(),
                                                Icon(Icons.keyboard_arrow_right,size: 30,)
                                              ],
                                            ),
                                            Text("Skin Tone: "+data[index].skinTone.toString(),style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black54),),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Text("DOB: "+data[index].dob.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Color(0xff878383)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              children: [

                                                Text("Height: "+ data[index].height.toString() + " fit",style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: Color(0xff878383)),)

                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Text("Sun Sign: "+
                                                    data[index].sunSign.toString(),
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
                                                
                                                Text("Moon Sign: "+
                                                  data[index].moonSign.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Color(0xff878383)),
                                                ),
                                              ],
                                            ),
                                            // SizedBox(
                                            //   height: 5,
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     Text("Profession: "+data[index].profession.toString(),
                                            //          style: TextStyle(
                                            //           fontWeight: FontWeight.w400,
                                            //           fontSize: 12,
                                            //           color: Color(0xff878383)),
                                            //     ),
                                            //
                                            //   ],
                                            // ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            //  Row(
                                            //   children: [
                                            //     Text(data[index].addressName.toString(),
                                            //          style: TextStyle(
                                            //           fontWeight: FontWeight.w400,
                                            //           fontSize: 12,
                                            //           color: Color(0xff878383)),
                                            //     ),
                                            //
                                            //   ],
                                            // ),
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
                  return Text("No Register Matrimony");
                }
                )
              ]
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
                        'assets/images/splash.png',
                        fit: BoxFit.cover,
                        height: 70,
                        width: 70,
                      ),
                      
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
                  Text( 'Finding Bride & Groom',style: TextStyle(color: Colors.pink,fontSize: 17),),
                ]
            ),
          ],
        )
    );
  }
}