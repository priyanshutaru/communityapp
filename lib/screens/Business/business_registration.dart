import 'dart:convert';
import 'dart:io';
import 'package:communityapp/screens/Business/business_list.dart';
import 'package:communityapp/screens/home_page.dart';
import 'package:communityapp/screens/profile_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessRegistration extends StatefulWidget {
  /*const BusinessRegistration({Key? key}) : super(key: key);*/
  String? bussiness_id,name;
  BusinessRegistration({required this.bussiness_id,  this.name});

  @override
  State<BusinessRegistration> createState() => _BusinessRegistrationState();
}

class _BusinessRegistrationState extends State<BusinessRegistration> {
  // Initial Selected Value
  String? Category;
  String? sub_Category;
  String? bussiness_day;
  String? bussiness_time;
  String?  opening_day;
  String?  opening_day1;
   String? opening_time;
  String? opening_time1;

  var bussiness = [
    'Monday Saturday',
    'Tuesday Friday ',
    'Wednesday Saturday',
    'Thursday Monday ',
    'Friday Saturday',
  ];
  var time1 = [
    '10:00AM 05:00PM',
    '09:00AM 04:00PM ',
    '10:00AM 07:00PM',
    '09:00AM 06:00PM ',
    '11:00AM 08:00PM',
  ];

  late File _image;
  late File _image1;
  List<XFile> img = [];
  String? time;
  bool isimageselected=false;
  bool isimageselected1=false;
  bool isVisible = false;

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


  List gallery=[];
  Future get_gallery() async {
    Map data={
      "business_id": "${widget.bussiness_id}"
    };
    var url = Uri.parse("https://community.creditmywallet.in.net/api/get_business_gallery");
    var body=jsonEncode(data);
    final response = await http.post(url,headers:{"Content-Type": "application/json"},body: body);
    var res = await json.decode(response.body);
    print("response12" + response.body);

    if (response.statusCode == 200) {
      setState(() {
        gallery = res['data'];
        print("%%%%%%%%%%5555"+gallery.toString());
      });
    }
  }



