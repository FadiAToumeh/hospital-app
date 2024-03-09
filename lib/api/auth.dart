import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth
{
  bool isLoggedIn = false;


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
      var UID = res['data']['user']['id'].toString();
      var Uname =  res['data']['user']['name'];
      var Uemail =  res['data']['user']['email'];
      String token = json.decode(response.body)['data']['token'].toString();
      print(token);
      saveToken(token);
      saveUserData(Uname, Uemail, UID);
      print(UID.toString() + ' ' ":" " " + Uname);
      
    }
    else
    {
      throw(json.decode(response.body)['message']);
    }
  }



Future<void> signUp (String name , String email , String password) async
{
  var response = await http.post(Uri.parse('http://10.0.2.2:8000/api/register'),
     headers:headers ,
     body:json.encode(
      {
      'name' : name,
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
      var token = res['token'];
      saveToken(token);
      saveUserData(Uname, Uemail, UID);
     }
     else 
     {
      throw(json.decode(response.body)['message']);
     }
}



Future<void> logOut () async
{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  var response = await http.post(Uri.parse('http://10.0.2.2:8000/api/logout'),
     headers:{
        "Accept": "application/vnd.api+json",
        "Content-Type": "application/vnd.api+json",
        "Authorization": "Bearer $token",
     } ,);
     if (response.statusCode == 200)
     {
      prefs.setBool('isLoggedIn', false);
      prefs.remove('token');
     }
     else 
     {
      throw  (json.decode(response.body)['message']);
     }
}



void saveToken (String token) async
{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}



//Future<String> getToken () async 
//{
//  final SharedPreferences prefs = await SharedPreferences.getInstance();
//  String token =  prefs.getString('token').toString();
//  return token;
//}



void saveUserData (String name , String email , String id) async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('id', id);
    prefs.setBool('isLoggedIn', true);
  }
//void getUserData () async
//  {
//    final SharedPreferences prefs = await SharedPreferences.getInstance();
//    var name = prefs.getString('name');
//    var email = prefs.getString('email');
//    var id = prefs.getString('id');
//    print('$name'  '    '    '$email' '      ' "$id");
//  }
}
