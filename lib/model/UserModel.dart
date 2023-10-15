
class UserModel{
   String? email;
   String? uId;
   String? name;
   String? phone;
   String? image;
   String Latitude='';
   String Location='';
   String age='';
   bool? user=true;
   String Longitude='';
   String bonus='';

   UserModel({
     this.name,
     this.phone,
     this.uId,
     this.email,
     this.image,
     this.user,
     required this.Latitude,
     required this.Location,
     required this.age,
     required this.Longitude,
     required this.bonus,


});

   UserModel.fromjson(Map<String,dynamic>json){
     name=json['name'];
     phone=json['phone'];
     email=json['email'];
     uId=json['uId'];
     image=json['image'];
     Location=json['Location'];
     Latitude=json['Latitude'];
     Longitude=json['Longitude'];
     age=json['age'];
     user=json['user'];
     bonus=json['bonus'];




   }
   Map<String,dynamic> Tomap(){
     return{
       'name':name,
       'phone':phone,
       'email':email,
       'uId':uId,
       'image':image,
       'Location':Location,
       'Latitude':Latitude,
       'Longitude':Longitude,
       'age':age,
       'user':user,
       'bonus':bonus,




     };
   }


}