import 'dart:convert';
import 'package:card_loading/card_loading.dart';
import 'package:communityapp/screens/Blood/my_blood_request.dart';
import 'package:communityapp/screens/Business/my_business.dart';
import 'package:communityapp/screens/Events/add_event_by_user.dart';
import 'package:communityapp/screens/Job/job_profile.dart';
import 'package:communityapp/screens/Job/no_of_job_list.dart';
import 'package:communityapp/screens/Business/business_lead.dart';
import 'package:communityapp/screens/Business/business_registration.dart';
import 'package:communityapp/screens/Matrimony/matrimony_reg.dart';
import 'package:communityapp/screens/News/add_news_user.dart';
import 'package:communityapp/screens/auth/login_page.dart';
import 'package:communityapp/screens/dashboard.dart';
import 'package:communityapp/screens/forum/my_discussion.dart';
import 'package:communityapp/screens/forum/post_forum.dart';
import 'package:communityapp/screens/generate_lead.dart';
import 'package:communityapp/screens/myProfile.dart';
import 'package:communityapp/screens/sanskriti/post_sanskriti_topic.dart';
import 'package:communityapp/screens/support_feedback.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  String? img;
  String? name;
  String? mobile_no;
  String? email;
  String? location;
  String? gender;
  String? category;
  String? shakha;
  String? bio;
  String? middle_name;
  int? age;
  Future get_user_profile() async{
    final pref=await SharedPreferences.getInstance();
    var user_id=pref.getString('user_id');
    Map data={
      'user_id':user_id.toString(),
    };
    Uri url = Uri.parse("https://community.creditmywallet.in.net/api/get_user_prof");
    var body=jsonEncode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: body);
    var res=json.decode(response.body);
    var ms=jsonDecode(response.body)['current_shakha'];
    print(ms.toString());
    setState(() {
      img=res['basic_details']['profile_img'];
      bio=res['basic_details']['bio'];
      name=res['basic_details']['first_name'];
      middle_name=res['basic_details']['last_name'];
      mobile_no=res['basic_details']['mobile'];
      email=res['basic_details']['email'];
      gender =res['basic_details']['gender'];
      shakha=ms['shakha_name'];
      location=res['distric'];
      age=res['turning'];
      if(bio!=null)
        {
          setState(() {
            bio_comment.text=bio.toString();
          });
        }
      else
        {
          null;
        }
    });
  }
  TextEditingController bio_comment=TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      get_user_profile();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        elevation: 0,
        backgroundColor: Color(0xffF4F8FB),
      ),
      backgroundColor: Color(0xffF4F8FB),
      body:
      img!=null?
      SingleChildScrollView(
        child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height/12,
                            width: MediaQuery.of(context).size.width/5.6,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    image: NetworkImage(img.toString()),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(30)
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Text(name![0].toUpperCase().toString()+name!.replaceRange(0, 1, "")+" "+middle_name![0].toUpperCase().toString()+middle_name!.replaceRange(0, 1, ""),
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w700,
                          //       color: Color(0xffFF9300),
                          //       fontSize: 14),
                          // ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("+91 "+mobile_no.toString(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff878383)),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width*0.59,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15, top: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.email_outlined,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(child: Text(email.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff878383)),
                                  )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 25),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.male_rounded,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 5,
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
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff878383)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10,),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.account_balance,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(shakha.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff878383)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10,),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(location.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff878383)),
                                  ),
                                ],
                              ),
                            ),
                             Container(
                               padding: EdgeInsets.only(left: 10,),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: [
                                   SizedBox(
                                     width: 5,
                                   ),
                                   Icon(
                                     Icons.shopping_bag_sharp,
                                     color: Colors.blue,
                                   ),
                                   SizedBox(
                                     width: 5,
                                   ),
                                   Container(
                                     // width: 145,
                                     child:  bio!=null?
                                       Text(bio.toString(),
                                         style: TextStyle(
                                             fontSize: 12,
                                             fontWeight: FontWeight.w700,
                                             color: Color(0xff878383)),
                                       ):
                                       Text("Bio"),
                                   ),
                                   Spacer(),
                                   Container(
                                     height: 30,
                                     width: 30,
                                     child:  InkWell(
                                       child:Icon(Icons.edit,color: Colors.black,),
                                       onTap: (){
                                         bio5();
                                       },
                                     ),
                                   ),
                                   SizedBox(
                                     width: 5,
                                   ),
                                 ],
                               ),
                             ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 28,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => MyProfile()));
                        },
                        child: _profileItem(
                            "assets/images/profile.png", "Profile Information"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => BloodRequest()));
                        },
                        child: _profileItem("assets/images/bloodrequest.png",
                            "My Blood Requests"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => MatrimonyRegistration()));
                        },
                        child: _profileItem(
                            "assets/images/matrimony.png", "Matrimony Profile"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => PostForum(
                            name: 'add',
                            forum_id: '',
                            tittle: '',
                            topic: '',
                            discussion: '',
                            user_id: '',
                          )));
                        },
                        child: _profileItem("assets/images/openforum.png",
                            "Create open Forum Topic"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => MyDiscussion()));
                        },
                        child: _profileItem("assets/images/openforum.png",
                            "View Open Forum Topic"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => PostSanskritiTopic()));
                        },
                        child: _profileItem("assets/images/sanskriti.png",
                            "Post topics to Vadval Sanskriti"),
                      ),
                      InkWell(
                          onTap: () {
                            // Get.to(MyBusiness());
                            Navigator.push(context, MaterialPageRoute(builder:
                                (context) => MyBusiness()));
                          },
                          child: _profileItem(
                              "assets/images/business.png", "My Business")),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => BusinessRegistration(
                                bussiness_id: '',
                                name: 'Add',
                              )));
                        },
                        child: _profileItem(
                            "assets/images/login.png", "Register New Business"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => GenerateLead()));
                        },
                        child: _profileItem(
                            "assets/images/jobs.png", "Create Business Leads"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => BusinessLead()));
                        },
                        child: _profileItem(
                            "assets/images/job.png", "View Business Leads"),
                      ),
                      InkWell(
                          onTap: () {
                            //Get.to(ForumJobList());
                            Navigator.push(context, MaterialPageRoute(builder:
                                (context) => ForumJobList()));
                          },
                          child: _profileItem(
                              "assets/images/upload.png", "Post Job")),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => JobProfile()));
                        },
                        child: _profileItem("assets/images/ellips.png",
                            "Create Your Job Profile"),
                      ),
                       InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => Add_event_user()));
                        },
                        child: _profileItem("assets/images/job.png",
                            "Create Events"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => Add_News_User()));
                        },
                        child: _profileItem("assets/images/upload.png",
                            "Create News"),
                      ),
                      InkWell(
                        onTap: () {
                        
                        },
                        child: _profileItem(
                            "assets/images/createbusiness.png", "About App"),
                      ),
                      InkWell(
                        onTap: () {
                          //Get.to(SupportAndFeedback());
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => SupportAndFeedback()));
                        },
                        child: _profileItem(
                            "assets/images/openforum.png", "Support & Feedbacks"),
                      ),
                      InkWell(
                        onTap: () {
                        },
                        child: _profileItem(
                            "assets/images/openforum.png", "Delete Profile"),
                      ),
                      InkWell(
                        onTap: () {
                          Logout();
                        },
                        child: _profileItem(
                            "assets/images/createbusiness.png", "Logout"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
      )
          :
      CardLoading(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        borderRadius: BorderRadius.all(Radius.circular(0)
        ),
      )
    );

  }

  Widget _profileItem(img,
      String text,) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.92,
        child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24, right: 10),
                child: Row(children: [
                  Container(
                    height: 25,
                    width: 25,
                    child: Image(image: AssetImage(img)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Text(
                      text,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff878383)),
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios)
                ]),
              ),
              Divider(),
            ]
        )
    );
  }

  void bio5() {
    AlertDialog dialog=new AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            child: Row(
              children: [
                Spacer(),
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.clear)
                )
              ],
            ),
          ),
          Center(
           child: Text("Your Bio"
                  ,style: TextStyle(
                  fontFamily: 'SairaCondensed',
                  color: Colors.lightBlue.shade900,
                ),
                ),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            height: 67,
            child: TextField(
              maxLines: 20,
              controller: bio_comment,
              decoration: InputDecoration(
                labelText: "Your Bio",
                labelStyle: TextStyle(
                  fontFamily: 'SairaCondensed',
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 45,
            width: double.infinity,
            child: MaterialButton(
              color: Colors.black,
              highlightColor: Colors.green,
              onPressed: () async{
                final pref=await SharedPreferences.getInstance();
                var user_id=pref.getString('user_id');
                var dio= Dio();
                var formData = FormData.fromMap({
                  'user_id': user_id,
                  'bio':bio_comment.text.toString()
                });
                print(formData.fields.toString());
                var response = await dio.post('https://community.creditmywallet.in.net/api/bio',data: formData);
                setState(() {
                  var res=response.data;
                  var msg=res['status_message'];
                  Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM);
                  bio_comment.clear();
                  //Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                  print(res.toString());
                });
              },
              child: Text("Post",style: TextStyle(
                  fontFamily: 'SairaCondensed',
                  color: Colors.white
              ),),
            ),
          ),
        ],
      ),
    );
    showDialog(context: context, builder: (BuildContext context)
    {
      return dialog;
    });

  }

  void Logout() {
    Widget onPostiveButton=TextButton(
      onPressed: (){
        Navigator.of(context).pop();
      },
      child: Text("No",style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.red),),
    );
    Widget onNegativeButton=TextButton(
      onPressed: (){
        setState(() async {
          SharedPreferences preferences = await  SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              Loginpage()), (Route<dynamic> route) => false);
        });
      },
      // async{

        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // print("mobile");
        // prefs.remove('mobile');
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        //     Loginpage()), (Route<dynamic> route) => false);
      // },
      child: Text("Yes",
        style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.green
        ),
      ),
    );
    AlertDialog dialog=new AlertDialog(
      actions: [onNegativeButton,onPostiveButton],
      title: Text("Logout"),
    );
    showDialog(context: context, builder: (BuildContext context)
    {
      return dialog;
    });

  }
}
