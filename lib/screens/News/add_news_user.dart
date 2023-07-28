import 'dart:convert';
import 'dart:io';
import 'package:communityapp/screens/sanskriti/sanskriti.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Add_News_User extends StatefulWidget {
   Add_News_User({super.key,this.category_id,this.category_name});
  String? category_id,category_name;
  @override
  State<Add_News_User> createState() => _Add_News_UserState();
}
class _Add_News_UserState extends State<Add_News_User> {
  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();
  String? dob;
  String? time;
  late DateTime _myDateTime;
  late TimeOfDay newtime;
  bool isVisible = false;
  String? location;



  String? news;
  List News_Categories=[];
  String? category_id,category_name;
  // Future get_News_Categories() async {
  //   var url = Uri.parse("https://community.creditmywallet.in.net/api/get_news_category");
  //   final response = await http.post(url);
  //   var res = await json.decode(response.body)['id'];
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       category_id=res['category_id'];
  //       category_name = res['category_name'];
  //     });
  //   }
  // }


  List currentShakha=[];
  String? current_shakha;
  String? name;
  String? id;
  Future getCurrentShakha() async{
    var url="https://community.creditmywallet.in.net/api/get_news_category";
    http.Response response=await http.post(Uri.parse(url));
    var res=jsonDecode(response.body)['status_message'];
    setState(() {
      print("%%%%%%%%%%%%"+res.toString());
      currentShakha=res;
      // id = res['category_id'];
      print(currentShakha.toString()+"%%%%%%%%%%%%%%%%");
    });
  }
  late File _image;
  late File _image1;
  List<XFile> img = [];
  bool isimageselected=false;
  bool isimageselected1=false;
  @override
  void initState() {
    super.initState();
    getCurrentShakha();
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
          "    Post News",
          style: TextStyle(
              color: Color(0xff000000),
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 21.36,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.86,
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
                          Text("Write News",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Color(0xff000000))),
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                          SizedBox(
                            height: 10,
                          ),
                           Padding(
                                padding: EdgeInsets.only(left: 37),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Title",
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
                                  controller: title,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(14.0),
                                    border: InputBorder.none,
                                    hintText: "title",
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
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
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
                      width: MediaQuery.of(context).size.width*0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: name,
                          hint: Text("      Category Name"),
                          icon: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.arrow_drop_down),
                          ),
                          items: currentShakha.map((item) {
                            return DropdownMenuItem(
                              value: item['category_id'].toString(),
                              child: Padding(
                                padding:  EdgeInsets.only(left: 30),
                                child: Text(
                                  item['category_name'].toString(),
                                  style: TextStyle(color: Colors.black54,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              setState((){
                                name = newValue! as String?;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                               SizedBox(
                            height: 10,
                          ),
                              Padding(
                            padding: const EdgeInsets.only(left: 37),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "Write about event",
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
                                hintText: "Describe event..........",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff878383),
                                    fontSize: 14),
                              ),
                            ),
                          )
                        ],
                      ),
                       ]
                    ),
                    ),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Row(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          InkWell(
                           onTap:(){
                              camera();
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              elevation: 10,
                              child: Container(
                                height: 81,
                                width: 81,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                               child: isimageselected1 ? Image.file(_image1,fit: BoxFit.fill,) : Container(child: Icon(Icons.add_a_photo,size: 30,),),                        
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                    SizedBox(
                      height: 17,
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
                            )),
                        child: MaterialButton(
                            onPressed: () async{
                              if(title.text.isNotEmpty && description.text.isNotEmpty)
                                {
                                  final pref=await SharedPreferences.getInstance();
                                  var get=pref.getString('user_id');
                                  var dio1 = Dio();
                                  var formData = FormData.fromMap({
                                  "added_by": get.toString(),
                                  "category_id": name.toString(),                    
                                  "category_name": name.toString(),
                                  "image":await MultipartFile.fromFile(_image1.path),
                                  "title": title.text.toString(),
                                  "description": description.text.toString(),
                                  });
                                  print(img.length);
                                  print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                  var response = await dio1.post('https://community.creditmywallet.in.net/api/add_news_by_user',data: formData);
                                  var res=response.data;
                                  var msg=res["status_message"];
                                  setState(() {
                                    print("%%%%%%%%%%%%%%%"+res.toString());
                                  });
                                  if(res["status_message"]=="News Added Successfully")
                                  {
                                    Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM);
                                    // Navigator.pushReplacement(context, MaterialPageRoute(
                                    //     builder: (context)=>VadavalSanskriti()));
                                    description.clear();
                                    title.clear();
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
                   ],
                  )
                ),
              ),
            ]
          ),
      )
    );
  }

 String ?subs_id;
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