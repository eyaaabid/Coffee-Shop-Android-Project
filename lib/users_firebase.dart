import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
Future<void> userSetup(String name , String password , String email , String phonenumber , String adress , String? role)async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users'); 
  FirebaseAuth auth = FirebaseAuth.instance;
 
  users.add({
  'uid':users.id,
 'name' : name , 
'password' : password , 
'email' : email , 
'phonenumber' : phonenumber , 
'adress' : adress,
'role' : role

  }
  );
return;
}