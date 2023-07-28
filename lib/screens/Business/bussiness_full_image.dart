import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
class full_image_bussiness extends StatefulWidget {
  String? image,parent_user_id;
  full_image_bussiness({required this.image,required this.parent_user_id});

  @override
  State<full_image_bussiness> createState() => _full_image_bussinessState();
}

class _full_image_bussinessState extends State<full_image_bussiness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 25,horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: [
              Spacer(),
              IconButton(
                  onPressed: (){
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))
                        ),
                        context: context,
                        isScrollControlled: true,
                        builder: (context) =>
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                              height: 640,
                              child: ListView(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text("Report",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'SairaCondensed',
                                          ),),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Why are you reporting this post?",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'SairaCondensed',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Your report is anonymous, except if you reporting"
                                          "an intelectual property infrigment.if someone is in"
                                          "immediate danger, call the local emergency services - "
                                          "dont wait",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black26,
                                          fontFamily: 'SairaCondensed',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      InkWell(
                                        onTap: () async{
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
                                            onPressed: ()
                                            async{
                                              final pref=await SharedPreferences.getInstance();
                                              var user_id=pref.getString('user_id');
                                              var dio=Dio();
                                              var formData = FormData.fromMap({
                                                'report_type':"1",
                                                'parent_id': "${widget.parent_user_id}",
                                                'reported_by':user_id.toString(),
                                                'report_for':"1",
                                                'image_reported':"${widget.image}",
                                                'reason':"It's spam",
                                              });
                                              print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                              var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                  data: formData);
                                              var res=response.data;
                                              var msg=res['status_message'];
                                              setState((){
                                                print(res.toString());
                                                print(response.toString()+"%%^^^&*()");
                                              });
                                              if(res['status_message']=="Report Submitted")
                                              {
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else
                                              {
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              setState(() {

                                              });
                                            },
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
                                            title: Text("Are You Sure"),
                                          );
                                          showDialog(context: context, builder: (BuildContext context)
                                          {
                                            return dialog;
                                          });
                                        },
                                        child: Container(
                                          height:35,
                                          alignment: Alignment.centerLeft,
                                          width:MediaQuery.of(context).size.width,
                                          child: Text("It's spam",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: 'SairaCondensed',
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async{
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
                                            onPressed: ()
                                            async{
                                              final pref=await SharedPreferences.getInstance();
                                              var user_id=pref.getString('user_id');
                                              var dio=Dio();
                                              var formData = FormData.fromMap({
                                                'report_type':"1",
                                                'parent_id': "${widget.parent_user_id}",
                                                'reported_by':user_id.toString(),
                                                'report_for':"1",
                                                'image_reported':"${widget.image}",
                                                'reason': "Nudity or sexual activity",
                                              });
                                              print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                              var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                  data: formData);
                                              var res=response.data;
                                              var msg=res['status_message'];
                                              setState((){
                                                print(res.toString());
                                                print(response.toString()+"%%^^^&*()");
                                              });
                                              if(res['status_message']=="Report Submitted")
                                              {
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else
                                              {
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              setState(() {

                                              });
                                            },
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
                                            title: Text("Are You Sure"),
                                          );
                                          showDialog(context: context, builder: (BuildContext context)
                                          {
                                            return dialog;
                                          });
                                        },
                                        child: Container(
                                          height:35,
                                          alignment: Alignment.centerLeft,
                                          width:MediaQuery.of(context).size.width,
                                          child: Text("Nudity or sexual activity",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: 'SairaCondensed',
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async{
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
                                            onPressed: ()
                                            async{
                                              final pref=await SharedPreferences.getInstance();
                                              var user_id=pref.getString('user_id');
                                              var dio=Dio();
                                              var formData = FormData.fromMap({
                                                'report_type':"1",
                                                'parent_id': "${widget.parent_user_id}",
                                                'reported_by':user_id.toString(),
                                                'report_for':"1",
                                                'image_reported':"${widget.image}",
                                                'reason': "Hate speech or symbols",
                                              });
                                              print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                              var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                  data: formData);
                                              var res=response.data;
                                              var msg=res['status_message'];
                                              setState((){
                                                print(res.toString());
                                                print(response.toString()+"%%^^^&*()");
                                              });
                                              if(res['status_message']=="Report Submitted")
                                              {
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else
                                              {
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              setState(() {

                                              });
                                            },
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
                                            title: Text("Are You Sure"),
                                          );
                                          showDialog(context: context, builder: (BuildContext context)
                                          {
                                            return dialog;
                                          });
                                        },
                                        child: Container(
                                          height:35,
                                          alignment: Alignment.centerLeft,
                                          width:MediaQuery.of(context).size.width,
                                          child: Text("Hate speech or symbols",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: 'SairaCondensed',
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async{
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
                                            onPressed: ()
                                            async{
                                              final pref=await SharedPreferences.getInstance();
                                              var user_id=pref.getString('user_id');
                                              var dio=Dio();
                                              var formData = FormData.fromMap({
                                                'report_type':"1",
                                                'parent_id': "${widget.parent_user_id}",
                                                'reported_by':user_id.toString(),
                                                'report_for':"1",
                                                'image_reported':"${widget.image}",
                                                'reason': "False information",
                                              });
                                              print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                              var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                  data: formData);
                                              var res=response.data;
                                              var msg=res['status_message'];
                                              setState((){
                                                print(res.toString());
                                                print(response.toString()+"%%^^^&*()");
                                              });
                                              if(res['status_message']=="Report Submitted")
                                              {
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else
                                              {
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              setState(() {

                                              });
                                            },
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
                                            title: Text("Are You Sure"),
                                          );
                                          showDialog(context: context, builder: (BuildContext context)
                                          {
                                            return dialog;
                                          });
                                        },
                                        child: Container(
                                          height:35,
                                          alignment: Alignment.centerLeft,
                                          width:MediaQuery.of(context).size.width,
                                          child: Text("False information",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: 'SairaCondensed',
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async{
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
                                            onPressed: ()
                                            async{
                                              final pref=await SharedPreferences.getInstance();
                                              var user_id=pref.getString('user_id');
                                              var dio=Dio();
                                              var formData = FormData.fromMap({
                                                'report_type':"1",
                                                'parent_id': "${widget.parent_user_id}",
                                                'reported_by':user_id.toString(),
                                                'report_for':"1",
                                                'image_reported':"${widget.image}",
                                                'reason': "I just don't like it",
                                              });
                                              print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                              var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                  data: formData);
                                              var res=response.data;
                                              var msg=res['status_message'];
                                              setState((){
                                                print(res.toString());
                                                print(response.toString()+"%%^^^&*()");
                                              });
                                              if(res['status_message']=="Report Submitted")
                                              {
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else
                                              {
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              setState(() {

                                              });
                                            },
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
                                            title: Text("Are You Sure"),
                                          );
                                          showDialog(context: context, builder: (BuildContext context)
                                          {
                                            return dialog;
                                          });
                                        },
                                        child: Container(
                                          height:35,
                                          alignment: Alignment.centerLeft,
                                          width:MediaQuery.of(context).size.width,
                                          child: Text("I just don't like it",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: 'SairaCondensed',
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async{
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
                                            onPressed: ()
                                            async{
                                              final pref=await SharedPreferences.getInstance();
                                              var user_id=pref.getString('user_id');
                                              var dio=Dio();
                                              var formData = FormData.fromMap({
                                                'report_type':"1",
                                                'parent_id': "${widget.parent_user_id}",
                                                'reported_by':user_id.toString(),
                                                'report_for':"1",
                                                'image_reported':"${widget.image}",
                                                'reason': "Bullying or harassment",
                                              });
                                              print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                              var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                  data: formData);
                                              var res=response.data;
                                              var msg=res['status_message'];
                                              setState((){
                                                print(res.toString());
                                                print(response.toString()+"%%^^^&*()");
                                              });
                                              if(res['status_message']=="Report Submitted")
                                              {
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else
                                              {
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              setState(() {

                                              });
                                            },
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
                                            title: Text("Are You Sure"),
                                          );
                                          showDialog(context: context, builder: (BuildContext context)
                                          {
                                            return dialog;
                                          });
                                        },
                                        child: Container(
                                          height:35,
                                          alignment: Alignment.centerLeft,
                                          width:MediaQuery.of(context).size.width,
                                          child: Text("Bullying or harassmen",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: 'SairaCondensed',
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async{
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
                                            onPressed: ()
                                            async{
                                              final pref=await SharedPreferences.getInstance();
                                              var user_id=pref.getString('user_id');
                                              var dio=Dio();
                                              var formData = FormData.fromMap({
                                                'report_type':"1",
                                                'parent_id': "${widget.parent_user_id}",
                                                'reported_by':user_id.toString(),
                                                'report_for':"1",
                                                'image_reported':"${widget.image}",
                                                'reason': "Scam or fraud",
                                              });
                                              print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                              var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                  data: formData);
                                              var res=response.data;
                                              var msg=res['status_message'];
                                              setState((){
                                                print(res.toString());
                                                print(response.toString()+"%%^^^&*()");
                                              });
                                              if(res['status_message']=="Report Submitted")
                                              {
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else
                                              {
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              setState(() {

                                              });
                                            },
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
                                            title: Text("Are You Sure"),
                                          );
                                          showDialog(context: context, builder: (BuildContext context)
                                          {
                                            return dialog;
                                          });
                                        },
                                        child: Container(
                                          height:35,
                                          alignment: Alignment.centerLeft,
                                          width:MediaQuery.of(context).size.width,
                                          child: Text("Scam or fraud",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: 'SairaCondensed',
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async{
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
                                            onPressed: ()
                                            async{
                                              final pref=await SharedPreferences.getInstance();
                                              var user_id=pref.getString('user_id');
                                              var dio=Dio();
                                              var formData = FormData.fromMap({
                                                'report_type':"1",
                                                'parent_id': "${widget.parent_user_id}",
                                                'reported_by':user_id.toString(),
                                                'report_for':"1",
                                                'image_reported':"${widget.image}",
                                                'reason': "Violence or dangerous organizations",
                                              });
                                              print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                              var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                  data: formData);
                                              var res=response.data;
                                              var msg=res['status_message'];
                                              setState((){
                                                print(res.toString());
                                                print(response.toString()+"%%^^^&*()");
                                              });
                                              if(res['status_message']=="Report Submitted")
                                              {
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else
                                              {
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              setState(() {

                                              });
                                            },
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
                                            title: Text("Are You Sure"),
                                          );
                                          showDialog(context: context, builder: (BuildContext context)
                                          {
                                            return dialog;
                                          });
                                        },
                                        child: Container(
                                          height:35,
                                          alignment: Alignment.centerLeft,
                                          width:MediaQuery.of(context).size.width,
                                          child: Text("Violence or dangerous organizations",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: 'SairaCondensed',
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async{
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
                                            onPressed: ()
                                            async{
                                              final pref=await SharedPreferences.getInstance();
                                              var user_id=pref.getString('user_id');
                                              var dio=Dio();
                                              var formData = FormData.fromMap({
                                                'report_type':"1",
                                                'parent_id': "${widget.parent_user_id}",
                                                'reported_by':user_id.toString(),
                                                'report_for':"1",
                                                'image_reported':"${widget.image}",
                                                'reason': "Intellctual property violation",
                                              });
                                              print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                              var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                  data: formData);
                                              var res=response.data;
                                              var msg=res['status_message'];
                                              setState((){
                                                print(res.toString());
                                                print(response.toString()+"%%^^^&*()");
                                              });
                                              if(res['status_message']=="Report Submitted")
                                              {
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else
                                              {
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              setState(() {

                                              });
                                            },
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
                                            title: Text("Are You Sure"),
                                          );
                                          showDialog(context: context, builder: (BuildContext context)
                                          {
                                            return dialog;
                                          });
                                        },
                                        child: Container(
                                          height:35,
                                          alignment: Alignment.centerLeft,
                                          width:MediaQuery.of(context).size.width,
                                          child: Text("Intellctual property violation",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: 'SairaCondensed',
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async{
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
                                            onPressed: ()
                                            async{
                                              final pref=await SharedPreferences.getInstance();
                                              var user_id=pref.getString('user_id');
                                              var dio=Dio();
                                              var formData = FormData.fromMap({
                                                'report_type':"1",
                                                'parent_id': "${widget.parent_user_id}",
                                                'reported_by':user_id.toString(),
                                                'report_for':"1",
                                                'image_reported':"${widget.image}",
                                                'reason': "Sale of illegal or regulated goods",
                                              });
                                              print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                              var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                  data: formData);
                                              var res=response.data;
                                              var msg=res['status_message'];
                                              setState((){
                                                print(res.toString());
                                                print(response.toString()+"%%^^^&*()");
                                              });
                                              if(res['status_message']=="Report Submitted")
                                              {
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else
                                              {
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              setState(() {

                                              });
                                            },
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
                                            title: Text("Are You Sure"),
                                          );
                                          showDialog(context: context, builder: (BuildContext context)
                                          {
                                            return dialog;
                                          });
                                        },
                                        child: Container(
                                          height:35,
                                          alignment: Alignment.centerLeft,
                                          width:MediaQuery.of(context).size.width,
                                          child: Text("Sale of illegal or regulated goods",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: 'SairaCondensed',
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async{
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
                                            onPressed: ()
                                            async{
                                              final pref=await SharedPreferences.getInstance();
                                              var user_id=pref.getString('user_id');
                                              var dio=Dio();
                                              var formData = FormData.fromMap({
                                                'report_type':"1",
                                                'parent_id': "${widget.parent_user_id}",
                                                'reported_by':user_id.toString(),
                                                'report_for':"1",
                                                'image_reported':"${widget.image}",
                                                'reason': "Suicide or self-injury",
                                              });
                                              print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                              var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                  data: formData);
                                              var res=response.data;
                                              var msg=res['status_message'];
                                              setState((){
                                                print(res.toString());
                                                print(response.toString()+"%%^^^&*()");
                                              });
                                              if(res['status_message']=="Report Submitted")
                                              {
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else
                                              {
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              setState(() {

                                              });
                                            },
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
                                            title: Text("Are You Sure"),
                                          );
                                          showDialog(context: context, builder: (BuildContext context)
                                          {
                                            return dialog;
                                          });
                                        },
                                        child: Container(
                                          height:35,
                                          alignment: Alignment.centerLeft,
                                          width:MediaQuery.of(context).size.width,
                                          child: Text("Suicide or self-injury",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: 'SairaCondensed',
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async{
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
                                            onPressed: ()
                                            async{
                                              final pref=await SharedPreferences.getInstance();
                                              var user_id=pref.getString('user_id');
                                              var dio=Dio();
                                              var formData = FormData.fromMap({
                                                'report_type':"1",
                                                'parent_id': "${widget.parent_user_id}",
                                                'reported_by':user_id.toString(),
                                                'report_for':"1",
                                                'image_reported':"${widget.image}",
                                                'reason': "Eating disorders",
                                              });
                                              print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                              var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                  data: formData);
                                              var res=response.data;
                                              var msg=res['status_message'];
                                              setState((){
                                                print(res.toString());
                                                print(response.toString()+"%%^^^&*()");
                                              });
                                              if(res['status_message']=="Report Submitted")
                                              {
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else
                                              {
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              setState(() {

                                              });
                                            },
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
                                            title: Text("Are You Sure"),
                                          );
                                          showDialog(context: context, builder: (BuildContext context)
                                          {
                                            return dialog;
                                          });
                                        },
                                        child: Container(
                                          height:35,
                                          alignment: Alignment.centerLeft,
                                          width:MediaQuery.of(context).size.width,
                                          child: Text("Eating disorders",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: 'SairaCondensed',
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async{
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
                                            onPressed: ()
                                            async{
                                              final pref=await SharedPreferences.getInstance();
                                              var user_id=pref.getString('user_id');
                                              var dio=Dio();
                                              var formData = FormData.fromMap({
                                                'report_type':"1",
                                                'parent_id': "${widget.parent_user_id}",
                                                'reported_by':user_id.toString(),
                                                'report_for':"1",
                                                'image_reported':"${widget.image}",
                                                'reason': "Something else",
                                              });
                                              print(formData.fields.toString()+"^^^^^^^^^^^^^^");
                                              var response = await dio.post('https://community.creditmywallet.in.net/api/report',
                                                  data: formData);
                                              var res=response.data;
                                              var msg=res['status_message'];
                                              setState((){
                                                print(res.toString());
                                                print(response.toString()+"%%^^^&*()");
                                              });
                                              if(res['status_message']=="Report Submitted")
                                              {
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              else
                                              {
                                                Fluttertoast.showToast(msg: msg.toString(),toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM);
                                              }
                                              setState(() {

                                              });
                                            },
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
                                            title: Text("Are You Sure"),
                                          );
                                          showDialog(context: context, builder: (BuildContext context)
                                          {
                                            return dialog;
                                          });
                                        },
                                        child: Container(
                                          height:35,
                                          alignment: Alignment.centerLeft,
                                          width:MediaQuery.of(context).size.width,
                                          child: Text("Something else",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: 'SairaCondensed',
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                    );
                  },
                  icon: Icon(Icons.more_vert,)),
            ],
            ),
            Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("${widget.image}"),
                  fit: BoxFit.fill
                ),
                border: Border.all(color: Colors.black,width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
