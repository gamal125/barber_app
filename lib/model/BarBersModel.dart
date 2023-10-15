
class BarBersModel{
   String? uId;
   String? name;
   String? image;
   String? price;
   String? longitude;
   String? latitude;




   BarBersModel({
     this.name,
     this.uId,
     this.image,
     this.price,
     this.longitude,
     this.latitude,


});

   BarBersModel.fromjson(Map<String,dynamic>json){
     name=json['name'];
     uId=json['uId'];
     image=json['image'];
     price=json['price'];
     longitude=json['longitude'];
     latitude=json['latitude'];




   }
   Map<String,dynamic> Tomap(){
     return{
       'name':name,
       'uId':uId,
       'image':image,
       'price':price,
       'longitude':longitude,
       'latitude':latitude,




     };
   }


}