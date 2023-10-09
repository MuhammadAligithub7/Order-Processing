import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:order_processing_app/views/LoginScreen.dart';

signUpUser( String userName, String userEmail, String userPassword) async {
  User? userid = FirebaseAuth.instance.currentUser;
  try{
    await FirebaseFirestore.instance.collection("users").doc(userid!.uid).set({
      'userName' : userName,
      'userEmail' : userEmail,
      'userPassword' : userPassword,
      'createdAt' : DateTime.now(),
      'userId' : userid.uid,
    }).then((value) => {
      FirebaseAuth.instance.signOut(),
      Get.to(const LoginScreen())
    });
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(msg: '$e');
  }
}