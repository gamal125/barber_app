import 'package:barbers/components/components.dart';
import 'package:barbers/components/constants.dart';
import 'package:barbers/model/ProductModel.dart';
import 'package:barbers/moduels/shopsScreen/BarbersInShopScreen.dart';
import 'package:barbers/moduels/shopsScreen/addProduct.dart';
import 'package:barbers/moduels/shopsScreen/addShop.dart';
import 'package:barbers/shared/local/cache_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/AppCubit.dart';
import '../../cubit/states.dart';
import '../../layout/Home_layout.dart';
import '../../model/ShopModel.dart';
import 'order.dart';

class ProductsScreen extends StatefulWidget {
   const ProductsScreen({super.key,required this.shopname,required this.barbername,required this.barberid});
   final String shopname;
   final String barbername;
   final String barberid;
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductModel> products=[];

  @override
  Widget build(BuildContext context) {
    products=AppCubit.get(context).products;

    var ud=CacheHelper.getData(key: 'uId');
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {

          if(state is GetAllProductsShopState)
          {


            setState(() {
              products= AppCubit.get(context).products;

            });
          }
        },
        builder: (context, state) {
          return
            ud=='GOh7JAOPyOdOc0mChNXZ9luB3mI3'?
          Scaffold(
            backgroundColor: kPrimaryColor,
            appBar: AppBar(
              leading: IconButton(onPressed: (){navigateAndFinish(context, Home_Layout());},icon: Icon(Icons.arrow_back_outlined,color:Colors.white,),),

              backgroundColor: kPrimaryColor,elevation: 0,title: Text('Products'),),
            body: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: Text('List of the Products',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: state is! GetProductsShopLoadingState,
                    builder:(context)=> products.isNotEmpty?
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder:(context,index)=> productsItem(products[index],context,true) ,itemCount: products.length,)
           :Text('no items'),
                    fallback: (BuildContext context) { return loading;  },
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(onPressed: (){navigateTo(context, AddProductScreen(shopname: widget.shopname));},child: Icon(Icons.add,color: kPrimaryColor,),backgroundColor: kPrimaryColor2,),
          )
              :
          AppCubit.get(context).userdata!.user!?
          Scaffold(
            backgroundColor: kPrimaryColor,
            appBar: AppBar(
              leading: IconButton(onPressed: (){navigateAndFinish(context, Home_Layout());},icon: Icon(Icons.arrow_back_outlined,color:Colors.white,),),

              backgroundColor: kPrimaryColor,elevation: 0,title: Text('Products'),),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text('List of the Products',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: state is! GetProductsShopLoadingState,
                    builder:(context)=> products.isNotEmpty?
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder:(context,index)=> productsItem(products[index],context,true) ,itemCount: products.length,)
                        :Text('no items'),
                    fallback: (BuildContext context) { return loading;  },
                  ),
                ),
              ],
            ),
          ) : Scaffold(
            backgroundColor: kPrimaryColor,
            appBar: AppBar(
              leading: IconButton(onPressed: (){navigateAndFinish(context, Home_Layout());},icon: Icon(Icons.arrow_back_outlined,color:Colors.white,),),
              backgroundColor: kPrimaryColor,elevation: 0,title: Text('Products'),),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text('List of the Products',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: state is! GetProductsShopLoadingState,
                    builder:(context)=> products.isNotEmpty?
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder:(context,index)=> productsItem(products[index],context,false) ,itemCount: products.length,)
                        :Text('no items'),
                    fallback: (BuildContext context) { return loading;  },
                  ),
                ),
              ],
            ),
          );
        });

  }
  Widget productsItem(ProductModel model,context,bool user)=>Padding(
    padding: const EdgeInsets.all(18.0),
    child: InkWell(
      onTap: (){
       if( AppCubit.get(context).userdata!.uId != 'GOh7JAOPyOdOc0mChNXZ9luB3mI3') {
         if (user) {
           navigateTo(context, OrderScreen(
             shopname:widget.shopname ,
             barbername: widget.barbername,
             barberid: widget.barberid,
             model: model,

           ));

         }
       }
      },
      child: Container(
        height: 120,
        width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: kPrimaryColor3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10,),
         model.image!=''?     Container(decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: NetworkImage(model.image!),fit: BoxFit.cover)),width: 100,height: 100,):CircleAvatar(backgroundImage: AssetImage('assets/icon/man2.png'),radius: 80,),
              const SizedBox(width: 20,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(model.name!,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),

                        AppCubit.get(context).userdata!.uId == 'GOh7JAOPyOdOc0mChNXZ9luB3mI3'?  IconButton(onPressed: (){
                          FirebaseFirestore.instance.collection('users').doc('GOh7JAOPyOdOc0mChNXZ9luB3mI3').collection('shops').doc(widget.shopname).collection('products').doc(model.name).delete().then((value) {
                            AppCubit.get(context).getproductsshop(widget.shopname, widget.barbername,widget.barberid);
                          });
                        }, icon: const Icon(Icons.delete,color: Colors.red,)):Text(''),

                      ],
                    ),
                    Text(model.price!,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ],
          )),
    ),
  );
}
