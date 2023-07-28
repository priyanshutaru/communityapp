import 'package:communityapp/screens/Job/job_detail.dart';
import 'package:flutter/material.dart';

class JobSearch extends StatefulWidget {
  const JobSearch({Key? key}) : super(key: key);

  @override
  State<JobSearch> createState() => _JobSearchState();
}

class _JobSearchState extends State<JobSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(31, 148, 146, 146),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "Find Your Dream Job Here",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.27,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(31, 148, 146, 146),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Job Catagories"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Job Location",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Card(
                      elevation: 3,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.06,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              colors: [
                                Colors.blue,
                                Colors.white,
                              ],
                            )),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>JobDetaile()));
                            },
                            child: const Center(
                                child: Text(
                                  "Search Now",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                ))),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 120),
              child: Text(
                "Recommended  Jobs",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>JobDetaile()));
                          },
                          child: _card(
                              "assets/images/education.png",
                              "Open",
                              "Product Designer",
                              "Binary Academy",
                              "Remote",
                              "Full Time"),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>JobDetaile()));
                          },
                          child: _card(
                              "assets/images/education.png",
                              "Open",
                              "UI/UX Designer",
                              "Binary Academy",
                              "Remote",
                              "Full Time"),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>JobDetaile()));
                          },
                          child: _card(
                              "assets/images/education.png",
                              "Open",
                              "Product Designer",
                              "Binary Academy",
                              "Remote",
                              "Full Time"),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>JobDetaile()));
                          },
                          child: _card(
                              "assets/images/education.png",
                              "Open",
                              "Product Designer",
                              "Binary Academy",
                              "Remote",
                              "Full Time"),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>JobDetaile()));
                          },
                          child: _card(
                              "assets/images/education.png",
                              "Open",
                              "Product Designer",
                              "Binary Academy",
                              "Remote",
                              "Full Time"),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>JobDetaile()));
                          },
                          child: _card(
                              "assets/images/education.png",
                              "Open",
                              "Product Designer",
                              "Binary Academy",
                              "Remote",
                              "Full Time"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(right: 200),
                child: Text(
                  "Latest Jobs",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Card(
                        color: Color(0xffF8F9F8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 2,
                        child: Column(
                          children: [
                            const SizedBox(
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
                                          image: AssetImage("assets/images/sports.png"),
                                          fit: BoxFit.cover)),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Basti UP 51 272194",
                                        style:  TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text("ABC Limited",
                                        style:
                                        TextStyle(fontSize: 13, color: Colors.black26),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text("kdnsd123@gmail.com",
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
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(" PHP Language",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16,
                                                  color: Color(0xff3E3E3E)),
                                            ),
                                            Text("Vacancies: 12",
                                              style: const TextStyle(
                                                  fontSize: 14, color: Colors.black38),
                                            ),
                                            Text("Posted By: Mohan",
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
                                                      padding: const EdgeInsets.only(right: 20),
                                                      child: Text("Ghansyam",
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
                                      Text("2 year",
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
                                          Text("B.Tech",
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
                                          Text("12 june 2012",
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
                    )






                    /*InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>JobDetaile()));
                      },
                      child: _widget(
                          "assets/images/sports.png",
                          "ABC Limited",
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
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>JobDetaile()));
                      },
                      child: _widget(
                          "assets/images/sports.png",
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
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>JobDetaile()));
                      },
                      child: _widget(
                          "assets/images/education.png",
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
                    )*/
                  ],
                ))
          ],
        ),
      ),
    );
  }


  Widget _card(img, String button, String text, String colortext, String card1,
      String card2) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.45,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Card(
          color: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(img),
                    ),
                    Spacer(),
                    Container(
                      height: 40,
                      child: Card(
                        color: Colors.green[50],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              button,
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  text,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  colortext,
                  style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: Card(
                        color: Colors.brown[50],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: GestureDetector(
                          onTap: (() {}),
                          child: Center(
                              child: Text(
                                card1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              )),
                        )),
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.20,
                    child: Card(
                        color: Colors.brown[50],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              card2,
                              style: const TextStyle(
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
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.95,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          elevation: 10,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(img))),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        area,
                        style:
                        const TextStyle(fontSize: 13, color: Colors.black26),
                      ),
                      Text(
                        email,
                        style:
                        const TextStyle(fontSize: 13, color: Colors.black26),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ))
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                language,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black54),
                              ),
                              Text(
                                vacancies,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black26),
                              ),
                              Text(
                                postby,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black26),
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
                                  height: 60,
                                  width: 150,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            30)),
                                    color: Colors.green,
                                    child: Center(
                                      child: Text(
                                        cardtext,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
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
                                          elevation: 15,
                                          color: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(50)),
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
                              fontWeight: FontWeight.bold, color: Colors
                              .black54),
                        ),
                        Text(
                          text,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black26),
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
                                  color: Colors.black54),
                            ),
                            Text(
                              qualification,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black26),
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
                                  color: Colors.black54),
                            ),
                            Text(
                              lastdate,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black26),
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
  }

}
