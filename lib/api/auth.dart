import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hospital_app_flutter/models/user_model.dart';
import 'package:http/http.dart' as http;


class Auth
{
  final _userData = Hive.box('userData');


Map<String, String> get headers => {
        "Accept": "application/vnd.api+json",
        "Content-Type": "application/vnd.api+json",
        //"Authorization": "Bearer $token",
};

Future<void> signIn  (String email , String password) async
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
      final User user = User.fromJson(res['data']['user']);
      String token = json.decode(response.body)['data']['token'].toString();
      print(token);
      _userData.put('data' , [user.id , user.name , user.email , user.isDoctor]);
      _userData.put('token',token);
      //saveUserData(user.email, user.name, user.id.toString() , user.isDoctor);
      print(_userData.get('data'));
      
    }
    else
    {
      throw(json.decode(response.body)['message']);
    }
  }



Future<void> signUp (String name , String email , String password,int isDoctor) async
{
  var response = await http.post(Uri.parse('http://10.0.2.2:8000/api/register'),
     headers:headers ,
     body:json.encode(
      {
      'name' : name,
      'email' : email ,
      'password' : password,
      'password_confirmation':password,
      'isDoctor':isDoctor,
      }
      ),
     );
     if (response.statusCode == 200)
     {
      var res = json.decode(response.body);
      final User user = User.fromJson(res['data']['user']);
      var token = res['data']['token'];
      _userData.put('data', [user.id , user.name , user.email , user.isDoctor]);
      _userData.put('token' , token);
     }
     else 
     {
      throw(json.decode(response.body)['message']);
     }
}



Future<void> logOut () async
{
  String? token = _userData.get('token');
  var response = await http.post(Uri.parse('http://10.0.2.2:8000/api/logout'),
     headers:{
        "Accept": "application/vnd.api+json",
        "Content-Type": "application/vnd.api+json",
        "Authorization": "Bearer $token",
     } ,);
     if (response.statusCode == 200)
     {
      _userData.delete('token');
      _userData.delete('data');
     }
     else 
     {
      throw  (json.decode(response.body)['message']);
     }
}}