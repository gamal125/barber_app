
class ShopModel{
   String? uId;
   String? name;
   String? image;
   String? Location;



   ShopModel({
     this.name,
     this.uId,
     this.image,
     this.Location,


});

   ShopModel.fromjson(Map<String,dynamic>json){
     name=json['name'];
     uId=json['uId'];
     image=json['image'];
     Location=json['Location'];




   }
   Map<String,dynamic> Tomap(){
     return{
       'name':name,
       'uId':uId,
       'image':image,
       'Location':Location,




     };
   }


}