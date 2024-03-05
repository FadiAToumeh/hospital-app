import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}


class _TestScreenState extends State<TestScreen> {
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();


  Map<String, String> get headers => {
        "Accept": "application/vnd.api+json",
        "Content-Type": "application/vnd.api+json",
      };
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'email'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(hintText: 'password'),
          ),
          ElevatedButton(
            onPressed: () async{
              await signin(emailController.text,passwordController.text);
            },
            child: Text('Test')),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: ()=> getUserData(), child: Text('show info')),
        ],
        
      ),
    );
  }
  Future<void> signin  (String email , String password) async
  {
    var response = await http.post(Uri.parse('http://10.0.2.2:8000/api/login'),
     headers:headers ,
     body:json.encode(
      {
      'email' : email ,
      'password' : password
      }
      ),
     );
    if (response.statusCode == 200)
    {
      var res = json.decode(response.body);
      var UID = res['data']['user']['id'].toString();
      var Uname =  res['data']['user']['name'];
      var Uemail =  res['data']['user']['email'];
      userData(Uname, Uemail, UID);

      print(UID.toString() + ' ' ":" " " + Uname);
      
    }
    else
    {
      print('failed');
    }
  }
  void userData (String name , String email , String id) async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('id', id);
  }
  void getUserData () async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var name =await prefs.getString('name');
    var email = await prefs.getString('email');
    var id = prefs.getString('id');
    print('$name'  '    '    '$email' '      ' "$id");
  }
}