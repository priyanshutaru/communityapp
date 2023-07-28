import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:communityapp/screens/Job/job_search_dream.dart';
import 'package:communityapp/screens/Job/job_search_result.dart';
import 'package:communityapp/screens/Job/no_of_job_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobDetaile extends StatefulWidget {
  const JobDetaile({Key? key}) : super(key: key);

  @override
  State<JobDetaile> createState() => _JobDetaileState();
}

class _JobDetaileState extends State<JobDetaile> {

  String dropdownvalue2 = 'Clearical';
  var items2 = [
    'Clearical',
    'Technical'
  ];
  TextEditingController company_name=TextEditingController();
  TextEditingController company_email=TextEditingController();
  TextEditingController job_location=TextEditingController();
  TextEditingController hr_mobile=TextEditingController();
  TextEditingController job_position=TextEditingController();
  TextEditingController no_of_vacancies=TextEditingController();
  TextEditingController experiances=TextEditingController();



  late File _image1;
  bool isimageselected1=false;



  String? qualifications;
  String? job_posit;


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



  List job_position1=[];
  Future  get_job_position() async{
    var url="https://community.creditmywallet.in.net/api/get_position";
    http.Response response=await http.get(Uri.parse(url),headers: {"Content-Type":"application/json"});
    var res=jsonDecode(response.body)['data'];
    setState(() {
      print("%%%%%FFFFFFFFFFFf%%%%%%%"+res.toString());
      job_position1=res;
      print(job_position1.toString()+"%%%%%%%%%%%%%%%%");
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

  @override
  void initState() {
    super.initState();
    setState(() {
      get_job_position();
      get_city();
      bussi_Category();
      get_Qualifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEEEEEE),
        leading:  IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color:Colors.black),
        ),
        elevation: 0,
        toolbarHeight: 70,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        title: Text(
          "Post a New Job Requirenment",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff000000)),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
             /* Stack(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: GestureDetector(
                        onTap: () {},
                        child: const Image(
                            image: AssetImage("assets/images/job.png"))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, left: 50),
                    child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Image(
                            image: AssetImage("assets/images/upload.png"))),
                  ),
                ],
              ),*/
              Container(
                child: Stack(
                  children: [
                    Container(
                      height: 81,
                      width: 81,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/job.png"),
                          ),
                          shape: BoxShape.circle
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
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  color: Color.fromARGB(255, 233, 229, 227),
                  child: Column(children: [
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Form(
                          child: Column(
                            children: [
                              Text("Job Details",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )),
                              SizedBox(
                                height: 18,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: const [
                                        Text(
                                          "Company Name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    height: 45,
                                    width: MediaQuery.of(context).size.width * .90,
                                    child: TextFormField(
                                      controller: company_name,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(14.0),
                                        border: InputBorder.none,
                                        hintText: "Company Name",
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
                                    padding: EdgeInsets.only(left: 15),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Company/HR Email ID",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.black45),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,),
                                    height: 45,
                                    width: MediaQuery.of(context).size.width * .90,
                                    child: TextFormField(
                                      controller: company_email,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(14.0),
                                        border: InputBorder.none,
                                        hintText: "Company Email",
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
                                    padding: EdgeInsets.only(left: 20),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Category",
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
                                      width: MediaQuery.of(context).size.width * .9,
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
                                                get_job_position();
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
                                    padding: EdgeInsets.only(left: 20 ),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Sub-Category",
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
                                      width: MediaQuery.of(context).size.width * .9,
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
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Clearical/Technical",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.black45),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width * .9,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        value: dropdownvalue2,
                                        icon: const Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20),
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                        ),
                                        items: items2.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(left: 10),
                                                child: Text(
                                                  items,
                                                  style:
                                                  TextStyle(
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownvalue2 = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 11,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
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
                                      width: MediaQuery.of(context).size.width * .90,
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
                                    padding: EdgeInsets.only(left: 15),
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
                                      width: MediaQuery.of(context).size.width * .90,
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
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: const [
                                        Text(
                                          "HR/Employer Mobile Number",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    height: 45,
                                    width: MediaQuery.of(context).size.width * .90,
                                    child: TextFormField(
                                      controller: hr_mobile,
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
                                        hintText: "Mobile Number",
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
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: const [
                                        Text(
                                          "Job Position",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                  ),
                                 /* Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    height: 45,
                                    width: MediaQuery.of(context).size.width * .90,
                                    child: TextFormField(
                                      controller: job_position,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(14.0),
                                        border: InputBorder.none,
                                        hintText: "Native Anroid App Devloper",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff878383),
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),*/
                                  Padding(
                                    padding: EdgeInsets.only(top: 3, bottom: 3),
                                    child: Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width * .9,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Colors.white),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          value: job_posit,
                                          hint: Text("      Job Position"),
                                          icon: Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(Icons.arrow_drop_down),
                                          ),
                                          items: job_position1.map((item) {
                                            return DropdownMenuItem(
                                              value: item['position_id'].toString(),
                                              child: Padding(
                                                padding:  EdgeInsets.only(left: 30),
                                                child: Text(
                                                  item['position_name'].toString(),
                                                  style: TextStyle(color: Colors.black54),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              job_posit = newValue! as String?;
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
                                    padding: EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          "No.of Vacancies",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    height: 45,
                                    width: MediaQuery.of(context).size.width * .90,
                                    child: TextFormField(
                                      controller: no_of_vacancies,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(2),
                                      ],
                                      validator: (val) {
                                        if (val! == null &&
                                            val.isEmpty &&
                                            val.length == 2) {
                                          Fluttertoast.showToast(
                                              msg: "Please enter 2 digit No of Vacncies");
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(14.0),
                                        border: InputBorder.none,
                                        hintText: "",
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
                                    padding: EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: const [
                                        Text(
                                          "Required Exp",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    height: 45,
                                    width: MediaQuery.of(context).size.width * .90,
                                    child: TextFormField(
                                      controller: experiances,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(14.0),
                                        border: InputBorder.none,
                                        hintText: "2.5 years",
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
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: const [
                                        Text(
                                          "Qualification",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 3, bottom: 3),
                                    child: Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width * .90,
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
                                  SizedBox(
                                    height: 11,
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 20,
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
                          child: ElevatedButton(
                            onPressed: () async{
                              if(_image1.toString().isNotEmpty && company_name.text.isNotEmpty && company_email.text.isNotEmpty &&
                              hr_mobile.text.isNotEmpty && no_of_vacancies.text.isNotEmpty && experiances.text.isNotEmpty)
                                {
                                  final pref=await SharedPreferences.getInstance();
                                  var get=pref.getString('user_id');
                                  String fileName2 = _image1.path.split('/').last;
                                  var dio1 = Dio();
                                  var formData = FormData.fromMap({
                                    'user_id': get.toString(),
                                    "company_name":company_name.text.toString(),
                                    'category_id':Category,
                                    'sub_category_id':sub_Category,
                                    'comapny_email': company_email.text.toString(),
                                    'city_id':district,
                                    'job_postion': job_posit,
                                    'hr_mobile':hr_mobile.text.toString(),
                                    'job_position':job_position.text.toString(),
                                    'no_of_vacancy':no_of_vacancies.text.toString(),
                                    'required_exp':experiances.text.toString(),
                                    'qualification':qualifications,
                                    'img':await MultipartFile.fromFile(_image1.path,filename: fileName2),

                                  });
                                  print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                  var response = await dio1.post('https://community.creditmywallet.in.net/api/add_jobs'
                                      ,data: formData);
                                  var res=response.data;
                                  var msg=res["status_message"];
                                  setState(() {
                                    print("%%%%%%%%%%%%%%%"+res.toString());
                                  });
                                  if(res["status_message"]=="Job Posted Successfully")
                                  {
                                    Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM);
                                    Navigator.pushReplacement(context, MaterialPageRoute(
                                        builder: (context)=>ForumJobList()));
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
                            child: Text(
                              "Post Now",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          )
                    ),
                    Container(
                      height: 30,
                    )
                  ]),
                ),
              ),
            ],
          )),
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
            print(_image1.toString());
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
}
