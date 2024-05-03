class User 
{
 final int id;
 final String name;
 final String email;
 final int isDoctor;
  
  
  User({required this.name , required this.email,required this.id , required this.isDoctor});
      
factory User.fromJson(Map<String , dynamic> json)=>User(
  name: json['name'],
  email: json['email'],
  id: json['id'],
  isDoctor: json['isDoctor'],
   );
  
Map<dynamic , dynamic> toJson () 
{
  return
  {
    "id" : id,
    "name" : name,
    "email" : email ,
    "isDoctor" : isDoctor,
  };
}
   
}