import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/auth/get_job_model.dart';
import 'package:communityapp/screens/auth/search_job_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class JobSearchResult extends StatefulWidget {
 /* const JobSearchResult({Key? key}) : super(key: key);*/
  String? sub_Category,district;
  JobSearchResult({required this.sub_Category, required this.district});

  @override
  State<JobSearchResult> createState() => _JobSearchResultState();
}

class _JobSearchResultState extends State<JobSearchResult> {
  List<String> _images = [
    'assets/images/slider.png',
    'assets/images/slider.png',
  ];

  Future <List<Job_Search>> get_job_details() async {
    Map data={
      'job_position': "${widget.sub_Category}",
      'city_id':"${widget.district}"
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/search_jobs");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    print(response);
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['list'];
      print(data);
      return data.map((job) => Job_Search.fromJson(job)).toList();
    }
    else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Color.fromARGB(255, 226, 222, 222),
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white54),
          child: TextFormField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(15),
                suffixIcon: Icon(Icons.search),
                hintText: "Search Results.."),
          ),
        ),
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: CarouselSlider(
                  options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      autoPlay: true,
                      viewportFraction: 1),
                  items: _images
                      .map((item) =>
                      Center(
                          child: Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.2,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.9,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
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
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.38,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0, // This would be the width of the underline
                              ))),
                      child: const Text(
                        "Search Results:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FutureBuilder <List<Job_Search>>(
                  future: get_job_details(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Job_Search>? data = snapshot.data;
                      return data!.length!=0?
                      GridView.builder(
                        shrinkWrap: true,
                        physics:  NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 11.8/ 8,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 3,
                            crossAxisCount: 1
                        ),
                        itemBuilder: (BuildContext, int index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.95,
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
                                            Text(data[index].firstName.toString(),
                                              style:
                                              TextStyle(fontSize: 13, color: Colors.black26),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(data[index].comapnyEmail.toString(),
                                              style:
                                              const TextStyle(fontSize: 13, color: Colors.black26),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
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
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w800,
                                                        fontSize: 16,
                                                        color: Color(0xff3E3E3E)),
                                                  ),
                                                  Text("Vacancies: "+data[index].noOfVacancy.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14, color: Colors.black38),
                                                  ),
                                                  Text("Posted By: "+data[index].noOfVacancy.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14, color: Colors.black38),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Stack(children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      height: MediaQuery.of(context).size.height * 0.08,
                                                      width: MediaQuery.of(context).size.width * 0.4,
                                                      child: Card(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(30)),
                                                        color: Colors.green,
                                                        child: Center(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(right: 20),
                                                            child: Text(data[index].firstName.toString(),
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 15),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                        left: 100,
                                                      ),
                                                      child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        child: GestureDetector(
                                                            child: Card(
                                                              elevation: 5,
                                                              color: Colors.green,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(
                                                                      50)),
                                                              child: IconButton(
                                                                  onPressed: () {},
                                                                  icon: const Icon(
                                                                    Icons.phone,
                                                                    color: Colors.white,
                                                                  )),
                                                            )),
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(data[index].requiredExp.toString()+" year",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold, color: Colors.black26),
                                            ),
                                            Text("Experiance",
                                              style: const TextStyle(
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
                                                Text(data[index].qualification.toString(),
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
                          );
                        },
                      ):Text("No Job ");
                    }
                    return Text("No Job ");
                  }),
             /* Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // Get.to(ForumJobList());
                        },
                        child: _widget(
                            "rj3.png",
                            "Aaryan Academy",
                            "Basti UP 51 272194",
                            "kdnsd123@gmail.com",
                            4.7,
                            " PHP Language",
                            "Vacancies: 12",
                            "Posted By: Mohan",
                            "Ghansyam",
                            "2 year",
                            "Experiance",
                            "B.Tech",
                            "Qualification",
                            "12 june 2012",
                            "Lastdate"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          // Get.to(ForumJobList());
                        },
                        child: _widget(
                            "rj.png",
                            "Talk Show",
                            "Noida",
                            "kdnsd123@gmail.com",
                            4.7,
                            " PHP Language",
                            "Vacancies: 8",
                            "Posted By: Mohan",
                            "Ghansyam",
                            "2 year",
                            "Experiance",
                            "B.Tech",
                            "Qualification",
                            "12 june 2012",
                            "Lastdate"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          // Get.to(ForumJobList());
                        },
                        child: _widget(
                            "rj2.png",
                            "Job Snipers",
                            "Basti UP 51 272194",
                            "kdnsd123@gmail.com",
                            4.7,
                            " PHP Language",
                            "Vacancies: 22",
                            "Posted By: Mohan",
                            "Ghansyam",
                            "2 year",
                            "Experiance",
                            "B.Tech",
                            "Qualification",
                            "12 june 2012",
                            "Lastdate"),
                      )
                    ],
                  )),*/
            ],
          ),
        ),
      ),
    );
  }

  Widget _widget(img,
      String name,
      String area,
      var email,
      double rating,
      String language,
      String vacancies,
      String postby,
      String cardtext,
      var year,
      String text,
      String cources,
      String qualification,
      var date,
      String lastdate,) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Card(
        color: Color(0xffF8F9F8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.12,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage("assets/images/$img"),
                            fit: BoxFit.cover)),
                  ),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Text(
                              rating.toString(),
                              style: const TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.amber,
                                ))
                          ],
                        ),
                        Text(
                          area,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black26),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          email,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black26),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              language,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: Color(0xff3E3E3E)),
                            ),
                            Text(
                              vacancies,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black38),
                            ),
                            Text(
                              postby,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black38),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Stack(children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.08,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.4,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  color: Colors.green,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        cardtext,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 100,
                                ),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  child: GestureDetector(
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                50)),
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.phone,
                                              color: Colors.white,
                                            )),
                                      )),
                                ),
                              )
                            ]),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        year,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black26),
                      ),
                      Text(
                        text,
                        style: const TextStyle(
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
                          Text(
                            cources,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black26),
                          ),
                          Text(
                            qualification,
                            style: const TextStyle(
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
                          Text(
                            date,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black26),
                          ),
                          Text(
                            lastdate,
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
    );
  }

}