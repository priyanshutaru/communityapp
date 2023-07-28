import 'dart:convert';
import 'package:communityapp/screens/Matrimony/metrimony_list.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AdvanceFilterPage extends StatefulWidget {
  String? brid_or_groom;
  AdvanceFilterPage({required this.brid_or_groom});

  @override
  State<AdvanceFilterPage> createState() => _AdvanceFilterPageState();
}

class _AdvanceFilterPageState extends State<AdvanceFilterPage> {
  int height = 4;
  int age = 15;


  String dropdownvalue1 = 'Profession';
  String? skin_tone='Skin Tone';
  String? moon_sign="Moon Sign";
  String? sun_sign="Sun Sign";

  // List of items in our dropdown menu
  var skin = [
    'Skin Tone',
    'Honey',
    'Sand',
    'Warm Ivory',
    'Natural',
    'Chestnot',
    'Ivory',
    'Warm Beige',
    'Almond',
    'Porclain',
    'Godlen',
    'Beige',
  ];

  var moon = [
    'Moon Sign',
    'Capricorn',
    'Aquarius',
    'Pisces',
    'Aries',
    'Taurus',
    'Gemini',
    'Cancer',
    'Leo',
    'Vigro',
    'Libra',
    'Scorpio',
    'Sagittarius',
  ];
  var sun = [
    'Sun Sign',
    'Capricorn',
    'Aquarius',
    'Pisces',
    'Aries',
    'Taurus',
    'Gemini',
    'Cancer',
    'Leo',
    'Vigro',
    'Libra',
    'Scorpio',
    'Sagittarius',
  ];

  var items1 = [
    'Profession',
    'Clearical',
    'Technical',
  ];


