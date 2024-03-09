// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app_flutter/constants/Colors.dart';
import 'package:hospital_app_flutter/screens/dashboard_screen.dart';
import 'package:hospital_app_flutter/screens/signup_screen.dart';
import 'package:hospital_app_flutter/api/auth.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Auth auth =  Auth();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
           Container(
            height: MediaQuery.of(context).size.height*0.35,
            width: double.infinity,
            decoration: BoxDecoration(
              color: mainBlue,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
            ),
            child: Image.asset('assets/logo.png',),
           ),
            const SizedBox(height: 20,),
            Text('Login' , style: GoogleFonts.notoSans(color: mainBlue,fontSize: 23 ) ,),
            const SizedBox(height: 60,),
            //Email
            Padding(
              padding: EdgeInsets.symmetric(horizontal:25,vertical: 14),
              child: TextField(
                autocorrect: false,
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.5),
                  ),
                )
              ),
            ),
            //Password
            Padding(
              padding: EdgeInsets.symmetric(horizontal:25,vertical: 14),
              child: TextField(
                autocorrect: false,
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.5),
                  ),
                )
              ),
            ),
            SizedBox(height:70),
            //sign in button
            ElevatedButton(onPressed: () async{
              try{
                await auth.signIn(emailController.text, passwordController.text).then((value) => Get.off(DashboardScreen()));
              }
              catch(e){
                ScaffoldMessenger.of(context).showSnackBar
                (SnackBar(content: Text('$e' , textAlign: TextAlign.center,),
                backgroundColor: Colors.red,
                padding: const EdgeInsets.all(15),
                )
              );
              } 
              
            }, // sign in logic here,
             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(mainBlue)),
             child: Text("Sign In", style: GoogleFonts.notoSans(color: Colors.white)),
             ),  
             //dont have an account button
             TextButton(onPressed:()=> Get.to(()=>SignUpScreen(),
             transition:Transition.rightToLeft),
              child: Text("Don't have an account ? Sign Up",
               style: TextStyle(color: mainBlue),),
             )
          ],
        ),
      ),
    );
  }
}