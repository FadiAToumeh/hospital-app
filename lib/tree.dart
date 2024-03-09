import 'package:flutter/material.dart';
import 'package:hospital_app_flutter/screens/dashboard_screen.dart';
import 'package:hospital_app_flutter/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});
  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: check(), builder: (context, snapshot) {
      if(snapshot.data!='null')
      {
        return const DashboardScreen();
      }
      else
      {
        return const LoginScreen();
      }
      
    },);
    
  }
  Future check () async
  {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? value =  prefs.getString('token').toString();
     return value;
  }
}