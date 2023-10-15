
class ShopOrderModel{
   String? shopname;
   String? barbername;
   String? stylename;
   String? price;
   String? customername;


   ShopOrderModel({
     this.stylename,
     this.price,
     this.barbername,
     this.shopname,
     this.customername,



});

   ShopOrderModel.fromjson(Map<String,dynamic>json){
     stylename=json['stylename'];
     price=json['price'];
     shopname=json['shopname'];
     barbername=json['barbername'];
     customername=json['customername'];





   }
   Map<String,dynamic> Tomap(){
     return{
       'stylename':stylename,
       'price':price,
       'shopname':shopname,
       'barbername':barbername,
       'customername':customername,





     };
   }


}