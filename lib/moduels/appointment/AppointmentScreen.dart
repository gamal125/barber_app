import 'package:barbers/components/components.dart';
import 'package:barbers/cubit/AppCubit.dart';
import 'package:barbers/cubit/states.dart';
import 'package:barbers/model/OrderModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/constants.dart';
import 'DoneOrders.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    List<OrderModel> orders=[];
    orders=AppCubit.get(context).waitingOrder;
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          if(state is GetDoneOrderSuccessState){
            navigateTo(context, const DoneOrdersScreen());
          }
          if(state is GetOneSuccessStates){
            AppCubit.get(context).createOrder(
                BarberId: state.BarberId,
                Barbarname: state.Barbarname,
                Shopname: state.Shopname,
                CustomerId: state.CustomerId,
                Customername: state.Customername,
                date: state.date,
                StyleName: state.StyleName,
                price: state.price,
                time: state.time,
                bonus: state.bonus);
          }
          if(state is CreateShopOrderSuccessState) {
            AppCubit.get(context).getWaitingOrder();
          }
          if(state is GetWaitingOrderSuccessState) {
           setState(() {
             orders=AppCubit.get(context).waitingOrder;
           });
          }

        },
        builder: (context,state){return Scaffold(
backgroundColor: kPrimaryColor,
          appBar: AppBar(
            leading: IconButton(onPressed: (){Navigator.pop(context);},icon: const Icon(Icons.arrow_back_outlined,color:Colors.white,),),
            actions: [IconButton(onPressed: (){AppCubit.get(context).getDoneOrder(); }, icon: Icon(Icons.calendar_month))],
            backgroundColor: kPrimaryColor,elevation: 0,title: const Center(child: Text('Orders')),),
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: Text('List of the orders',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
              ),
              Expanded(
                child: ConditionalBuilder(
                  condition: state is GetWaitingOrderSuccessState,
                  builder:(context)=> orders.isNotEmpty?
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder:(context,index)=> shopsItem(orders[index],context) ,itemCount: orders.length,)
                      :const Center(child: Text('no items',style: TextStyle(fontSize: 25,color: kPrimaryColor2),)),
                  fallback: (BuildContext context) { return loading;  },
                ),
              ),
            ],
          ),
        );}, );
  }

  Widget shopsItem(OrderModel model,context)=>
  Padding(
    padding: const EdgeInsets.all(18.0),
    child: InkWell(
      onTap: (){



      },
      child: Container(

          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: kPrimaryColor3),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        Text('Shop Name : ',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                        Expanded(child: Text(model.Shopname!,style: TextStyle(fontSize: 15,color: kPrimaryColor,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),maxLines: 1,)),

                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        const Text('Customer Name : ',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis),
                        Expanded(child: Text(model.Customername!,style: TextStyle(fontSize: 15,color: kPrimaryColor,fontWeight: FontWeight.bold,),maxLines: 1,overflow: TextOverflow.ellipsis)),

                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        const Text('Style Name : ',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                        Expanded(child: Text(model.StyleName!,style: TextStyle(fontSize: 15,color: kPrimaryColor,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),maxLines: 1,)),

                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        const Text('Price : ',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                        Expanded(child: Text(model.price!,style: TextStyle(fontSize: 15,color:kPrimaryColor,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),maxLines: 1,)),

                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        const Text('Time : ',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                        Expanded(child: Text(model.time!,style: TextStyle(fontSize: 15,color: kPrimaryColor,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),maxLines: 1,)),

                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        const Text('Date : ',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                        Expanded(child: Text(model.date!,style: TextStyle(fontSize: 15,color: kPrimaryColor,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),maxLines: 1,)),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        defaultMaterialButton3(function: (){
                          FirebaseFirestore.instance.collection("users").doc(model.BarberId).collection('waiting').doc(model.CustomerId).delete().then((value) =>
                              AppCubit.get(context).getWaitingOrder());

                        }, text: 'Decline',color: Colors.red),
                        defaultMaterialButton3(function: (){
                          AppCubit.get(context).getOneUser(
                              BarberId: model.BarberId!,
                              Barbarname:  model.Barbarname!,
                              Shopname:  model.Shopname!,
                              CustomerId:  model.CustomerId!,
                              Customername:  model.Customername!,
                              date: model.date!,
                              StyleName:  model.StyleName!,
                              price:  model.price!,
                              time: model.time!,
                             );
                        }, text: 'Accept',color: Colors.green),

                      ],
                    )

                  ],
                  ),
                ),


              ],
            ),
          )),
    ),
  );

}
