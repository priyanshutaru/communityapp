import 'package:flutter/material.dart';

class utils {
  static Widget listviewcard({var Images, var text ,var context} ) {
    return Container(
        height: 98,
        width: 98,
        child: Card(
            shadowColor: Colors.brown.shade900,
            color: Color(0xffFFFFFF),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.brown.withOpacity(0.0),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: Image.asset(
                        Images,
                        height: 32,
                        width: 33,
                      ),
                    ),
                    SizedBox(height: 9),
                    Text(
                      text.toString(),
                      style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    )
                  ],
                ),
                // Text(Text),
              ],
            )));
  }
}

class utils2 {
  static Widget cardview(String topics, String text, String news, time, date, Image,var context) {
    return Container(
        // height: Get.height * 0.25,
        width: MediaQuery.of(context).size.width * 0.95,
        child: Card(
          color: Color(0xffFCFCFC),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            Container(
                                // height: Get.height * 0.05,
                                // width: Get.width * 0.5,

                                height: 32,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Card(
                                  color: Color(0xffF6F6F6),
                                  child: Center(
                                      child: Text(
                                    topics,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10,
                                        color: Colors.black),
                                  )),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          // height: Get.height * 0.13,
                          width: MediaQuery.of(context).size.width * 0.55,
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              text,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: "Montserrat"),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          // height: 30,
                          width: MediaQuery.of(context).size.width * 0.55,
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Text(
                                news,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 10,
                                    color: Colors.black54),
                              ),
                              Spacer(),
                              Text(time,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                      color: Colors.black38)),
                              SizedBox(
                                width: 10,
                              ),
                              Text(date,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10,
                                      color: Colors.black38))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.27,
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage(Image), fit: BoxFit.fill)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class utils3 {
  static Widget cardlist(
    img,
    String text,
    String time,
    String date,
      var context,
  ) {
    return Container(
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.14,
              width: MediaQuery.of(context).size.width * 0.42,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(img), fit: BoxFit.fill)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 34,
              child: Text(
                text * 2,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.42,
              height: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.07,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
