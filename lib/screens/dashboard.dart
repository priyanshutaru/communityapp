import 'package:communityapp/screens/Chat/chat_screen.dart';
import 'package:communityapp/screens/Events/event_screen.dart';
import 'package:communityapp/screens/home_page.dart';
import 'package:communityapp/screens/profile_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var myindex = 0;
  GlobalKey<CurvedNavigationBarState> _navKey = GlobalKey();
  var _pages = [
    HomePage(),
    ChatScreen(),
    HomePage(),
    EventScreen(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[myindex],
      bottomNavigationBar: CurvedNavigationBar(
        height: MediaQuery.of(context).size.height * 0.075,
        key: _navKey,
        index: 0,
        buttonBackgroundColor: Colors.orange,
        items: [
          Container(
              height: 30,
              child: Image.asset(
                "assets/images/home.png",
                color: Colors.black,
              )
          ),
          Container(
              height: 30,
              child: Image.asset("assets/images/chatss.png")
          ),
          Container(
              height: 30,
              child: Image.asset(
                "assets/images/addicon.png",
                color: Colors.white,
              )
          ),
          Container(
              height: 30,
              child: Image.asset("assets/images/notification.png")
          ),
          Container(
              height: 30,
              child: Image.asset("assets/images/person.png")
          ),
        ],
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            myindex = index;
          });
        },
        animationDuration: Duration(microseconds: 100),
        animationCurve: Curves.fastLinearToSlowEaseIn,
        color: Color(0xffDED9D9),
      ),
    );
  }
}
