import 'dart:convert';
import 'package:communityapp/screens/auth/vadaval_strong_model.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/sanskriti/post_sanskriti_topic.dart';
import 'package:flutter/material.dart';

class VadavalStrong extends StatefulWidget {
  const VadavalStrong({Key? key}) : super(key: key);

  @override
  State<VadavalStrong> createState() => _VadavalStrongState();
}

class _VadavalStrongState extends State<VadavalStrong> {
  List<String> _images = [
    'assets/images/slider.png',
    'assets/images/slider.png',
  ];


  int? man,woman,man_per,woman_per;
  int? man1,woman1,man_per1,woman_per1;

  String? current_shakha;
  List currentShakha=[];
  Future getCurrentShakha() async{
    var url="https://community.creditmywallet.in.net/api/get_current_shakha";
    http.Response response=await http.get(Uri.parse(url));
    var res=jsonDecode(response.body)['response_data'];
    setState(() {
      print("%%%%%%%%%%%%"+res.toString());
      currentShakha=res;
      print(currentShakha.toString()+"%%%%%%%%%%%%%%%%");
    });

  }

  Future total_mebel() async{
    var url="https://community.creditmywallet.in.net/api/total_member";
    http.Response response=await http.post(Uri.parse(url));
    var res=jsonDecode(response.body);
    setState(() {
      man=res['men'];
      man_per=res['men_pers'];
      woman=res['woman'];
      woman_per=res['womenper'];
      print("%^&*()_+"+res.toString());
    });

  }

  Future total_mebel_all_shakha() async{
    Map data={
      'shakha_id ':currentShakha
    };
    var url="https://community.creditmywallet.in.net/api/total_member";
    var body=jsonEncode(data);
    http.Response response=await http.post(Uri.parse(url),body: body);
    var res=jsonDecode(response.body);
    setState(() {
      man1=res['men'];
      man_per1=res['men_pers'];
      woman1=res['woman'];
      woman_per1=res['womenper'];
      print("%^&*()_+"+res.toString());
      print("%^&*()_+"+res.toString()+data.toString());
    });

  }

  Future <List<Strong>> vadavl_Strong() async {
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_position_member");
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      print(data.toString()+"%%%%%%%%%%");
      print(data);
      return data.map((job) => Strong.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  void initState() {
    super.initState();
    total_mebel();
    getCurrentShakha();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        title: const Text(
          "Vadval Stronge",
          style: TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        backgroundColor: Color(0xffEEEEEE),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
              size: 22,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color(0xffEEEEEE),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 17,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 17),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Proud to be Part of community",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff767676)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        FutureBuilder <List<Strong>>(
                            future: vadavl_Strong(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Strong>? data = snapshot.data;
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics:  NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: data!.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 5/ 6.5,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 3,
                                      crossAxisCount: 4
                                  ),
                                  itemBuilder: (BuildContext, int index) {
                                    return Container(
                                      height: 100, width: 80,
                                      child: Card(
                                        color: Color.fromARGB(255, 255, 246, 247),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 14,
                                            ),
                                            Container(
                                                height: 30,
                                                width: 30,
                                                child: Image.network(data[index].img.toString(),
                                                  fit: BoxFit.fill,)
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(data[index].count.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12,
                                                  color: Color(0xff767676)),
                                            ),
                                            Text(data[index].name.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Color(0xff767676)),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              return Text("No Vadval Strong");
                            }),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(0xffEEEEEE),
                child: Column(
                  children: [
                    SizedBox(
                      height: 21,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 3, bottom: 3, left: 15, right: 15),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: current_shakha,
                            hint: Text("        Current Sakha"),
                            icon: Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(Icons.arrow_drop_down),
                            ),
                            items: currentShakha.map((item) {
                              return DropdownMenuItem(
                                value: item['shakha_id'].toString(),
                                child: Padding(
                                  padding:  EdgeInsets.only(left: 20),
                                  child: Text(
                                    item['shakha_name'].toString(),
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                current_shakha = newValue! as String?;
                                total_mebel_all_shakha();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    current_shakha==null?
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 109,
                            width: 156,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Image.asset(
                                            "assets/images/v16.png",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Text(man_per.toString()+"%",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xffFA6393)),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(man.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff767676)),
                                    ),
                                    Text(
                                      "Male Mambers",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff767676),
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 109,
                            width: 156,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Image.asset(
                                            "assets/images/v17.png",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Text(woman_per.toString()+"%",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xffFA6393)),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(woman.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff767676)),
                                    ),
                                    Text(
                                      "Female Mambers",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff767676),
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ):
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 109,
                            width: 156,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(50)),
                                          child: Image.asset(
                                            "assets/images/v16.png",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Text(man_per1.toString()+"%",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xffFA6393)),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(man1.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff767676)),
                                    ),
                                    Text(
                                      "Male Mambers",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff767676),
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 109,
                            width: 156,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(50)),
                                          child: Image.asset(
                                            "assets/images/v17.png",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Text(woman_per1.toString()+"%",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xffFA6393)),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(woman1.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff767676)),
                                    ),
                                    Text(
                                      "Female Mambers",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff767676),
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: CarouselSlider(
                options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    viewportFraction: 1),
                items: _images
                    .map((item) => Center(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.92,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(
                                    item,
                                  ),
                                  fit: BoxFit.cover)),
                        )))
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 46,
            ),
          ],
        ),
      ),
    );
  }
}

Widget VadavalStrongCard(img, String name, String symbol) {
  return
    Container(
    height: 100, width: 80,
    child: Card(
      color: Color.fromARGB(255, 255, 246, 247),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          const SizedBox(
            height: 14,
          ),
          Container(
              // height: Get.height * 0.08,
              // width: Get.width * 0.13,
              height: 30,
              width: 30,
              child: Image.asset(img)),
          const SizedBox(
            height: 6,
          ),
          Text(
            name,
            style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Color(0xff767676)),
          ),
          Text(
            symbol,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xff767676)),
          )
        ],
      ),
    ),
  );
}
