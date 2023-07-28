import 'dart:convert';
import 'package:communityapp/screens/dashboard.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Matrimony/metrimony_list.dart';
import 'package:communityapp/screens/auth/matrimony_subscriptions_model.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionPlan extends StatefulWidget {
  const SubscriptionPlan({Key? key}) : super(key: key);

  @override
  State<SubscriptionPlan> createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<SubscriptionPlan> {


  String? gender;
  String? looking_for;

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC40452',
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

   Future<List<StatusMessage>> matrimony_subs() async{
    Uri url=Uri.parse("https://community.creditmywallet.in.net/api/view_matrimony_subs");
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
          looking_for='1';
        });
      }
      else if(gender=="1")
      {
        setState(() {
          looking_for='0';
        });
      }
    });
  }
  late Razorpay razorpay;
  String? subscription_id;
  String? subscription_name;
  String? subscription_price;

  @override
  void initState() {
    super.initState();
    setState(() {
      get_banner();
      matrimony_subs();
      getuser();
    });
    razorpay=new Razorpay();
    setState(() {
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    print('Success Response: $response');
    print("${response.orderId} \n ${response.paymentId} \n ${response.signature}");
    setState(() {
      print("${response.paymentId}");
    });
    var paymentid="${response.paymentId}";
    if(response=="PaymentSuccessResponse")
    {
    }
    else
    {
      final pref=await SharedPreferences.getInstance();
      var user_id=pref.getString('user_id');
      var dio=Dio();
      var formData = FormData.fromMap({
        'user_id': user_id.toString(),
        'transection_id': paymentid.toString(),
        'amount':subscription_price.toString(),
        'status':"captured",
        'subscripton_id':subscription_id.toString(),
        'subscripton_name':subscription_name.toString(),
        'subscripton_price':subscription_price.toString(),
      });
      var response = await dio.post('https://community.creditmywallet.in.net/api/transec_his',
          data: formData);
      var res=response.data;
      setState(() {
        print("dfbkbjruvbksuem b,hm. mnujhjkn mnjhktuijkv h"+res.toString());
      });
      Fluttertoast.showToast(msg: "Subscription Successfull",toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
     Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Dashboard()));

    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    print("jnnm m m cv mcvbn,nkhkhklhkl"+"${response.code} \n ${response.message}\n" );
    setState(() {
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
  }

  void openCheckout() async  {
    var options = {
      'key': 'rzp_test_jQ4V97yYfBKXcY',
      'amount': num.parse(subscription_price.toString())*100,
      'name': 'Vadal',
      'description': 'Fine T-Shirt',
      'prefill': {
        'contact': '9651821818',
        'email': 'test@razorpay.com'
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  //int totalAmount=0;
  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F8FB),
      body: SafeArea(
        child: Column(
            children: [
              SizedBox(
                height: 20,
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
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Stack(
                        children: [
                          Container(
                            height:25,
                            width: MediaQuery.of(context).size.width * 0.30,
                            decoration: BoxDecoration(
                            ),
                            child: Text(
                              "Choose Plans",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Positioned(
                              top: 22,
                              child: Container(
                                height: 2,
                                width: MediaQuery.of(context).size.width * 0.20,
                                color: Colors.black,
                              )
                          )
                        ]
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 15,
            ),
            FutureBuilder <List<StatusMessage>>(
                    future: matrimony_subs(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData)
                      {
                        List<StatusMessage>? data = snapshot.data;
                        return Expanded(child: ListView.builder(
                            itemCount: data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 40),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context)=>MatrimonyList(
                                                    looking_for: looking_for.toString(),
                                                    height: '',
                                                    address_name: '',
                                                    skin_tone: '',
                                                    moon_sign: '',
                                                    sun_sign: '',
                                                    qualification: '',
                                                    profession: '',
                                                    district: '',
                                                    name: 'Simple',
                                                  )));
                                            },
                                            child: Container(
                                              height: 350, width: 226,
                                              child: Card(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 68,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 70),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.currency_rupee,
                                                            color: Colors.pink.shade200,
                                                            size: 20,
                                                          ),
                                                          Text(data[index].price.toString(),
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                FontWeight.w700,
                                                                color: Color(0xffFA6393)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 26,
                                                    ),
                                                    Container(
                                                      height: MediaQuery.of(context).size.height * 0.2,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 30),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceAround,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                data[index].viewProfile=="0"?
                                                                Icon(
                                                                  Icons.check,
                                                                  color: Colors.amber,
                                                                  size: 18,
                                                                ):
                                                                Icon(
                                                                  Icons.close_outlined,
                                                                  color: Colors.amber,
                                                                  size: 18,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "View profile details",
                                                                  style: TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight:
                                                                      FontWeight.w400,
                                                                      color: Color(
                                                                          0xff878383)),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                data[index].personalMess=="0"?
                                                                Icon(
                                                                  Icons.check,
                                                                  color: Colors.amber,
                                                                  size: 18,
                                                                ):
                                                                Icon(
                                                                  Icons.close_outlined,
                                                                  color: Colors.amber,
                                                                  size: 18,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "Personal Message",
                                                                  style: TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight:
                                                                      FontWeight.w400,
                                                                      color: Color(
                                                                          0xff878383)),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children:  [
                                                                data[index].chat=="0"?
                                                                Icon(
                                                                  Icons.check,
                                                                  color: Colors.amber,
                                                                  size: 18,
                                                                ):
                                                                Icon(
                                                                  Icons.close_outlined,
                                                                  color: Colors.amber,
                                                                  size: 18,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "Live one to one chat",
                                                                  style: TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight:
                                                                      FontWeight.w400,
                                                                      color: Color(
                                                                          0xff878383)),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                data[index].cms=="0"?
                                                                Icon(
                                                                  Icons.check,
                                                                  color: Colors.amber,
                                                                  size: 18,
                                                                ):
                                                                Icon(
                                                                  Icons.close_outlined,
                                                                  color: Colors.amber,
                                                                  size: 18,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "Customer Support",
                                                                  style: TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight:
                                                                      FontWeight.w400,
                                                                      color: Color(
                                                                          0xff878383)),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                data[index].newMatches=="0"?
                                                                Icon(
                                                                  Icons.check,
                                                                  color: Colors.amber,
                                                                  size: 18,
                                                                ):
                                                                Icon(
                                                                  Icons.close_outlined,
                                                                  color: Colors.amber,
                                                                  size: 18,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "Unlimited new matches",
                                                                  style: TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight:
                                                                      FontWeight.w400,
                                                                      color: Color(
                                                                          0xff878383)),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    InkWell(
                                                      onTap: () async{
                                                        setState(() {
                                                          subscription_id=data[index].subsId.toString();
                                                          subscription_name=data[index].name.toString();
                                                          subscription_price=data[index].price.toString();
                                                        });
                                                        openCheckout();
                                                      },
                                                      child: Container(
                                                        child: Center(
                                                          child: Text(
                                                            "Select",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                        height: 45,
                                                        width: 168,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(20),
                                                            gradient: LinearGradient(
                                                                begin:
                                                                Alignment.bottomLeft,
                                                                end: Alignment.topRight,
                                                                colors: [
                                                                  Colors.blue.shade200,
                                                                  Colors.blue.shade400
                                                                ])),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 60,),
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                data[index].name.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                    color: Color(0xffFFFFFF)),
                                              ),
                                            ),
                                            height: 100, width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.white,
                                                    Colors.pink.shade300
                                                  ]),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                              );
                            })
                        );
                      }
                      else{
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text("No Matrimony"),
                            )
                          ],
                        );
                      }
                    }
                ),

            ],
          ),
      ),
    );
  }
}
