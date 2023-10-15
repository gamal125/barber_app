import 'package:barbers/components/components.dart';
import 'package:barbers/components/constants.dart';
import 'package:barbers/moduels/shopsScreen/BarbersInShopScreen.dart';
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

class ShopsScreen extends StatefulWidget {
   ShopsScreen({super.key});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {


  @override
  Widget build(BuildContext context) {
    List<ShopModel> shops=[];
    shops=AppCubit.get(context).shops;

    var ud=CacheHelper.getData(key: 'uId');
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is GetBarBersShopSuccessState){
            navigateTo(context, BarbersShopScreen(id: state.id, name: state.name,user: state.user,));
          }
          if(state is GetShopSuccessState)
          {


                      setState(() {
                        shops= AppCubit.get(context).shops;

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

              backgroundColor: kPrimaryColor,elevation: 0,title: Text('SHOPS'),),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text('List of the shops',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: state is! GetShopLoadingState,
                    builder:(context)=> shops.isNotEmpty?
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder:(context,index)=> shopsItem(shops[index],context,true) ,itemCount: shops.length,)
           :Text('no items'),
                    fallback: (BuildContext context) { return loading;  },
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(onPressed: (){navigateTo(context, AddShopScreen());},child: Icon(Icons.add,color: kPrimaryColor,),backgroundColor: kPrimaryColor2,),
          )
              :
          AppCubit.get(context).userdata!.user!?
          Scaffold(
            backgroundColor: kPrimaryColor,
            appBar: AppBar(
              leading: IconButton(onPressed: (){navigateAndFinish(context, Home_Layout());},icon: Icon(Icons.arrow_back_outlined,color:Colors.white,),),

              backgroundColor: kPrimaryColor,elevation: 0,title: Text('SHOPS'),),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text('List of the shops',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: state is! GetShopLoadingState,
                    builder:(context)=> shops.isNotEmpty?
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder:(context,index)=> shopsItem(shops[index],context,true) ,itemCount: shops.length,)
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
              backgroundColor: kPrimaryColor,elevation: 0,title: Text('SHOPS'),),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Text('List of the shops',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: state is! GetShopLoadingState,
                    builder:(context)=> shops.isNotEmpty?
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder:(context,index)=> shopsItem(shops[index],context,false) ,itemCount: shops.length,)
                        :Text('no items'),
                    fallback: (BuildContext context) { return loading;  },
                  ),
                ),
              ],
            ),
          );
        });

  }
  Widget shopsItem(ShopModel model,context,bool user)=>AppCubit.get(context).userdata!.uId=='GOh7JAOPyOdOc0mChNXZ9luB3mI3'?
  Padding(
    padding: const EdgeInsets.all(18.0),
    child: InkWell(
      onTap: (){

        AppCubit.get(context).getbarbersshop(model.uId!, model.name!,user);

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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(model.name!,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                        IconButton(onPressed: (){
                          FirebaseFirestore.instance.collection('users').doc(model.uId).collection('shops').doc(model.name).delete().then((value) {
                            AppCubit.get(context).getAllWorkShops();
                          });
                        }, icon: const Icon(Icons.delete,color: Colors.red,))

                      ],
                    ),
                    Text(model.Location!,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ],
          )),
    ),
  ):Padding(
    padding: const EdgeInsets.all(18.0),
    child: InkWell(
      onTap: (){

        AppCubit.get(context).getbarbersshop(model.uId!, model.name!,user);

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(model.name!,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),

                    ],
                  ),
                  Text(model.Location!,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                ],
              ),
            ],
          )),
    ),
  );
}
