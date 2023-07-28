import 'dart:convert';
import 'package:communityapp/screens/dashboard.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/Business/business_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class JobProfile extends StatefulWidget {
  const JobProfile({Key? key}) : super(key: key);

  @override
  State<JobProfile> createState() => _JobProfileState();
}

class _JobProfileState extends State<JobProfile> {
  // Initial Selected Value
  String dropdownvalue = 'Profession';
  var items = [
    'Profession',
    'Engineer',
    'Doctor',
    'Scientist',
    'Police',
  ];

  String? Category;
  String? sub_Category;
  String? location;
  String? district;
  String? qualifications;


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


  TextEditingController name=TextEditingController();
  TextEditingController bio=TextEditingController();

  @override
  void initState() {
    super.initState();
    get_Qualifications();
    get_city();
    bussi_Category();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        title: Text(
          "Create Your Job Profile",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
        ),
        backgroundColor: Color(0xffF4F8FB),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xffF4F8FB),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(children: [
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 3, bottom: 3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white,
                                    ),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    child: TextField(
                                      controller: name,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(20.0),
                                          border: InputBorder.none,
                                          hintText: "Name",
                                          hintStyle: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 3, bottom: 3),
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
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
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3, bottom: 3),
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        value: dropdownvalue,
                                        icon: Container(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding:
                                            EdgeInsets.only(
                                                right: 20, bottom: 10),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        items: items.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Container(
                                              alignment: Alignment.bottomLeft,
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20, bottom: 15),
                                                child: Text(
                                                  items,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownvalue = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 3, bottom: 3),
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
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
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 3, bottom: 3),
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
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
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: EdgeInsets.only(top: 3, bottom: 3),
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * .9,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
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
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: EdgeInsets.only(top: 3, bottom: 3),
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * .9,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
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
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              height: 126,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: TextFormField(
                                controller: bio,
                                maxLines: 20,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(20),
                                    border: InputBorder.none,
                                    hintText: 'Bio'
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [
                            Colors.blue.shade400,
                            Colors.blue.shade100,
                          ],
                        )
                    ),
                    child: MaterialButton(
                      onPressed: () async{
                        if(name.text.isNotEmpty && qualifications!=null && dropdownvalue!=null
                            && district!=null && Category!=null && sub_Category!=null && bio.text.isNotEmpty){
                          final pref=await SharedPreferences.getInstance();
                          var get=pref.getString('user_id');
                          var dio1 = Dio();
                          var formData = FormData.fromMap({
                            'user_id': get.toString(),
                            "name":name.text.toString(),
                            'qualification':qualifications,
                            'profession': dropdownvalue,
                            'location': district,
                            'category': Category,
                            'sub_category': sub_Category,
                            'bio': bio.text.toString(),

                          });
                          print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                          var response = await dio1.post('https://community.creditmywallet.in.net/api/create_job_profile'
                              ,data: formData);
                          var res=response.data;
                          var msg=res["status_message"];
                          setState(() {
                            print("%%%%%%%%%%%%%%%"+res.toString());
                          });
                          if(res["status_message"]=="Job Profile Added Successfully")
                          {
                            Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM);
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context)=>Dashboard()));
                          }
                          else
                          {
                            Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM);
                          }
                        }
                        else
                          {
                            Fluttertoast.showToast(msg: "Blank Field Not Allow",toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM);
                          }



                      },
                      child: Text("Save",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white),),
                    ),
                  ),
                  Container(
                    height: 30,
                  )
                ]),
              ),
            ],
          )
      ),
    );
  }
}
