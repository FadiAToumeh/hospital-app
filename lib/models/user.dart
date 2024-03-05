class User 
{
  String id;
  String name;
  String email;
  
  
  User({required this.name , required this.email,required this.id});

  User.fromJson(Map<String , dynamic> json)
  :
    id = json['id'],
    name = json['name'],
    email = json['email'];
    
  
}