
class ProductModel{
   String? price;
   String? name;
   String? image;




   ProductModel({
     this.name,
     this.price,
     this.image,



});

   ProductModel.fromjson(Map<String,dynamic>json){
     name=json['name'];
     price=json['price'];
     image=json['image'];





   }
   Map<String,dynamic> Tomap(){
     return{
       'name':name,
       'price':price,
       'image':image,





     };
   }


}