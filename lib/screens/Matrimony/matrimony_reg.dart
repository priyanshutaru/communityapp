import 'dart:convert';
import 'dart:io';
import 'package:communityapp/screens/Matrimony/subscription_plan.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../home_page.dart';

class MatrimonyRegistration extends StatefulWidget {
  const MatrimonyRegistration({Key? key}) : super(key: key);

  @override
  State<MatrimonyRegistration> createState() => _MatrimonyRegistrationState();
}

class _MatrimonyRegistrationState extends State<MatrimonyRegistration> {
  // Initial Selected Value
  String lookinfor = 'I am Looking for';
  String skin_tone = 'Skin Tone';
  String profession = 'Profession';
  String sun_sign = 'Sun Sign';
  String moon_sign = 'Moon Sign';
  int? gender;
  // List of items in our dropdown menu
  var items = [
    'I am Looking for',
    'Bride',
    'Groom',
  ];
  var items2 = [
    'Skin Tone',
    'Honey',
    'Sand',
    'Warm Ivory',
    'Natural',
    'Chestnot',
    'Ivory',
    'Warm Beige',
    'Almond',
    'Porclain',
    'Godlen',
    'Beige',
  ];
  var items3 = [
    'Profession',
    'Clearical',
    'Technical',
  ];
  var items5 = [
    'Sun Sign',
    'Capricorn',
    'Aquarius',
    'Pisces',
    'Aries',
    'Taurus',
    'Gemini',
    'Cancer',
    'Leo',
    'Vigro',
    'Libra',
    'Scorpio',
    'Sagittarius',
  ];
  var items6 = [
    'Moon Sign',
    'Capricorn',
    'Aquarius',
    'Pisces',
    'Aries',
    'Taurus',
    'Gemini',
    'Cancer',
    'Leo',
    'Vigro',
    'Libra',
    'Scorpio',
    'Sagittarius',
  ];


  TextEditingController name=TextEditingController();
  TextEditingController mobile=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController height1=TextEditingController();


  String? dob;
  String? time;
  late DateTime _myDateTime;
  late TimeOfDay newtime;
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
  String msg= '';
  String? qualifications;
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
  List get_district_list=[];
  Future  get_District() async{
    Map data={
      "state_id":location.toString(),
    };
    var url="https://community.creditmywallet.in.net/api/get_dist";
    var body1=jsonEncode(data);
    http.Response response=await http.post(Uri.parse(url),
        headers: {"Content-Type":"application/json"}, body: body1);
    var res=jsonDecode(response.body)['state'];
    setState(() {
      print("%%%%%FFFFFFFFFFFf%%%%%%%"+res.toString());
      get_district_list=res;
      print(get_district_list.toString()+"%%%%%%%%%%%%%%%%");
    });

  }