  String? location;
  String? district;
  List get_district_list=[];
  Future  get_District() async{
    Map data={
      "state_id":location.toString(),
    };
    var url="https://community.creditmywallet.in.net/api/get_dist";
    var body1=jsonEncode(data);
    http.Response response=await http.post(Uri.parse(url),
        headers: {"Content-Type":"application/json"}, body: body1);
    var res=jsonDecode(response.body)['state'];
    setState(() {
      print("%%%%%FFFFFFFFFFFf%%%%%%%"+res.toString());
      get_district_list=res;
      print(get_district_list.toString()+"%%%%%%%%%%%%%%%%");
    });

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
  int? lokking_for;
  String? qualifications;
  String? address_name;
  String? last_name;
  List get_quali_list=[];
  Future  get_Qualifications() async{
    var url="https://community.creditmywallet.in.net/api/get_qua";
    http.Response response=await http.post(Uri.parse(url));
    var res=jsonDecode(response.body)['details'];
    setState(() {
      print("%%%%%%%%%%%%"+res.toString());
      get_quali_list=res;
      print(get_quali_list.toString()+"%%%%%%%%%%%%%%%%");
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



  @override
  void initState() {
    super.initState();
    get_banner();
    get_Qualifications();
    get_city();
  }
  void check(){
    if("${widget.brid_or_groom}"=="Bride")
      {
        setState(() {
          lokking_for=1;
        });
      }
    else if("${widget.brid_or_groom}"=="Groom")
    {
      setState(() {
        lokking_for=0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F8FB),
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Color(0xffF4F8FB),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              height: 9,
            ),
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: const Text(
                      "Looking for:",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              padding: EdgeInsets.only(left: 18),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  height: 40,
                  width: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Center(
                    child: Text("${widget.brid_or_groom}",
                      style: TextStyle(
                        fontSize: 17
                      ),
                    ),
                  )
                ),
              ),
            ),
            SizedBox(
              height: 36,
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    children: [
                      Text(
                        "Height:",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff000000)),
                      ),
                      Text(
                        "(feet)",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff000000)),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Slider(
                      label: "Height",
                      activeColor: Colors.green,
                      thumbColor: Colors.green[300],
                      value: height.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          height = value.toInt();
                          print("jkeruigkjnkgjnkbgjnkbgg"+height.toString());
                        });
                      },
                      min: 4,
                      max: 8,
                    ),
                  ],
                ),
                Text(
                  "" + height.toString(),
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    children: [
                      Text(
                        "Age :",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff000000)),
                      ),
                      Text(
                        "(Years)",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff000000)),
                      ),
                    ],
                  ),
                ),
                Slider(
                  label: "Age",
                  activeColor: Colors.green,
                  thumbColor: Colors.green[300],
                  value: age.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      age = value.toInt();
                    });
                  },
                  min: 15,
                  max: 50,
                ),
                Text(
                  "" + age.toString(),
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27, right: 21, top: 33),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      "Skin Tone :",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000)),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.54,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: skin_tone,
                          icon: const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.arrow_drop_down,
                              size: 35,
                            ),
                          ),
                          items: skin.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(items,
                                  style: TextStyle(
                                      color: Color(0xff878383),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              skin_tone = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27, right: 21, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      "Moon Sign :",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000)),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: moon_sign,
                          icon: const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.arrow_drop_down,
                              size: 35,
                            ),
                          ),
                          items: moon.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  items,
                                  style: const TextStyle(
                                      color: Color(0xff878383),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              moon_sign = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 27, right: 21, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        border: Border()),
                    child: Text(
                      "Sun Sign :",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000)),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.54,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: sun_sign,
                          icon: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.arrow_drop_down,
                              size: 35,
                            ),
                          ),
                          items: sun.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  items,
                                  style: const TextStyle(
                                      color: Color(0xff878383),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              sun_sign = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 27, right: 21, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        border: Border(
                            )),
                    child: Text(
                      "Qualification :",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000)),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.49,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: qualifications,
                          hint: Text("      Qualifications"),
                          icon: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(Icons.arrow_drop_down),
                          ),
                          items: get_quali_list.map((item) {
                            return DropdownMenuItem(
                              value: item['q_id'].toString(),
                              child: Padding(
                                padding:  EdgeInsets.only(left: 30),
                                child: Text(
                                  item['qualification'].toString(),
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              setState((){
                                qualifications = newValue! as String?;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 27, right: 21, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: const BoxDecoration(
                        border: Border()),
                    child: const Text(
                      "Profession :",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000)),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.54,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: dropdownvalue1,
                          icon: const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.arrow_drop_down,
                              size: 35,
                            ),
                          ),
                          items: items1.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(items,
                                  style: TextStyle(
                                      color: Color(0xff878383),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue1 = newValue!;
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
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  Container(
                   // padding: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        border: Border()),
                    child: Text(
                      "State :",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000)),
                    ),
                  ),
                  Spacer(),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.71,
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
                                padding:  EdgeInsets.only(left: 30),
                                child: Text(
                                  item['state_title'].toString(),
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13
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
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  Container(
                    //padding: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        border: Border()),
                    child: Text(
                      "District :",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff000000)),
                    ),
                  ),
                  Spacer(),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.67,
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
                                padding:  EdgeInsets.only(left: 30),
                                child: Text(
                                  item['district_title'].toString(),
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13
                                  ),
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
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.41,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>MatrimonyList(
                          looking_for: lokking_for.toString(),
                          height: height.toString(),
                          skin_tone: skin_tone.toString(),
                          moon_sign: moon_sign,
                          sun_sign: sun_sign,
                          qualification: qualifications,
                          address_name: address_name,
                          profession: dropdownvalue1,
                          district: district,
                          name: 'Filter',
                        )));
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.54,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.pink.shade100,
                              Colors.pink.shade200,
                              Colors.pink.shade300,
                              Colors.pink.shade300,
                            ])),
                    child: Center(
                      child: Text(
                        "Apply Changes",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 55,
            )
          ],
        ),
      ),
    );
  }
}
