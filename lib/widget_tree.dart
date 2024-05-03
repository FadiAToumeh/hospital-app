import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hospital_app_flutter/screens/doctor_homescreen.dart';
import 'package:hospital_app_flutter/screens/login_screen.dart';
import 'package:hospital_app_flutter/screens/user_homescreen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  final _userData = Hive.box('userData');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: Hive.boxExists('userData'), builder: (context, snapshot) {
      if(_userData.get('token')==null)
      {
        return const LoginScreen();
      }
      else
      {
        return FutureBuilder(future: Hive.boxExists('userData'), builder:(context, snapshot) {
          if (_userData.get('data')[3]== 0)
          {
            return const DoctorHomeScreen();
          }
          else 
          {
          return const UserHomeScreen();
          }
        } );
      }
      
    },);
    
  }

  
}