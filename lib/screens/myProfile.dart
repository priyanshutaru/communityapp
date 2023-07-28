import 'dart:convert';
import 'dart:io';
import 'package:card_loading/card_loading.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/dashboard.dart';
import 'package:communityapp/screens/my_favroite_profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
   MyProfile({Key? key,this.id}) : super(key: key);
  String? id;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  String? img;
  String? name;
  String? mobile_no;
  String? email;
  String? location;
  String? gender;
  String? category;
  String? shakha;
  String? native;
  String? bio;
  String? middle_name;
  String? gender1;
  int? age;
  String? is_call;
  String? what;
  String? what1;
  bool _enable = false;
  bool _enable1 = false;
  bool _enable3 = true;
  bool _enable4 = true;
  List allimage=[];

  bool isimageselected1=false;
  late File _image1;
  Future can_call() async{
    final pref=await SharedPreferences.getInstance();
    var get=pref.getString('user_id');
    Map data={
      'user_id':get.toString(),
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/can_call");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    setState(() {
      print(url.toString());
    });
    var res=json.decode(response.body);
    setState(() {
      print(res.toString());
    });
  }
  Future can_whats() async{
    final pref=await SharedPreferences.getInstance();
    var get=pref.getString('user_id');

    Map data={
      'user_id':get.toString()
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/can_whatsapp");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    setState(() {
      print(url.toString());
    });
    var res=json.decode(response.body);
  }


  String? sks_membership,prfession;

  Future get_user_profile() async{
    final pref=await SharedPreferences.getInstance();
    var get=pref.getString('user_id');
    Map data={
      'user_id':get.toString(),
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_user_prof");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    setState(() {
      print(url.toString());
    });
    var res=json.decode(response.body);
    setState(() {
      img=res['basic_details']['profile_img'];
      name=res['basic_details']['first_name'];
      middle_name=res['basic_details']['last_name'];
      is_call=res['basic_details']['can_call'];
      what=res['basic_details']['can_whats'];
      mobile_no=res['basic_details']['mobile'];
      email=res['basic_details']['email'];
      gender =res['basic_details']['gender'];
      shakha=res['current_shakha']['shakha_name'];
      native=res['native_shakha']['shakha_name'];
      location=res['distric'];
      age=res['turning'];
      prfession=res['profession_name'];
      sks_membership=res['personal_details']['user_f1_skha_sksmbrshp'];
    });
  }

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC6117',
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


  List gallery=[];
  Future get_gallery() async {
    final pref=await SharedPreferences.getInstance();
    var get=pref.getString('user_id');
    Map data={
      'user_id':get.toString()
    };
    var url = Uri.parse("https://community.creditmywallet.in.net/api/followed_pro");
    var body=jsonEncode(data);
    final response = await http.post(url,headers:{"Content-Type": "application/json"},body: body);
    var res = await json.decode(response.body);
    print("response12" + response.body);

    if (response.statusCode == 200) {
      setState(() {
        gallery = res['response'];
        print("%%%%%%%%%%5555"+gallery.toString());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      get_banner();
      get_user_profile();
      get_gallery();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE8EFF3),
        shape: RoundedRectangleBorder(),
        elevation: 0,
        leading:IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
              "My Profile",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xff000000),
                  fontSize: 16),
            ),
      ),
      body: SingleChildScrollView(
        child: img!=null?
        Column(
          children: [
            Container(
              height: 196,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xffE8EFF3),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(130),
                      bottomRight: Radius.circular(130))),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 88,
                        width: 88,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: NetworkImage(img.toString()),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: isimageselected1 ? Image.file(_image1,fit: BoxFit.fill,) : Container(),
                      ),
                      Positioned(
                        left: 60,
                        top: 60,
                        child: InkWell(
                          onTap: (){
                            camera();
                          },
                          child: Container(
                            height: 30, width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.red,
                                image:  DecorationImage(
                                    image: AssetImage("assets/images/upload.png"))),
                          ),
                        ))
                    ],
                  ),

                  SizedBox(
                    height: 10.82,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(name![0].toUpperCase().toString()+name!.replaceRange(0, 1, "")+" "+middle_name![0].toUpperCase().toString()+middle_name!.replaceRange(0, 1, ""),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffFF8900)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(age.toString()+" Years, ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff878383)),
                      ),
                      gender=="0"?
                      Text(
                        "Male",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff878383)),
                      ):
                      Text(
                        "Female",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff878383)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 21),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                color: Color.fromARGB(255, 248, 248, 248),
                child: Container(
                  height: 211,
                  child: Column(
                    children: [

                      Container(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 19),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 31,
                                          right: 15,
                                        ),
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(
                                              "assets/images/jobs.png",
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                    Text(prfession.toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff656565)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 19),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 31,
                                          right: 15,
                                        ),
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(
                                              "assets/images/shakha.png",
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                    Text(native.toString(),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff656565)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 19),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 31,
                                          right: 15,
                                        ),
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(
                                              "assets/images/shakha.png",
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                    Text(shakha.toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff656565)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 19),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 31,
                                          right: 15,
                                        ),
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(
                                              "assets/images/member.png",
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                    Text(sks_membership.toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff656565)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 19),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 31, right: 15,),
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(
                                              "assets/images/locationc.png",
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                    Text(location.toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff656565)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 29,
            ),
            is_call=="1"?
            Row(
              children: [
                Spacer(),
                Text("Slide to hide/show Mobile Number",
                style: TextStyle(
                  color: Colors.black
                ),),
                SizedBox(
                  width: 10,
                ),
                Switch(
                  value: _enable4,
                  onChanged: (val) {
                    setState(() {
                      _enable4=val;
                      can_call();
                      print(_enable4.toString()+" fgfgnlnfh");
                    });
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width/20,
                ),
              ],
            ):
            Row(
              children: [
                Spacer(),
                Text("Slide to hide/show Mobile Number",
                  style: TextStyle(
                      color: Colors.black
                  ),),
                SizedBox(
                  width: 10,
                ),
                Switch(
                  value: _enable1,
                  onChanged: (val) {
                    setState(() {
                      _enable1=val;
                      can_call();
                      print(_enable1.toString()+" fgfgnlnfh");
                    });
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width/20,
                ),
              ],
            ),
            InkWell(
              onTap: () {
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 15,
                            child: Image.asset("assets/images/calls.png")),
                        SizedBox(
                          width: 14,
                        ),
                        Text(
                          "Call",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xff6AAF50),
                              fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.88,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.green.shade100, Colors.green.shade300])),
                ),
              ),
            ),
            what=="1"?
            Row(
              children: [
                Spacer(),
                Text("Slide to hide/show Whatsapp option"),
                SizedBox(
                  width: 10,
                ),
                Switch(
                  value: _enable3,
                  onChanged: (val) {
                    setState(() {
                      _enable3=val;
                      can_whats();
                      print(_enable3.toString()+" fgfgnlnfh");
                    });
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width/20,
                ),
              ],
            ):
            Row(
              children: [
                Spacer(),
                Text("Slide to hide/show Whatsapp option"),
                SizedBox(
                  width: 10,
                ),
                Switch(
                  value: _enable,
                  onChanged: (val) {
                    setState(() {
                      _enable=val;
                      can_whats();
                      print(_enable.toString()+" fgfgnlnfh");
                    });
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width/20,
                ),
              ],
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 30,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 30,width: 30,
                      child: Image.asset(
                        "assets/images/whats.png",
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "WhatsApp",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xff55CD6C),
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              height: 45,
              width: MediaQuery.of(context).size.width * 0.88,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.green.shade100, Colors.green.shade200])),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 35,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/images/message.png",
                              ),
                              fit: BoxFit.fill)),
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Text(
                      "Message",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xff60B8FE),
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              height: 45,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.blue.shade100, Colors.blue.shade300])),
            ),
            SizedBox(height: 20),
            gallery.length!=0?
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics:  NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: gallery.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 15/ 15,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    crossAxisCount: 3
                ),
                itemBuilder: (BuildContext, int index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>MyFavroiteProfile()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), color: Colors.white),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 4,
                        child: Container(
                          height: 84.71, width: 84.86,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(gallery[index]['profile_img'].toString())
                                  , fit: BoxFit.cover)
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ):
                Text("No Favourite profile"),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 45,
                        decoration: const BoxDecoration(
                        ),
                        child: Text(
                          "My Favourite Profile",
                          style:
                          TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 22,
                          child: Container(
                            height: 2,
                            width: MediaQuery.of(context).size.width * 0.4,
                            color: Colors.black,
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.88,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Colors.blue.shade400,
                      Colors.blue.shade100,
                    ],
                  )),
              child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context) => Dashboard()));
                  },
                  child: Center(
                      child: Text(
                        "Go to Dashboard",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.white),
                      )
                  )
              ),
            ),
            SizedBox(
              height: 25,
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
            SizedBox(
              height: 10,
            )
          ],
        ):

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        // you can replace this with Image.asset
                        'assets/images/splash.png',
                        fit: BoxFit.cover,
                        height: 70,
                        width: 70,
                      ),
                      // you can replace
                      Container(
                        height: 80,
                        width: 80,
                        child:
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                          strokeWidth: 1.5,

                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text( 'Getting Profile...',style: TextStyle(color: Colors.pink,fontSize: 17),),
                ]
            ),
          ],
        )
      ),
    );
  }
  void camera() async{
    Widget onPostiveButton=TextButton(
      onPressed: ()async{

        final image=await ImagePicker().pickImage(source: ImageSource.camera);
        if(image==null)return;
        {
          setState(() async {
            isimageselected1=true;
            _image1=File(image.path);
            final pref=await SharedPreferences.getInstance();
            var get=pref.getString('user_id');
            var dio = Dio();
            String fileName = _image1.path.split('/').last;
            var formData = FormData.fromMap({
              'user_id': get.toString(),
              'img': await MultipartFile.fromFile(_image1.path,filename: fileName),
            });
            print(formData.fields.toString());
            var response = await dio.post('https://community.creditmywallet.in.net/api/add_prof',data: formData);
            var res=response.data;
            var status_code=res['status_code'];
            var msg=res['status_message'];
            if(status_code==200)
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder:
                  (context) => Dashboard()));
            }
            else
            {
              Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM);
            }
            setState(() {
              print("%%%%%%%%"+response.toString());
            });
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
          setState(() async{
            isimageselected1=true;
            _image1=File(image.path);
            final pref=await SharedPreferences.getInstance();
            var get=pref.getString('user_id');
            var dio = Dio();
            String fileName = _image1.path.split('/').last;
            var formData = FormData.fromMap({
              'user_id': get.toString(),
              'img': await MultipartFile.fromFile(_image1.path,filename: fileName),
            });
            print(formData.fields.toString());
            var response = await dio.post('https://community.creditmywallet.in.net/api/add_prof',data: formData);
            var res=response.data;
            var status_code=res['status_code'];
            var msg=res['status_message'];
            if(status_code==200)
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder:
                  (context) => Dashboard()));
            }
            else
            {
              Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM);
            }
            setState(() {
              print("%%%%%%%%"+response.toString());
            });
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
