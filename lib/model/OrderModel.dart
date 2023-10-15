
class OrderModel{
   String? BarberId;
   String? Barbarname;
   String? Shopname;
   String? CustomerId;
   String? Customername;
   String? date;
   String? time;
   String? StyleName;
   String? price;




   OrderModel({
     this.Barbarname,
     this.BarberId,
     this.CustomerId,
     this.Shopname,
     this.Customername,
     this.date,
     this.time,
     this.StyleName,
     this.price,


});

   OrderModel.fromjson(Map<String,dynamic>json){
     Barbarname=json['Barbarname'];
     BarberId=json['BarberId'];
     CustomerId=json['CustomerId'];
     Shopname=json['Shopname'];
     Customername=json['Customername'];
     date=json['date'];
     time=json['time'];
     StyleName=json['StyleName'];
     price=json['price'];




   }
   Map<String,dynamic> Tomap(){
     return{
       'Barbarname':Barbarname,
       'BarberId':BarberId,
       'CustomerId':CustomerId,
       'Shopname':Shopname,
       'Customername':Customername,
       'date':date,
       'time':time,
       'StyleName':StyleName,
       'price':price,




     };
   }


}