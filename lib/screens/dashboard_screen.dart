import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List Menu = [
    "Medicines",
    "Lab Tests",
    "Consult Doctor",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GridView.builder(
        itemCount: Menu.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder:(context, index){
          return Column(
            children: [
              Container(
                height: 130,
            child: Card(
              color: Color(0x1640D6).withOpacity(0.6),
              child: Center(child: null),
            ),
          ),
          Text(Menu[index]),
            ],
          );
      } ,),
    );
  }
}