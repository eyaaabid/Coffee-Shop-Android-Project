import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/Signin.dart';
import 'package:flutter_app/reusable_widget.dart';
import 'package:flutter_app/home_Page.dart';
import 'package:flutter_app/users_firebase.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checked1 = false;
  bool checked2 = false;

  String? role;
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  TextEditingController _adressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              height: 350,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("img/register.png"), fit: BoxFit.fill)),
            ),
            Container(
                padding: const EdgeInsets.all(20),
                margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 250),
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
                  padding: EdgeInsets.fromLTRB(1, 1, 20, 0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                          child: Column(children: [
                        reusableTextField(
                            "Enter UserName",
                            "Please enter UserName",
                            Icons.person_outline,
                            false,
                            _userNameTextController),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextField(
                            "Enter Email Id",
                            "Please enter your email",
                            Icons.email,
                            false,
                            _emailTextController),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextField(
                            "Enter Password",
                            "Please enter your password",
                            Icons.lock_outlined,
                            true,
                            _passwordTextController),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextField(
                            "Confirm  Password",
                            "Please confirm your password",
                            Icons.lock_outlined,
                            true,
                            _confirmpasswordController),
                        const SizedBox(height: 20),
                        reusableTextField(
                            "Phone number ",
                            "Please Enter your phone number",
                            Icons.numbers,
                            true,
                            _phonenumberController),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextField(
                            "Adress  ",
                            "Please Enter your adress",
                            Icons.home,
                            true,
                            _adressController),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                "Are you a user ? ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Radio(
                                value: "user",
                                groupValue: role,
                                onChanged: (value) {
                                  setState(() {
                                    role = value.toString();
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text("Are you an Agent ?  ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Radio(
                                value: "agent",
                                groupValue: role,
                                onChanged: (value) {
                                  setState(() {
                                    role = value.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ])),
                      const SizedBox(height: 20),
                      firebaseUIButton(context, "Sign Up", () {
                        // if (_confirmpasswordController !=_passwordTextController)
                        // {

                        //   var confirm= const SnackBar(content: Text('Password and confirm password dont match ' ,

                        //   ) ,
                        //   backgroundColor: Colors.orange,

                        //   ) ;

                        //   ScaffoldMessenger.of(context).showSnackBar(confirm);
                        //   return;
                        // }
                        if (_confirmpasswordController.text.isEmpty ||
                            _passwordTextController.text.isEmpty ||
                            _phonenumberController.text.isEmpty) {
                          var snackBar = const SnackBar(
                              content: Text('Please verify your data '),
                              backgroundColor: Colors.orange);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                          userSetup(
                              _userNameTextController.text,
                              _passwordTextController.text,
                              _emailTextController.text,
                              _phonenumberController.text,
                              _adressController.text,
                              role);
                          var snackBar = const SnackBar(
                              content:
                                  Text('User has been created succefully  '),
                              backgroundColor: Colors.orange);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        }).onError((error, stackTrace) {
                          print("Error ${error.toString()}");
                        });
                      }),
                      const SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.orange),
                        child: const Text(
                          "Don't have an account ? Sign in ",
                          textAlign: TextAlign.end,
                          selectionColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ))),
          ],
        ));
  }
}
