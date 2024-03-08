import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hospital_app_flutter/screens/dashboard_screen.dart';
import 'package:hospital_app_flutter/screens/login_screen.dart';
import 'package:hospital_app_flutter/screens/test.dart';
import 'package:hospital_app_flutter/tree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0x1640D6).withOpacity(1)),
        useMaterial3: true,
      ),
      home: const WidgetTree(),
    );
  }
}