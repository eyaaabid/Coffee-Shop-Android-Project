import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/widgets/media_query.dart';
import 'package:flutter_app/Splash_Screen.dart';

import 'Signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBTnUfti5ktKGDs2Llfg9a5QnVl3d8ejWM',
          appId: '1:530548654573:android:a107ce38547a762c7f27e4',
          messagingSenderId: '530548654573',
          projectId: 'fir-flutter-sos-home'));

  runApp(MaterialApp(home: Splashscreen()));
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SignIn ',
      home: Splashscreen(),
    );
  }
}

//class SignInScreen extends StatelessWidget {
  //const SignInScreen({super.key});

 // @override
 // Widget build(BuildContext context) {
   // return Scaffold(
     //   body: Container(
      //width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height * 0.4,
    //));
  //}
//}
