import 'package:barbers/components/constants.dart';
import 'package:barbers/cubit/AppCubit.dart';
import 'package:barbers/cubit/states.dart';
import 'package:barbers/model/OrderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAppointmentScreen extends StatelessWidget {
  const UserAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<OrderModel> models=[];
    models=AppCubit.get(context).acceptedOrders;
    return  BlocConsumer<AppCubit,AppStates>(
        listener:  (context,state)=>{},
        builder: (context,state)=>  Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            leading: IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(Icons.arrow_back_outlined,color:Colors.white,),),

            backgroundColor: kPrimaryColor,elevation: 0,title: Center(child: Text('My Orders')),),
          body:models.isNotEmpty?  ListView.builder(
              itemBuilder: (context,index)=>orderItem(models[index], context),
                  itemCount: models.length,
          ):const Center(child: Text('No Orders',style: TextStyle(color: kPrimaryColor2),)),
        ),
        );
  }
  Widget orderItem(OrderModel model,context)=>Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: kPrimaryColor3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
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


                ],
              ),
            ),
          ),


        ],
      ),
    ),
  );
}
