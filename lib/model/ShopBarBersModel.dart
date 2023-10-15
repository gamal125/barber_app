
class ShopBarBersModel{
   String? uId;
   String? name;
   String? image;
   String? price;

   ShopBarBersModel({
     this.name,
     this.uId,
     this.image,
     this.price,
});

   ShopBarBersModel.fromjson(Map<String,dynamic>json){
     name=json['name'];
     uId=json['uId'];
     image=json['image'];
     price=json['price'];

   }
   Map<String,dynamic> Tomap(){
     return{
       'name':name,
       'uId':uId,
       'image':image,
       'price':price,

     };
   }


}