import 'dart:convert';
import 'dart:io';
import 'package:communityapp/screens/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:communityapp/screens/Business/business_info.dart';
import 'package:communityapp/screens/Business/business_profile.dart';
import 'package:communityapp/screens/profile_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SupportAndFeedback extends StatefulWidget {
  const SupportAndFeedback({Key? key}) : super(key: key);

  @override
  State<SupportAndFeedback> createState() => _SupportAndFeedbackState();
}

class _SupportAndFeedbackState extends State<SupportAndFeedback> {
  String dropdownvalue = 'Support & Feedback';
  var items = [
    'Support & Feedback',
    'Item 5',
    'Item 8',
    'Item 22',
    'Item 7878',
  ];

  List Banner=[];
  Future get_banner() async {
    Map data={
      'screen_id':'SC890',
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

  late File _image;
  List<XFile> img = [];
  bool isimageselected=false;
  bool isVisible = false;
  TextEditingController description=TextEditingController();

  @override
  void initState() {
    super.initState();
    get_banner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F8FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffF4F8FB),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 25,
            ),
          ),
        title: const Text(
          "Support & Feedback",
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
          Padding(
            padding: EdgeInsets.only(left: 35, right: 35),
            child: Container(
                child: const Text(
              "Please provide your valuable feedback and submit report in the app",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff878383),
                  fontSize: 12),
            )),
          ),
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
              color: Color(0xffDED9D9),
              child: Column(children: [
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      alignment: Alignment.bottomLeft,
                      child: const Text(
                        "Subject",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black45),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 3),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: dropdownvalue,
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 30,
                                color: Colors.black,
                              ),
                            ),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        items,
                                        style: const TextStyle(
                                            color: Color(0xff878383),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
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
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 10),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Feedback",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff7A7A7A)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: TextFormField(
                      controller: description,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write about your achievements......',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xff878383),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 10),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Add Images",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff7A7A7A)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
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
                  height: 20,
                ),
                Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.9,
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
                          if(dropdownvalue!=null && description.text.isNotEmpty)
                            {
                              final pref=await SharedPreferences.getInstance();
                              var get=pref.getString('user_id');
                              var dio1 = Dio();
                              var formData = FormData.fromMap({
                                'user_id': get.toString(),
                                "subject": dropdownvalue,
                                "feedback":description.text.toString(),
                                'images[]': img.map((item)=> MultipartFile.fromFileSync(item.path,
                                    filename: item.path.split('/').last)).toList(),
                              });
                              print(img.length);
                              print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                              var response = await dio1.post('https://community.creditmywallet.in.net/api/support',data: formData);
                              var res=response.data;
                              var msg=res["status_message"];
                              setState(() {
                                print("%%%%%%%%%%%%%%%"+res.toString());
                              });
                              if(res["status_message"]=="Support Added Successfully")
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
                        child: Text("Submit",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.white),
                        )
                    )
                ),
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
              ]
              ),
            ),
          ),
        ],
      )
      ),
    );
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

