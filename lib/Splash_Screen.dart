import 'package:flutter/widgets.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/reusable_widget.dart';
import 'package:flutter_app/home_Page.dart';
import 'package:flutter_app/ResetPassword.dart';
import 'package:flutter_app/signup.dart';
import 'package:flutter_app/color_utils.dart';
import 'package:flutter/material.dart';

import 'Signin.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _Splashscreen createState() => _Splashscreen();
}

class _Splashscreen extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(children: [
            Container(
              child: Image.asset(
                'img/splash1.png',
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  'Lets make  ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
            Container(
              alignment: Alignment.center,
              child: Text(
                'connection With pros ',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  "We ensure better service for you with ",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
            Container(
                alignment: Alignment.center,
                child: Text(
                  "our ceritified service provider",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                )),
            SizedBox(
              height: 100,
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  "Need someone to serve ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                )),
            Container(
                alignment: Alignment.center,
                child: Text(
                  "You ? ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                )),
            SizedBox(
              height: 70,
            ),
            Container(
              width: 280,
              height: 50,
              margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(150)),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                },
                child: Text(
                  'Get started',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.black26;
                      }
                      return Colors.orange;
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
              ),
            )
          ]),
        ));
  }
}
