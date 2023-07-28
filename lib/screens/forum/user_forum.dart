import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/forum/post_forum.dart';
import 'package:flutter/material.dart';


class UserForum extends StatefulWidget {
  const UserForum({Key? key}) : super(key: key);

  @override
  State<UserForum> createState() => _UserForumState();
}

class _UserForumState extends State<UserForum> {
  List<String> _images = [
    'assets/images/slider.png',
    'assets/images/slider.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
        backgroundColor: Colors.brown[50],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(30)),
                    color: Colors.brown[50],
                  ),
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                  ),
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(30)),
                    color: Colors.brown[50],
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: Icon(Icons.search),
                          hintText: 'Search forum here',
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      autoPlay: true,
                    ),
                    items: _images
                        .map((item) => Container(
                              child: Center(
                                  child: Image.asset(
                                item,
                                fit: BoxFit.fill,
                              )),
                            ))
                        .toList(),
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>PostForum(
                      name: 'add',
                      forum_id: '',
                      tittle: '',
                      topic: '',
                      discussion: '',
                      user_id: '',
                    )));
              },
              child: Column(children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Card(
                    child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              child: Image.asset("assets/images/jobs.png"),
                            ),
                            const Text(
                              "How to right a Blogs?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black45),
                            ),
                            Column(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(top: 35),
                                  child: Icon(Icons.arrow_forward_ios),
                                ),
                                Text(
                                  "Edit",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                )
              ]),
            ),
            Column(children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Card(
                  child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            child: Image.asset("assets/images/jobs.png"),
                          ),
                          const Text(
                            "How to right a Blogs?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black45),
                          ),
                          Column(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(top: 35),
                                child: Icon(Icons.arrow_forward_ios),
                              ),
                              Text(
                                "Edit",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
              )
            ]),
            Column(children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Card(
                  child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            child: Image.asset("assets/images/bloodbank.png"),
                          ),
                          const Text(
                            "1500 word for a Blogs?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black45),
                          ),
                          Column(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(top: 35),
                                child: Icon(Icons.arrow_forward_ios),
                              ),
                              Text(
                                "Edit",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
              )
            ]),
            Column(children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Card(
                  child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            child: Image.asset("assets/images/jobs.png"),
                          ),
                          const Text(
                            "How to right a Blogs?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black45),
                          ),
                          Column(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(top: 35),
                                child: Icon(Icons.arrow_forward_ios),
                              ),
                              Text(
                                "Edit",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