  String? name,category,location_m,opening_time_mno,closing_time_m,email_m,website_m,p_img,
      contact,whatsapp,subCategory_m,category_m,about,opening_day_m,closing_day_m,name_m;
  String? cat_id,cat_name,sub_cat_id,sub_cat_name,state_id,state_name,dstic_id,distic_name;
  Future  my_Bussiness_details() async {
    Map data={
      "business_id": "${widget.bussiness_id}"
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_business_details");
    var body=jsonEncode(data);
    final response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    var res = json.decode(response.body);
    print("bussiness_details"+res.toString());
    setState(() {
      cat_id=res['cat_id'];
      if(cat_id!=null)
        {
          Category=cat_id;
        }
      else
        {
          null;
        }
      sub_cat_id=res['sub_cat_id'];
      cat_name=res['category_name'];
      if(sub_cat_id!=null)
      {
        sub_Category=sub_cat_id;
      }
      else
      {
        null;
      }
      sub_cat_name=res['subcategory_name'];
      state_id=res['state_id'];
      if(state_id!=null)
      {
        location=state_id;
      }
      else
      {
        null;
      }
      state_name=res['state'];
      dstic_id=res['city_id'];
      if(dstic_id!=null)
      {
        district=dstic_id;
      }
      else
      {
        null;
      }
      distic_name=res['district_name'];

      email_m=res['email'];
      p_img=res['profile_img'];
      website_m=res['website'];
      contact=res['contact'];
      whatsapp=res['whatsapp'];
      name_m=res['business_name'];
      opening_time_mno=res['opening_time'];
      closing_time_m=res['closing_time'];
      if(closing_time_m!=null && opening_time_mno!=null)
        {
          setState(() {
            opening_time=opening_time_mno.toString();
            opening_time=closing_time_m.toString();
          });
        }
      else
        {
          null;
        }
      opening_day_m=res['opening_day'];
      closing_day_m=res['closing_day'];
      if(opening_day_m!=null && closing_day_m!=null)
      {
        setState(() {
          opening_day=opening_day_m.toString();
          opening_day1=closing_day_m.toString();
        });
      }
      else
      {
        null;
      }

      about=res['about'];
      print("res"+res.toString());
      email.text=email_m.toString();
      contact_no.text=contact.toString();
      whatsapp_no.text=whatsapp.toString();
      bussiness_name.text=name_m.toString();
      website.text=website_m.toString();
      description.text=about.toString();
    });
    print(response);
  }


  TextEditingController bussiness_name=TextEditingController();
  TextEditingController contact_no=TextEditingController();
  TextEditingController whatsapp_no=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController website=TextEditingController();
  TextEditingController description=TextEditingController();

  // Future CreateMatrimoneyProfile() async {
  //   if (
  //       description.text.isNotEmpty) {
  //     EasyLoading.show(status: 'Please Wait...');
  //     var api = Uri.parse(
  //         "https://community.creditmywallet.in.net/api/add_business");
  //     final pref = await SharedPreferences.getInstance();
  //     String fileName2 = _image1.path.split('/').last;
  //     var get = pref.getString('user_id');
  //     print("sdgfgf " + get.toString());
  //     var dio = Dio();
  //     var formData = FormData.fromMap({
  //       'user_id': get.toString(),
  //       "profile_img": await MultipartFile.fromFile(_image.path,filename: fileName2),
  //       "category_id": Category.toString(),
  //       "sub_category_id": sub_Category.toString(),
  //       "business_name": bussiness_name.text.toString(),
  //       'opening_time': opening_time.toString(),
  //       'closing_time': opening_time1.toString(),
  //       'opening_day': opening_day.toString(),
  //       'closing_day': opening_day1.toString(),
  //       'website': website.text.toString(),
  //       "contact": contact_no.text.toString(),
  //       "whatsapp":whatsapp_no.text.toString(),
  //       "email": email.text.toString(),
  //       "city_id": district.toString(),
  //       "about": description.text.toString(),
  //       "gallery[]": img.map((item)=> MultipartFile.fromFileSync(item.path,
  //           filename: item.path.split('/').last)).toList(),
  //     });
  //     print(formData.fields.toString());
  //     var response = await dio.post('https://community.creditmywallet.in.net/api/add_business',data: formData);
  //     var res=response.data;
  //     var dio1 = Dio();
  //     var formData1 = FormData.fromMap({
  //       'user_id': get.toString(),
  //       "profile_img": await MultipartFile.fromFile(_image.path,filename: fileName2),
  //       "category_id": Category.toString(),
  //       "sub_category_id": sub_Category.toString(),
  //       "business_name": bussiness_name.text.toString(),
  //       'opening_time': opening_time.toString(),
  //       'closing_time': opening_time1.toString(),
  //       'opening_day': opening_day.toString(),
  //       'closing_day': opening_day1.toString(),
  //       'website': website.text.toString(),
  //       "contact": contact_no.text.toString(),
  //       "whatsapp":whatsapp_no.text.toString(),
  //       "email": email.text.toString(),
  //       "city_id": district.toString(),
  //       "about": description.text.toString(),
  //       "gallery[]": img.map((item)=> MultipartFile.fromFileSync(item.path,
  //           filename: item.path.split('/').last)).toList(),
  //     });
  //     print(formData.fields.toString());
  //     var response1 = await dio.post('https://community.creditmywallet.in.net/api/add_business',data: formData);
  //     var res1=response.data;
  //     var msg=res["status_message"];
  //     setState(() {
  //       print("%%%%%%%%%%%%%%%"+res1.toString());
  //     });
  //     try {
  //       if (response1.statusCode == 200) {
  //         if (msg == "Business Registered Successfully") {
  //           Fluttertoast.showToast(msg: msg);
  //
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) =>
  //                       HomePage(
  //                       )));
  //           EasyLoading.dismiss();
  //         }
  //       }
  //     } catch (e) {
  //       EasyLoading.dismiss();
  //     }
  //   }else {
  //     Fluttertoast.showToast(msg: "Blank Field Not Allow",
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.BOTTOM);
  //   }
  //
  // }


  @override
  void initState() {
    super.initState();
    setState(() {
      bussi_Category();
      bussi_Sub_Category();
      get_city();
      if("${widget.name}"=="Edit")
        {
          my_Bussiness_details();
          get_gallery();
        }
      else
        {

        }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F8FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffF4F8FB),
        leading:  IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        title: Text(
          "Business Registration",
          style: TextStyle(
              color: Color(0xff000000),
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              "${widget.name}"=="Add"?
              Container(
                child: Stack(
                  children: [
                    Container(
                      height: 81,
                      width: 81,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/businessreg.png"),
                          ),
                          //shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: isimageselected1 ? Image.file(_image1,fit: BoxFit.fill,) : Container(),
                    ),
                  Padding(
                        padding: EdgeInsets.only(left: 55, top: 50),
                        child: InkWell(
                          onTap:(){
                            camera();
                          },
                          child: Container(
                            height: 30, width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.red,
                                image: DecorationImage(
                                    image: AssetImage("assets/images/upload.png"))),
                          ),
                        )
                    ),
                  ],
                ),
              ):
              Container(
                child: Stack(
                  children: [
                    Container(
                      height: 81,
                      width: 81,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(p_img.toString()),
                            fit: BoxFit.fill
                          ),
                         // shape: BoxShape.circle
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: ClipRRect(
                        child: isimageselected1 ? Image.file(_image1,fit: BoxFit.fill,) : Container(color: Colors.red,),

                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 55, top: 50),
                        child: InkWell(
                          onTap:(){
                            camera();
                          },
                          child: Container(
                            height: 30, width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.red,
                                image: DecorationImage(
                                    image: AssetImage("assets/images/upload.png"))),
                          ),
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 21,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  color: Colors.brown[50],
                  child: Column(children: [
                    SizedBox(
                      height: 24,
                    ),
                    Form(
                        child: Column(
                          children: [
                            Text("Business Information",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                )),
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 37),
                                  child: Container(
                                    // width: Get.width * 0.9,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Category",
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
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .85,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        value: Category,
                                        hint: cat_name==null?Text("      Category"):Text("      "+cat_name.toString()),
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
                                  padding: EdgeInsets.only(left: 37),
                                  child: Container(
                                    // width: Get.width * 0.9,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Sub-Category",
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
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .85,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        value: sub_Category,
                                        hint: sub_cat_name==null?Text("      Sub-Category"):Text("      "+sub_cat_name.toString()),
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
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 37),
                                  child: Container(
                                    // width: Get.width * 0.9,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Business Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff989595),
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * .85,
                                  child: TextFormField(
                                    controller: bussiness_name,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(14.0),
                                      border: InputBorder.none,
                                      hintText: "Name",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff878383),
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 37),
                                  child: Container(
                                    // width: Get.width * 0.9,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Business Hour",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff989595),
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 3, bottom: 3),
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * .85,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        value: bussiness_time,
                                        hint: opening_time_mno==null?
                                        Text("      Bussiness Time"):Text("      "+opening_time_mno.toString()+" "+closing_time_m.toString()),
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Icon(Icons.arrow_drop_down),
                                        ),
                                        items: time1.map((item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Padding(
                                              padding:  EdgeInsets.only(left: 30),
                                              child: Text(
                                                item.toString(),
                                                style: TextStyle(color: Colors.black54),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            bussiness_time = newValue! as String?;
                                            //opening_time = bussiness_time!.split(' ');
                                            final bussi1=bussiness_time!.split(' ');
                                            opening_time =bussi1[0].toString();
                                            opening_time1 =bussi1[1].toString();
                                            print(opening_time);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 37),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Business Day",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff989595),
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3, bottom: 3),
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * .85,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: bussiness_day,
                                    hint: opening_day_m==null?
                                    Text("      Bussiness Day"):Text("      "+opening_day_m.toString()+" "+closing_day_m.toString()),
                                    icon: Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    items: bussiness.map((item) {
                                      return DropdownMenuItem(
                                        value: item.toString(),
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 30),
                                          child: Text(
                                            item.toString(),
                                            style: TextStyle(color: Colors.black54),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        bussiness_day = newValue! as String?;
                                        final bussi=bussiness_day!.split(' ');
                                        opening_day =bussi[0].toString();
                                        opening_day1 =bussi[1].toString();
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
                                  "Business Contact",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff989595),
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              height: 50,
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
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 37),
                              child: Container(
                                // width: Get.width * 0.9,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "WhatsApp Contact",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff989595),
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width * .85,
                              child: TextFormField(
                                 controller: whatsapp_no,
                                keyboardType: TextInputType.number,
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
                                  hintText: "WhatsApp No",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff878383),
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 37),
                              child: Container(
                                // width: Get.width * 0.9,
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Business Email",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff989595),
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width * .85,
                              child: TextFormField(
                                 controller: email,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(14.0),
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff878383),
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 37),
                              child: Container(
                                // width: Get.width * 0.9,
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Website",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff989595),
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width * .85,
                              child: TextFormField(
                                controller: website,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(14.0),
                                  border: InputBorder.none,
                                  hintText: "Website",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff878383),
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 37),
                              child: Container(
                                // width: Get.width * 0.9,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Business Location State",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff989595),
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3, bottom: 3),
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * .85,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: location,
                                    hint: state_name==null?Text("      State"):Text("        "+state_name.toString()),
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
                                // width: Get.width * 0.9,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Business Location District",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff989595),
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3, bottom: 3),
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * .85,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: district,
                                    hint: distic_name==null?Text("      District"):Text("     "+distic_name.toString()),
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
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 37),
                              child: Container(
                                // width: Get.width * 0.9,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Business Description",
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
                                maxLines: 20,
                                controller: description,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(14.0),
                                    border: InputBorder.none,
                                    hintText: 'Describe Yourself......'),
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 20.89,
                    ),

                    // "${widget.name}"=="Add"?
                    // Column(
                    //   children:<Widget> [
                    //     Container(
                    //         width: MediaQuery.of(context).size.width * 0.85,
                    //         height: 79,
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             InkWell(
                    //               onTap: (){
                    //                 camera1();
                    //               },
                    //               child : Container(
                    //                 height: 78.22,
                    //                 width: 78.22,
                    //                 decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(15)),
                    //                 child: Card(
                    //                   child: Icon(
                    //                     Icons.add,
                    //                     size: 50,
                    //                   ),
                    //                   shape: RoundedRectangleBorder(
                    //                       borderRadius: BorderRadius.circular(15)),
                    //                 ),
                    //               ),
                    //             ),
                    //             Expanded(
                    //               child: ListView.builder(
                    //                 itemCount: img.length,
                    //                 scrollDirection: Axis.horizontal,
                    //                 itemBuilder: (context, index) =>
                    //                     Stack(
                    //                         children: <Widget>[
                    //                           InkWell(
                    //                             onTap: (){
                    //                             },
                    //                             child:Container(
                    //                                 height: 78.22, width: 78.22,
                    //                                 margin: EdgeInsets.all(5),
                    //                                 decoration: BoxDecoration(
                    //                                   borderRadius: BorderRadius.circular(13),
                    //                                   color: Colors.black54,
                    //                                 ),
                    //                                 child:ClipRRect(
                    //                                   borderRadius: BorderRadius.circular(13),
                    //                                   child: SizedBox.fromSize(
                    //                                     child:
                    //                                     isimageselected
                    //                                         ? Image.file(File(img[index].path),fit: BoxFit.fill,)
                    //                                         :Container(),
                    //                                   ),
                    //                                 )
                    //
                    //                             ),
                    //                           ),
                    //                           Positioned(
                    //                               right: 3,
                    //                               top: 2,
                    //                               child: Container(
                    //                                 height:30,
                    //                                 width: 30,
                    //                                 decoration: BoxDecoration(
                    //                                   color: Colors.white60,
                    //                                   shape: BoxShape.circle,
                    //                                 ),
                    //                                 child: IconButton(
                    //                                     onPressed: (){
                    //                                       setState(() {
                    //                                         img.removeAt(index);
                    //                                       });
                    //                                       setState(() {
                    //                                         img.isEmpty?  isVisible=false:null;
                    //                                       });
                    //                                     },
                    //                                     icon:Icon(Icons.clear,
                    //                                       color: Colors.black,size:18,) ),
                    //
                    //                               )
                    //                           ),
                    //                         ]
                    //                     ),
                    //               ),
                    //             )
                    //           ],
                    //         )
                    //     ),
                    //   ],
                    // ):
                    // Column(
                    //   children:<Widget> [
                    //     Container(
                    //         width: MediaQuery.of(context).size.width * 0.85,
                    //         height: 79,
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             InkWell(
                    //               onTap: (){
                    //                 camera1();
                    //               },
                    //               child : Container(
                    //                 height: 78.22,
                    //                 width: 78.22,
                    //                 decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(15)),
                    //                 child: Card(
                    //                   child: Icon(
                    //                     Icons.add,
                    //                     size: 50,
                    //                   ),
                    //                   shape: RoundedRectangleBorder(
                    //                       borderRadius: BorderRadius.circular(15)),
                    //                 ),
                    //               ),
                    //             ),
                    //             Expanded(
                    //               child: ListView.builder(
                    //                 itemCount: gallery.length,
                    //                 scrollDirection: Axis.horizontal,
                    //                 itemBuilder: (context, index) =>
                    //                     Stack(
                    //                         children: <Widget>[
                    //                           InkWell(
                    //                             onTap: (){
                    //                             },
                    //                             child:Container(
                    //                                 height: 78.22, width: 78.22,
                    //                                 margin: EdgeInsets.all(5),
                    //                                 decoration: BoxDecoration(
                    //                                   borderRadius: BorderRadius.circular(13),
                    //                                   color: Colors.black54,
                    //                                 ),
                    //                                 child:ClipRRect(
                    //                                   borderRadius: BorderRadius.circular(13),
                    //                                   child: SizedBox.fromSize(
                    //                                     child: Image.network(gallery[index].toString(),fit: BoxFit.fill,)
                    //                                   ),
                    //                                 )
                    //                             ),
                    //                           ),
                    //                           Positioned(
                    //                               right: 3,
                    //                               top: 2,
                    //                               child: Container(
                    //                                 height:30,
                    //                                 width: 30,
                    //                                 decoration: BoxDecoration(
                    //                                   color: Colors.white60,
                    //                                   shape: BoxShape.circle,
                    //                                 ),
                    //                                 child: IconButton(
                    //                                     onPressed: (){
                    //                                       setState(() {
                    //                                         gallery[index].removeAt(index);
                    //                                       });
                    //                                       setState(() {
                    //                                         gallery.isEmpty?  isVisible=false:null;
                    //                                       });
                    //                                     },
                    //                                     icon:Icon(Icons.clear,
                    //                                       color: Colors.black,size:18,) ),
                    //
                    //                               )
                    //                           ),
                    //                         ]
                    //                     ),
                    //               ),
                    //             )
                    //           ],
                    //         )
                    //     ),
                    //   ],
                    // ),
                    Column(
                      children:<Widget> [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: 79,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: (){
                                    camera1();
                                  },
                                  child : Container(
                                    height: 78.22, width: 78.22,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Card(
                                      child: Icon(
                                        Icons.add,
                                        size: 50,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: img.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        Stack(
                                            children: <Widget>[
                                              InkWell(
                                                onTap: (){
                                                },
                                                child:Container(
                                                    height: 78.22, width: 78.22,
                                                    margin: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(13),
                                                      color: Colors.black54,
                                                    ),
                                                    child:ClipRRect(
                                                      borderRadius: BorderRadius.circular(13),
                                                      child: SizedBox.fromSize(
                                                        child:
                                                        isimageselected
                                                            ? Image.file(File(img[index].path),fit: BoxFit.fill,)
                                                            :Container(),
                                                      ),
                                                    )

                                                ),
                                              ),
                                              Positioned(
                                                  right: 3,
                                                  top: 2,
                                                  child: Container(
                                                    height:30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white60,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: IconButton(
                                                        onPressed: (){
                                                          setState(() {
                                                            img.removeAt(index);
                                                          });
                                                          setState(() {
                                                            img.isEmpty?  isVisible=false:null;
                                                          });
                                                        },
                                                        icon:Icon(Icons.clear,
                                                          color: Colors.black,size:18,) ),

                                                  )
                                              ),
                                            ]
                                        ),
                                  ),
                                )
                              ],
                            )
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 19,
                    ),
                   Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.88,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              colors: [
                                Colors.blue,
                                Colors.white,
                              ],
                            )
                        ),
                     child: MaterialButton(
                       onPressed: () async{
                         if("${widget.name}"=="Add")
                           {
                             if(Category!=null && sub_Category!=null && bussiness_name.text.isNotEmpty && opening_time!=null
                                 && opening_time1!=null && opening_day!=null && opening_day1!=null && website.text.isNotEmpty && contact_no.text.isNotEmpty &&
                                 whatsapp_no.text.isNotEmpty && email.text.isNotEmpty && district!=null && description.text.isNotEmpty)
                             {
                               final pref=await SharedPreferences.getInstance();
                               var user_id=pref.getString('user_id');
                               String fileName2 = _image1.path.split('/').last;
                               var dio= Dio();
                               var business_id;
                               var formData = FormData.fromMap({
                                 'user_id': user_id.toString(),
                                 "profile_img": await MultipartFile.fromFile(_image1.path,filename: fileName2),
                                 "category_id": Category.toString(),
                                 "sub_category_id": sub_Category.toString(),
                                 "business_name": bussiness_name.text.toString(),
                                 'opening_time': opening_time.toString(),
                                 'closing_time': opening_time1.toString(),
                                 'opening_day': opening_day.toString(),
                                 'closing_day': opening_day1.toString(),
                                 'website': website.text.toString(),
                                 "contact": contact_no.text.toString(),
                                 "whatsapp":whatsapp_no.text.toString(),
                                 "email": email.text.toString(),
                                 "city_id": district.toString(),
                                 "about": description.text.toString(),
                                 "gallery[]": img.map((item)=> MultipartFile.fromFileSync(item.path,
                                     filename: item.path.split('/').last)).toList(),
                               });
                               print(formData.fields.toString());
                               var response = await dio.post('https://community.creditmywallet.in.net/api/add_business',data: formData);
                               var res=response.data;
                               setState(() {
                                 print(business_id.toString());
                                 business_id = res['business_id'];
                               });
                               var msg=res["status_message"];
                               setState(() {
                                 print(res.toString());

                               });
                               if(res["status_message"]=="Business Registered Successfully")
                               {
                                 setState(() {
                                   Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                       gravity: ToastGravity.BOTTOM);
                                   Navigator.pushReplacement(context, MaterialPageRoute(builder:
                                       (context) => BusinessList()));
                                 });
                               }
                               else
                               {
                                 setState(() {
                                   Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                       gravity: ToastGravity.BOTTOM);
                                 });
                               }
                             }
                             else
                             {
                               Fluttertoast.showToast(msg: "Blank Field Not Allow",toastLength: Toast.LENGTH_LONG,
                                   gravity: ToastGravity.BOTTOM);
                             }
                           }
                         else
                           {
                             final pref=await SharedPreferences.getInstance();
                             var user_id=pref.getString('user_id');
                             String fileName = _image.path.split('/').last;
                             var dio= Dio();
                             var formData = FormData.fromMap({
                               'business_id':"${widget.bussiness_id}",
                               'user_id': user_id.toString(),
                               "profile_img":await MultipartFile.fromFile(_image.path,filename: fileName),
                               "category_id": Category,
                               "sub_category_id": sub_Category,
                               "business_name": bussiness_name.text.toString(),
                               'opening_time': opening_time,
                               'closing_time': opening_time1,
                               'opening_day': opening_day,
                               'closing_day': opening_day1,
                               'website': website.text.toString(),
                               "contact": contact_no.text.toString(),
                               "whatsapp":whatsapp_no.text.toString(),
                               "email": email.text.toString(),
                               "city_id": district.toString(),
                               "about": description.text.toString(),
                               "gallery[]": img.length!=0?img.map((item)=> MultipartFile.fromFileSync(item.path,
                                   filename: item.path.split('/').last)).toList():"",
                             });
                             print(formData.fields.toString());
                             var response = await dio.post('https://community.creditmywallet.in.net/api/edit_business',data: formData);
                             var res=response.data;
                             setState(() {
                               print(response.toString());
                             });
                             var msg=res["status_message"];
                             setState(() {
                               print(res.toString());
                             });
                             if(res["status_message"]=="Business Updated Successfully")
                             {
                               setState(() {
                                 Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                     gravity: ToastGravity.BOTTOM);
                                 Navigator.pushReplacement(context, MaterialPageRoute(builder:
                                     (context) => BusinessList()));
                               });
                             }
                             else
                             {
                               setState(() {
                                 Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                     gravity: ToastGravity.BOTTOM);
                               });
                             }
                           }
                         // CreateMatrimoneyProfile();

                       },
                       child: Text(
                         "Save",
                         style: TextStyle(
                             fontWeight: FontWeight.w700,
                             fontSize: 14,
                             color: Colors.white),
                       ),
                     ),
                      ),

                    SizedBox(
                      height: 94,
                    )
                  ]
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }




  void camera() {
    Widget onPostiveButton=TextButton(
      onPressed: ()async{

        final image=await ImagePicker().pickImage(source: ImageSource.camera);
        if(image==null)return;
        {
          setState(() {
            isimageselected1=true;
            _image1=File(image.path);
          });
        }
        Navigator.of(context).pop();
      },
      child: Text("Camera",style: TextStyle(
          fontSize: 17,
          fontFamily: 'SairaCondensed',
          fontWeight: FontWeight.bold,
          color: Colors.green),),
    );
    Widget onNegativeButton=TextButton(
      onPressed: ()
      async{
        final image=await ImagePicker().getImage(source: ImageSource.gallery);
        if(image==null)return;
        {
          setState(() {
            isimageselected1=true;
            _image1=File(image.path);
          });
        }
        Navigator.pop(context);
      },
      child: Text("Gallery",style: TextStyle(
          fontSize: 16,
          fontFamily: 'SairaCondensed',
          fontWeight: FontWeight.bold,
          color: Colors.green),),
    );
    AlertDialog dialog=AlertDialog(
      actions: [onNegativeButton,onPostiveButton],
      title: Text("Select From :"),
    );
    showDialog(context: context, builder: (BuildContext context)
    {
      return dialog;
    });
  }


  void camera1() {
    Widget onPostiveButton = TextButton(
      onPressed: () async {
        final image = await ImagePicker().pickImage(source: ImageSource.camera);
        if (image == null) return;
        {
          setState(() {
            isimageselected = true;
            _image = File(image.path);
            img.add(image);
            isVisible = !isVisible;
            isVisible=true;
          });
        }
        Navigator.pop(context);
      },
      child: Text(
        "Camera",
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.green),
      ),
    );
    Widget onNegativeButton = TextButton(
      onPressed: () async {
        final List<XFile>? image = await ImagePicker().pickMultiImage();
        if (image == null) return;
        {
          setState(() {
            isimageselected = true;
            img.addAll(image);
            isVisible = !isVisible;
            isVisible=true;
          });
        }
        Navigator.pop(context);
      },
      child: Text(
        "Gallery",
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.green),
      ),
    );
    AlertDialog dialog = new AlertDialog(
      actions: [onNegativeButton, onPostiveButton],
      title: Text("Select From :"),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }
}
