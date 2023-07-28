import 'dart:convert';
import 'package:communityapp/screens/dashboard.dart';
import 'package:communityapp/screens/profile_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Business/business_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenerateLead extends StatefulWidget {
  const GenerateLead({Key? key}) : super(key: key);

  @override
  State<GenerateLead> createState() => _GenerateLeadState();
}

class _GenerateLeadState extends State<GenerateLead> {
  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC80242',
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

  TextEditingController description=TextEditingController();
  TextEditingController contact_no=TextEditingController();
  String? Category;
  String? sub_Category;

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

  String? location;
  String? district;

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
  String? dob;
  late DateTime _myDateTime;


  @override
  void initState() {
    super.initState();
    setState(() {
      get_banner();
      get_city();
      bussi_Category();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F8FB),
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Color(0xffF4F8FB),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        title: const Text(
          "Post Your Requirnment",
          style: TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  color: Colors.brown[50],
                  child: Column(children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 37),
                                  child: Container(
                                    // width: Get.width * 0.9,
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Business Category",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff989595),
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 3, bottom: 3),
                                  child: Container(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width * .85,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        value: Category,
                                        hint: Text("      Category"),
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 20),
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
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 37 ),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Bussiness Sub-Category",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.black45),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 3, bottom: 3),
                                  child: Container(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width * .85,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        value: sub_Category,
                                        hint: Text("      Sub-Category"),
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                        items: bussiness_Sub_Category.map((item) {
                                          return DropdownMenuItem(
                                            value: item['subcategory_id'].toString(),
                                            child: Padding(
                                              padding:  EdgeInsets.only(left: 30),
                                              child: Text(
                                                item['subcategory_name'].toString(),
                                                style: TextStyle(color: Colors.black54),
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
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 37 ),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "End Date",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black45),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            InkWell(
                              onTap: () async{
                                _myDateTime= (await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2050),
                                ))!;
                                setState(() {
                                  dob=DateFormat('yyyy-MM-dd').format(_myDateTime);
                                });
                              },
                              child: Padding(
                                padding:  EdgeInsets.only(top: 3, bottom: 3),
                                child: Container(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width * .85,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 18,
                                        ),
                                        Container(
                                            child: Image.asset(
                                              "assets/images/year.png",
                                              height: 22,
                                            )
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        dob!=null?
                                        Text(dob.toString()):
                                        Text("Date"),
                                      ],
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 37 ),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Mobile No",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black45),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              height: 45,
                              width: MediaQuery.of(context).size.width * .85,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: contact_no,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                validator: (val) {
                                  if (val! == null &&
                                      val.isEmpty &&
                                      val.length == 10) {
                                    Fluttertoast.showToast(
                                        msg: "Please enter 10 digit mobile Number");
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(14.0),
                                  border: InputBorder.none,
                                  hintText: "Contact No",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff878383),
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 37),
                              child: Container(
                                // width: Get.width * 0.9,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Business Location State",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black45),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3, bottom: 3),
                              child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width * .85,
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
                                            style: TextStyle(color: Colors.black54),
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
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 37),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Business Location District",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black45),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3, bottom: 3),
                              child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width * .85,
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
                              height: 11,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 37),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Describe Requirnment",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff989595),
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: TextFormField(
                                controller: description,
                                maxLines: 20,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    border: InputBorder.none,
                                    hintText: 'Describe your requirement......',
                                    hintStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff979797))),
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 36,
                    ),
                    Container(
                        height: 45,
                        width: 300,
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
                        child: MaterialButton(
                          onPressed: () async{
                            if(Category==null)
                              {
                                Fluttertoast.showToast(msg: "Category is Empty",toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);
                              }
                            else if(sub_Category==null)
                              {
                                Fluttertoast.showToast(msg: "Sub Category is Empty",toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);
                              }
                            else if(contact_no.text.isEmpty)
                              {
                                Fluttertoast.showToast(msg: "Mobile Number is Empty",toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);
                              }
                            else if(location==null)
                            {
                              Fluttertoast.showToast(msg: "State is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else if(district==null)
                            {
                              Fluttertoast.showToast(msg: "District is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else if(description.text.isEmpty)
                            {
                              Fluttertoast.showToast(msg: "Descriptio is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else if(dob==null){
                              Fluttertoast.showToast(msg: "End Date is Empty",toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM);
                            }
                            else {
                              final pref = await SharedPreferences
                                  .getInstance();
                              var user_id = pref.getString('user_id');
                              var dio1 = Dio();
                              var formData = FormData.fromMap({
                                'user_id': user_id.toString(),
                                'cat_id': Category,
                                'end_date':dob,
                                'sub_cat_id': sub_Category,
                                'mobile': contact_no.text,
                                'description': description.text.toString(),
                                'city_id': district,
                              });
                              print(formData.fields.toString() +
                                  "^^^^^^^^^^^^^^");
                              var response = await dio1.post(
                                  'https://community.creditmywallet.in.net/api/add_business_leads'
                                  , data: formData);
                              var res = response.data;
                              var msg = res["status_message"];
                              setState(() {
                                print("%%%%%%%%%%%%%%%" + res.toString());
                              });
                              if (res["status_message"] == "Success") {
                                Fluttertoast.showToast(msg: msg.toString(),
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(
                                    builder: (context) => Dashboard()));
                              }
                              else {
                                Fluttertoast.showToast(msg: msg.toString(),
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM);
                              }
                            }
                          },
                          child: Text(
                            "Post Now",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        )
                    ),
                    SizedBox(
                      height: 44,
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
                  ]),
                ),
              ),
            ],
          )
      ),
    );
  }
}
