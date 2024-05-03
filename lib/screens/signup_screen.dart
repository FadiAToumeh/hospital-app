// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app_flutter/api/auth.dart';
import 'package:hospital_app_flutter/constants/Colors.dart';
import 'package:hospital_app_flutter/screens/doctor_homescreen.dart';
import 'package:hospital_app_flutter/screens/user_homescreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Auth auth = Auth();
  bool isDoctor = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullnameController = TextEditingController();

  @override
  void dispose ()
  {
    super.dispose();
    fullnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Image.asset('assets/logo.png'),
           ),
         SizedBox(height: 20,),
         Text('Register' , style: GoogleFonts.notoSans(color: mainBlue,fontSize: 23 ) ,),  
         SizedBox(height: 40,),
         //full name
         Padding(
              padding: EdgeInsets.symmetric(horizontal:25,vertical: 14),
              child: TextField(
                autocorrect: false,
                controller: fullnameController,
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.5),
                  ),
                )
              ),
            ),
        //email
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
        //password
        Padding(
              padding: EdgeInsets.symmetric(horizontal:25,vertical: 14),
              child: TextField(
                obscureText: true,
                autocorrect: false,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.5),
                  ),
                )
              ),
            ),
            SizedBox(height: 10,),
            Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Patient', ),
                    Padding(
                      padding: EdgeInsets.all(13),
                      child: Switch(
                        value: isDoctor,
                        onChanged: (value) {
                          setState(() {
                            isDoctor = value;
                          });
                        },
                        activeTrackColor: mainBlue,
                        activeColor: Colors.white,
                      ),
                    ),
                    Text('Doctor', ),
                  ],
                ),
            SizedBox(height: 20,),
            //Sign Up , add funtions below 
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(mainBlue)),
              onPressed:() {
                try {
               if(isDoctor)
               {
                auth.signUp(fullnameController.text.trim(), emailController.text.trim(), passwordController.text.trim(), 1).then((value) => Get.off(()=>const DoctorHomeScreen()));
               }
               else
               {
                auth.signUp(fullnameController.text.trim(), emailController.text.trim(), passwordController.text.trim(), 0).then((value) => Get.off(()=>UserHomeScreen()));
               }
              } 
              catch (e) {
              ScaffoldMessenger.of(context).showSnackBar
                (SnackBar(content: Text('$e' , textAlign: TextAlign.center,),
                backgroundColor: Colors.red,
                padding: const EdgeInsets.all(15),
                ),
                );    
              }
              },
              child: Text("Sign Up" , style: TextStyle(color: Colors.white),)
              ),
        
          ],          
        ),
      ),
    );
  }
}