import 'package:flutter/material.dart';
import 'package:hospital_app_flutter/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? username = '';
  String? email = '';
  @override 
  void initState ()
  {
    super.initState();
    getData();
  }
  void getData () async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = await prefs.getString('name');
    email = await prefs.getString('email');
  }
  List Menu = [
    "Medicines",
    "Lab Tests",
    "Consult Doctor",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(accountName: Text('$username'), accountEmail: Text("$email"),
            decoration: BoxDecoration(color: mainBlue),
            ),
            //add logout function here
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:50),
              child: MaterialButton(onPressed: ()=> null , child: Text("Sign Out"),color: mainBlue,textColor: Colors.white,),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: GridView.builder(
        itemCount: Menu.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder:(context, index){
          return Column(
            children: [
              Container(
                height: 100,
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