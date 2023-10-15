import 'package:barbers/model/ShopBarBersModel.dart';
import 'package:barbers/moduels/shopsScreen/productsScreen.dart';
import 'package:barbers/moduels/shopsScreen/shopsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../components/constants.dart';
import '../../cubit/AppCubit.dart';
import '../../cubit/states.dart';
import '../../shared/local/cache_helper.dart';
import 'AddBarbersShop.dart';

class BarbersShopScreen extends StatefulWidget {
   BarbersShopScreen({super.key,required this.id,required this.name,required this.user});
String id;
String name;
   bool user;
   var ud=CacheHelper.getData(key: 'uId');
  @override
  State<BarbersShopScreen> createState() => _BarbersShopScreenState();
}

class _BarbersShopScreenState extends State<BarbersShopScreen> {
  List<ShopBarBersModel> shopBarbers=[];
  @override
  Widget build(BuildContext context) {
    shopBarbers=AppCubit.get(context).shopBarBers;

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is GetAllProductsShopState){
            navigateTo(context, ProductsScreen(shopname: widget.name, barbername: state.barbername, barberid: state.barberid,));
          }
          if(state is GetAllBarBersShopState){
            navigateTo(context, AddBarbersShopScreen(name: widget.name, id: widget.id,));
          }
          if(state is GetBarBersShopSuccessState)
          {

            setState(() {
              shopBarbers= AppCubit.get(context).shopBarBers;
            });
          }
        },
        builder: (context, state) {
          return
            widget.ud=='GOh7JAOPyOdOc0mChNXZ9luB3mI3'?
            Scaffold(
              backgroundColor: kPrimaryColor,
              appBar: AppBar(
                leading: IconButton(onPressed: (){  navigateTo(context, ShopsScreen());},icon: Icon(Icons.arrow_back),),
                backgroundColor: kPrimaryColor,elevation: 0,title: const Text('Barbers'),),
              body: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.0),
                    child: Text('List of the Barbers',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                  ),
                  ConditionalBuilder(
                    condition: state is! GetShopLoadingState,
                    builder:(context)=> shopBarbers.isNotEmpty?
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder:(context,index)=> shopsItem(shopBarbers[index],context) ,itemCount: shopBarbers.length,)
                        :const Text('no Barbers yet',style: TextStyle(color: Colors.white)),
                    fallback: (BuildContext context) { return loading;  },
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(onPressed: (){
                AppCubit.get(context).getallbarbers();
             },child: Icon(Icons.add,color: kPrimaryColor,),backgroundColor: kPrimaryColor2,),
            )
                :

            Scaffold(
              backgroundColor: kPrimaryColor,
              appBar: AppBar(
                leading: IconButton(onPressed: (){  navigateTo(context, ShopsScreen());},icon: Icon(Icons.arrow_back),),backgroundColor: kPrimaryColor,elevation: 0,title: const Text('Barbers'),),
              body: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.0),
                    child: Text('List of the Barbers',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                  ),
                  ConditionalBuilder(
                    condition: state is! GetShopLoadingState,
                    builder:(context)=> shopBarbers.isNotEmpty?
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder:(context,index)=> shopsItem(shopBarbers[index],context) ,itemCount: shopBarbers.length,)
                        :const Text('no Barbers yet',style: TextStyle(color: Colors.white),),
                    fallback: (BuildContext context) { return loading;  },
                  ),
                ],
              ),
            )
             ;
        });

  }
  Widget shopsItem(ShopBarBersModel model,context)=>
      AppCubit.get(context).ud=='GOh7JAOPyOdOc0mChNXZ9luB3mI3'?
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: InkWell(
          onTap: (){
            AppCubit.get(context).getproductsshop(widget.name,model.name!,model.uId!);
          },
          child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: kPrimaryColor3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10,),
                  Container(decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: NetworkImage(model.image!),fit: BoxFit.cover)),width: 100,height: 100,),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(model.name!,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(onPressed: (){
                              FirebaseFirestore.instance.collection('users').doc(model.uId).collection('shops').doc(widget.name).collection("barbers").doc(model.uId).delete().then((value) {
                                AppCubit.get(context).getbarbersshop(widget.id, widget.name,widget.user);
                              });
                            }, icon: const Icon(Icons.delete,color: Colors.red,))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ):

      widget.user?
  Padding(
    padding: const EdgeInsets.all(18.0),
    child: InkWell(
      onTap: (){
AppCubit.get(context).getproductsshop(widget.name,model.name!,model.uId!);
      },
      child: Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: kPrimaryColor3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10,),
              model.image!=''?     Container(decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: NetworkImage(model.image!),fit: BoxFit.cover)),width: 100,height: 100,):CircleAvatar(backgroundImage: AssetImage('assets/icon/man2.png'),radius: 80,),
              SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(model.name!,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),

                ],
              ),
            ],
          )),
    ),
  ):
  Padding(
  padding: const EdgeInsets.all(18.0),
  child: InkWell(
  onTap: (){

  },
  child: Container(
  height: 120,
  width: double.infinity,
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: kPrimaryColor3),
  child: Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
  SizedBox(width: 10,),
  Container(decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: NetworkImage(model.image!),fit: BoxFit.cover)),width: 100,height: 100,),
  SizedBox(width: 20,),
  Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,

  children: [
  Text(model.name!,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),

  ],
  ),
  ],
  )),
  ),
  );
}
