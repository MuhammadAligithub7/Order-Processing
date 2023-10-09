import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:order_processing_app/utils/constants.dart';

import 'LoginScreen.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController forgotPasswordController = TextEditingController();

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
                  controller: forgotPasswordController,
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

              FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: ElevatedButton(onPressed: () async {
                    EasyLoading.show();
                    var forgotPassword = forgotPasswordController.text.trim();
                    try{
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: forgotPassword).then((value) => {
                        Fluttertoast.showToast(msg: "Check Your Email!"),
                        Get.offAll(const LoginScreen()),
                        EasyLoading.dismiss(),
                      });
                    } on FirebaseAuthException catch(e) {
                      Fluttertoast.showToast(msg: '$e');
                      EasyLoading.dismiss();
                    }
                  }, child: const Text(' Forgot '))),
            ],
          ),
        ),
      ),
    );
  }
}