  Future CreateMatrimoneyProfile() async {
    if ( _image1 != null && name.text.isNotEmpty && mobile.text.isNotEmpty &&
        description.text.isNotEmpty) {
      EasyLoading.show(status: 'Please Wait...');
      var api = Uri.parse(
          "https://community.creditmywallet.in.net/api/add_matrimony");
      final pref = await SharedPreferences.getInstance();
      String fileName2 = _image1.path.split('/').last;
      var get = pref.getString('user_id');
      print("sdgfgf " + get.toString());
      Map mapeddate = {
        'user_id': get.toString(),
        "name": name.text.toString(),
        "looking_for": gender.toString(),
        "profession": profession.toString(),
        "mobile": mobile.text.toString(),
        "education": qualifications.toString(),
        "profile": await MultipartFile.fromFile(_image1.path,filename: fileName2),
        "dob": dob.toString(),
        'gender': gender.toString(),
        "birth_time": time.toString(),
        "sun_sign": sun_sign.toString(),
        'moon_sign': moon_sign.toString(),
        "height": height1.text.toString(),
        "skin_tone": skin_tone.toString(),
        "about": description.text.toString(),
        "address": district.toString(),
        'gallery[]': img.map((item) =>MultipartFile.fromFileSync(item.path,filename: item.path.split('/').last)).toList(),
      };
      // final response = await http.post(
      //   api,
      //   body: mapeddate,
      // );
      // var res = await json.decode(response.body);
      // msg = res['status_message'].toString();
      var dio = Dio();
      var formData = FormData.fromMap({
        'user_id': get.toString(),
        "name": name.text.toString(),
        "looking_for": gender.toString(),
        "profession": profession.toString(),
        "mobile": mobile.text.toString(),
        "education": qualifications.toString(),
        "profile": await MultipartFile.fromFile(_image1.path,filename: fileName2),
        "dob": dob.toString(),
        'gender': gender.toString(),
        "birth_time": time.toString(),
        "sun_sign": sun_sign.toString(),
        'moon_sign': moon_sign.toString(),
        "height": height1.text.toString(),
        "skin_tone": skin_tone.toString(),
        "about": description.text.toString(),
        "address": district.toString(),
        'gallery[]': img.map((item) =>MultipartFile.fromFileSync(item.path,filename: item.path.split('/').last)).toList(),

      });
      print(img.length);
      print(formData.fields.toString()+"^^^^^^^^^^^^^^");
      var response = await dio.post('https://community.creditmywallet.in.net/api/add_matrimony',data: formData);
      var res=response.data;
      var msg=res["status_message"];
      setState(() {
        print("%%%%%%%%%%%%%%%"+res.toString());
      });
      try {
        if (response.statusCode == 200) {
          if (msg == "Profile Uploaded Successfuly") {
            Fluttertoast.showToast(msg: msg);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomePage(
                        )));
            EasyLoading.dismiss();
          }
        }
      } catch (e) {
        EasyLoading.dismiss();
      }
    }else {
          Fluttertoast.showToast(msg: "Blank Field Not Allow",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM);
        }

  }



  late File _image;
  late File _image1;
  List<XFile> img = [];
  bool isimageselected=false;
  bool isimageselected1=false;
  @override
  void initState() {
    super.initState();
    setState(() {
      get_Qualifications();
      get_city();
      get_District();
      CreateMatrimoneyProfile();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        title: Text(
          "    Metrimony Registration",
          style: TextStyle(
              color: Color(0xff000000),
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    Container(
                      height: 81,
                      width: 81,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/man5.png"),
                          ),
                          shape: BoxShape.circle
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                   child: isimageselected1 ? Image.file(_image1,fit: BoxFit.fill,) : Container(),

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
                                image: const DecorationImage(
                                    image: AssetImage("assets/images/upload.png"))),
                          ),
                        )
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 21.36,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  color: Color(0xffEEEEEE),
                  child: Column(children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Form(
                      child:
                      Column(
                        children: [
                          Text("Personal Information",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Color(0xff000000))),
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 37),
                                child: Container(
                                  // width: Get.width * 0.9,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "I'm looking for?",
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
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      value: lookinfor,
                                      icon: Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 20,),
                                              Text(items,
                                                style: const TextStyle(
                                                    color: Colors.black54),),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          lookinfor = newValue!;
                                          if(lookinfor=="Bride")
                                            {
                                              setState(() {
                                                gender=0;
                                              });
                                            }
                                          else if(lookinfor=="Groom")
                                          {
                                            setState(() {
                                              gender=1;
                                            });
                                          }
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
                                  child: const Text(
                                    "Name",
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
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                height: 50,
                                width: MediaQuery.of(context).size.width * .85,
                                child: TextFormField(
                                  controller: name,
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
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 37),
                                child: Container(
                                  // width: Get.width * 0.9,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Select State",
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
                                  // width: Get.width * 0.9,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Select District",
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
                                  // width: Get.width * 0.9,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Mobile Number",
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
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                height: 50,
                                width: MediaQuery.of(context).size.width * .85,
                                child: TextFormField(
                                  controller: mobile,
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
                                  keyboardType: TextInputType.number,
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
                            ],
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 37),
                            child: Container(
                              // width: Get.width * 0.9,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Height Fit",
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            height: 50,
                            width: MediaQuery.of(context).size.width * .85,
                            child: TextFormField(
                              controller: height1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                              ],
                              validator: (val) {
                                if (val! == null &&
                                    val.isEmpty &&
                                    val.length == 3) {
                                  Fluttertoast.showToast(
                                      msg: "Please Enter Height");
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(14.0),
                                border: InputBorder.none,
                                hintText: "6.4",
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
                                "Skin tone",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff989595),
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * .85,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: skin_tone,
                                  icon: const Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                  items: items2.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            items,
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      skin_tone = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 37),
                            child: Container(
                              // width: Get.width * 0.9,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Profession",
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
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * .85,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: profession,
                                  icon: const Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                  items: items3.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            items,
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      profession = newValue!;
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
                              width: MediaQuery.of(context).size.width * 0.85,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Qualification",
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
                          Padding(
                            padding: const EdgeInsets.only(left: 37),
                            child: Container(
                              // width: Get.width * 0.9,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "DOB",
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
                                  height: 50,
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
                                      Text("Select DOB"),
                                    ],
                                  )
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 37),
                            child: Container(
                              // width: Get.width * 0.9,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Birth Time",
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
                          InkWell(
                            onTap: () async{
                              await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now()).then((pickeTime) {
                                    if(pickeTime==null) return;
                                    setState(() {
                                      DateTime parsedTime=DateFormat.jm().parse(pickeTime.format(context).toString());
                                      time=DateFormat('HH:mm').format(parsedTime);

                                    });
                              });

                            },
                            child: Padding(
                              padding:  EdgeInsets.only(top: 3, bottom: 3),
                              child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * .85,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      time!=null?
                                      Text(time.toString()):
                                      Text("Select Time"),
                                    ],
                                  )
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
                                "Sun Sign",
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
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: sun_sign,
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                  items: items5.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            items,
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      sun_sign = newValue!;
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
                              // width: Get.width * 0.9,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Moon Sign",
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
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: moon_sign,
                                  icon: const Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                  items: items6.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            items,
                                            style: const TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      moon_sign = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 11,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 37),
                            child: Container(
                              // width: Get.width * 0.9,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "Write about ypurself",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff989595),
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: TextFormField(
                              controller: description,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(14.0),
                                border: InputBorder.none,
                                hintText: "Describe Yourself..........",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff878383),
                                    fontSize: 14),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 31.89,
                    ),



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
                      height: 17,
                    ),
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width * 0.85,
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
                        highlightColor: Colors.greenAccent,
                        onPressed: () async{
                          CreateMatrimoneyProfile();
                        //   if( name.text.isNotEmpty && mobile.text.isNotEmpty && description.text.isNotEmpty) {
                        //     final pref = await SharedPreferences.getInstance();
                        //     var get = pref.getString('user_id');
                        //     // String fileName2 = _image1.path.split('/').last;
                        //     var dio1 = Dio();
                        //     var formData = FormData.fromMap({
                        //       'user_id': get.toString(),
                        //       "name": name.text.toString(),
                        //       "looking_for": gender.toString(),
                        //       "profession": profession.toString(),
                        //       "mobile": mobile.text.toString(),
                        //       "education": qualifications.toString(),
                        //       // "profile": await MultipartFile.fromFile(_image1.path, filename: fileName2),
                        //       "dob": dob.toString(),
                        //       'gender': gender.toString(),
                        //       "birth_time": time.toString(),
                        //       "sun_sign": sun_sign.toString(),
                        //       'moon_sign': moon_sign.toString(),
                        //       "height": height1.text.toString(),
                        //       "skin_tone": skin_tone.toString(),
                        //       "about": description.text.toString(),
                        //       "address": district.toString(),
                        //       // 'gallery[]': img.map((item) =>MultipartFile.fromFileSync(item.path,filename: item.path.split('/').last)).toList(),
                        //     });
                        //     // print(img.length);
                        //     // print(formData.fields.toString() + "^^^^^^^^^^^^^^");
                        //     var response = await dio1.post('https://community.creditmywallet.in.net/api/add_matrimony', data: formData);
                        //     var res = jsonDecode(response.data);
                        //     var msg = res["status_message"].toString();
                        //     setState(() {
                        //       print("%%%%%%%%%%%%%%%" + res.toString());
                        //     });
                        //     if ( msg == "Profile Uploaded Successfuly") {
                        //       Fluttertoast.showToast(msg: "Profile Created",
                        //           toastLength: Toast.LENGTH_LONG,
                        //           gravity: ToastGravity.BOTTOM);
                        //       Navigator.pushReplacement(context, MaterialPageRoute(
                        //           builder: (context) => HomePage()));
                        //     }
                        //     else {
                        //       Fluttertoast.showToast(msg: "Check your Internet",
                        //           toastLength: Toast.LENGTH_LONG,
                        //           gravity: ToastGravity.BOTTOM);
                        //     }
                        //   }
                        //   else {
                        //     Fluttertoast.showToast(msg: "Blank Field Not Allow",
                        //         toastLength: Toast.LENGTH_LONG,
                        //         gravity: ToastGravity.BOTTOM);
                        //   }
                        //
                        },
                        child: Text("Save",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.white),),
                      ),
                    ),
                    SizedBox(
                      height: 29,
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

 String ?subs_id;
  void camera() {
    Widget onPostiveButton=TextButton(
      onPressed: ()async{
        final image=await ImagePicker().pickImage(source: ImageSource.camera);
        if(image == null)return;
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
    Widget onNegativeButton= TextButton(
      onPressed: ()
      async{
        final image=await ImagePicker().getImage(source: ImageSource.gallery);
        if(image ==null)return;
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

