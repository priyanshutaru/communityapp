import 'package:communityapp/screens/home_page.dart';
import 'package:communityapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: HomePage(),

    debugShowCheckedModeBanner: false,
  ));



}

