import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hospital_app_flutter/api/auth.dart';
import 'package:hospital_app_flutter/constants/colors.dart';
import 'package:hospital_app_flutter/screens/login_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final _userData = Hive.box('userData');
  final auth = Auth();
  String? username ;
  String? email ;
  @override 
  void initState ()
  {
    super.initState();
    username = _userData.get('data')[1];
    email = _userData.get('data')[2];
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
        title: Text("User Dashboard"),
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
              child: MaterialButton(onPressed: () async{
                try {
                 await auth.logOut().then((value) => Get.off(const LoginScreen()));
                 setState(() {
                   
                 });
                } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar
                (SnackBar(content: Text('$e' , textAlign: TextAlign.center,),
                backgroundColor: Colors.red,
                padding: const EdgeInsets.all(15),
                )
              );
                }
              } , 
              child: Text("Sign Out"),color: mainBlue,textColor: Colors.white,),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children:<Widget> [
            const SizedBox( height: 25 ,),
            Container(
              margin:const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration( 
                color: mainBlue,
                borderRadius:BorderRadius.circular(12.5),
              ),
              height: MediaQuery.of(context).size.height*0.2,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                  children: [
                    Text('image or something else'),
                    Text('data to write',style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items:items ,
      backgroundColor: mainBlue,
      ),
    );
    
  }
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.ac_unit_rounded), label: '1'),
    BottomNavigationBarItem(icon: Icon(Icons.zoom_out), label: '2'),
    BottomNavigationBarItem(icon: Icon(Icons.dangerous_rounded), label: '3'),

  ];
}