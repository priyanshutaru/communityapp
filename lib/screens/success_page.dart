import 'package:communityapp/screens/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:communityapp/main.dart';


class RegisterSuccess extends StatefulWidget {
  const RegisterSuccess({Key? key,}) : super(key: key);
  // final String finalRegisterId;

  @override
  State<RegisterSuccess> createState() => _RegisterSuccessState();
}

class _RegisterSuccessState extends State<RegisterSuccess> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Sucess.gif',
              height: 300,
              width: 300,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(20),
                child: Text(
                  'Thank You!! Your registered profile is sent for approval.Please login back after few hours.',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.w400),
                )),
            // SizedBox(
            //   height: 1,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       'Register id : ',
            //       style: TextStyle(fontSize: 14, color: Colors.black54),
            //     ),
            //     Text(
            //       widget.finalRegisterId.toString(),
            //       style: TextStyle(fontSize: 14, color: Colors.green),
            //     )
            //   ],
            // ),
            SizedBox(
              height: 15,
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => Loginpage()));
            //   },
            //   child: Text(
            //     'View Details',
            //     style: TextStyle(
            //         fontSize: 12,
            //         color: Colors.black,
            //         fontWeight: FontWeight.w500),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Loginpage()));
              },
              child: const Text(
                ' Go to Login ',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}