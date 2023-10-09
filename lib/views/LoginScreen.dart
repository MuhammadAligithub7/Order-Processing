import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:order_processing_app/utils/constants.dart';
import 'package:order_processing_app/views/ForgotPasswordScreen.dart';
import 'package:order_processing_app/views/SignupScreen.dart';

import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppConstants.appName,),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 250,
                width: 250,
                child: Lottie.asset('assets/Welcome.json',
                fit: BoxFit.cover,
                ),
              ),

              FadeInLeft(
                duration: const Duration(milliseconds: 1000),
                child: TextFormField(
                  controller: userEmailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )

                  ),
                ),
              ),

              const SizedBox(height: 10,),

              FadeInLeft(
                duration: const Duration(milliseconds: 1000),
                child: TextFormField(
                  controller: userPasswordController,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                      hintText: "Password",
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.password_outlined),
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                          child: obscureText? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_outlined)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )

                  ),
                ),
              ),

              const SizedBox(height: 20,),

              GestureDetector(
                onTap: (){
                  Get.to(const ForgotPasswordScreen());
                },
                child: FadeInRight(
                  duration: const Duration(milliseconds: 1000),
                  child: Container(
                      alignment: Alignment.topRight,
                      child: const Text(' Forgot Password ', style: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold),)),
                ),
              ),

              const SizedBox(height: 10,),

              FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: ElevatedButton(onPressed: () async {
                    var userEmail = userEmailController.text.trim();
                    var userPassword = userPasswordController.text.trim();
                    EasyLoading.show();
                    try{
                      final User? firebaseuser = (
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: userEmail, password: userPassword)).user;
                    if(firebaseuser !=null) {
                    Get.to(const HomeScreen());
                    EasyLoading.dismiss();
                    Fluttertoast.showToast(msg: "Login Successfully!");
                    }
                    }on FirebaseAuthException catch(e) {
                    Fluttertoast.showToast(msg: '$e');
                    EasyLoading.dismiss();
                    }
                  },
                      child: const Text(' Login '))),

              const SizedBox(height: 30,),

              GestureDetector(
                onTap: (){
                  Get.to(const SignupScreen());
                },
                child: FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: const Card(child: Text(' Don`t have an account !  SignUp ', style: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold),))),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
