import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      var UID = res['data']['user']['id'];
      var Uname =  res['data']['user']['name'];

      print(UID.toString() + ' ' ":" " " + Uname);
      
    }
    else
    {
      print('failed');
    }
  }
}