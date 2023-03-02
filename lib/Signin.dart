import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/palette.dart';
import 'package:flutter_app/reusable_widget.dart';
import 'package:flutter_app/home_Page.dart';
import 'package:flutter_app/ResetPassword.dart';
import 'package:flutter_app/SignUp.dart';
import 'package:flutter_app/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/verification_otp.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_app/otp_verif.dart';
import 'package:intl_phone_field/phone_number.dart';

import 'data_manager.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  final CollectionReference _user =
      FirebaseFirestore.instance.collection("Users");
  bool loading = false;
  String phoneNumber = "+21658975985";
  
  void SendOtpCode() {
    loading = true;
    setState(() {});

    final _auth = FirebaseAuth.instance;
    if (phoneNumber.isNotEmpty) {
      authwithphonenumber(phoneNumber, onCodeSend: (verificationId, v) {
        loading = false;
        setState(() {});

        Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => VerificationOtp(
                VerificationId: verificationId, phoneNumber: phoneNumber)));
      }, onAuthVerify: (v) async {
        await _auth.signInWithCredential(v);
      }, onFailed: (e) {
        print("wrong code !!");
      }, autoRetrieval: (v) {});
    }
  }

  List<String> docIDs = [];
  var documentID;
  String id = "";

  Future getDocIDs() async {
    await FirebaseFirestore.instance.collection('Users').get().then(
          (snapshot) => snapshot.docs.forEach((doc) {
            print(doc.reference.id);
            docIDs.add(doc.reference.id);
          }),
        );
  }

  Future getDocID() async {
    try {
      var collection = FirebaseFirestore.instance.collection('Users');
      var querySnapshots = await collection.get();
      for (var snapshot in querySnapshots.docs) {
        documentID = snapshot.id;
        id = documentID.toString();
      }
      ;
    } catch (e) {
      e.toString();
      print("id2 = " + id);
      return "id3 = " + id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: 350,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("img/Rectangle.png"),
            fit: BoxFit.fill,
          )),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 300),
          height: 700,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5),
              ]),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Email", "Please Enter Email",
                      Icons.mail_outline, false, _emailTextController),
                  const SizedBox(height: 20),
                  reusableTextField("Enter Password", "Please Enter Password",
                      Icons.lock_outline, true, _passwordTextController),
                  const SizedBox(
                    height: 5,
                  ),
                  forgetPassword(context),
                  firebaseUIButton(context, "Sign In", () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text,
                    )
                        .then((value) async {
                      loading ? null : SendOtpCode();

                      // Navigator.push(context,
                      //  MaterialPageRoute(builder: (context) => SendOtpCode));
                    }).onError((error, stackTrace) async {
                      print("Error ${error.toString()}");
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                      TextFormField(
                        validator: (val) => val!.isEmpty ? 'Enter Email' : null,
                        onChanged: (val) {
                          if (mounted) {
                            setState(() => _emailTextController.text =
                                val); //the email will trow to String that will give to firebaseAuth
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                      );
                    });
                  }),
                  signUpOption()
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.orange)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.orange),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
      // ignore: dead_code
    );
  }

  Positioned buildTextButton(
      IconData icon, String title, Color backgroundColor) {
    return Positioned(
      top: MediaQuery.of(context).size.height - 100,
      right: 0,
      left: 0,
      child: Column(
        children: [
          Text("Or Signin with"),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTextButton(
                    Icons.facebook, "Facebook", Palette.facebookColor),
                buildTextButton(MaterialCommunityIcons.google_plus, "Google",
                    Palette.googleColor),
              ],
            ),
          )
        ],
      ),
    );
  }
}
