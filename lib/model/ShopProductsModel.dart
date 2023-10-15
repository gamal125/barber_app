
class ShopProductsModel{
   String? uId;
   String? name;
   String? image;
   String? price;




   ShopProductsModel({
     this.name,
     this.uId,
     this.image,
     this.price,


});

   ShopProductsModel.fromjson(Map<String,dynamic>json){
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