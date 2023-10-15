import 'package:barbers/components/components.dart';
import 'package:barbers/cubit/AppCubit.dart';
import 'package:barbers/cubit/states.dart';
import 'package:barbers/model/OrderModel.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/constants.dart';

class DoneOrdersScreen extends StatefulWidget {
  const DoneOrdersScreen({super.key});

  @override
  State<DoneOrdersScreen> createState() => _DoneOrdersScreenState();
}

class _DoneOrdersScreenState extends State<DoneOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    List<OrderModel> orders=[];
    orders=AppCubit.get(context).DoneOrder;
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          leading: IconButton(onPressed: (){Navigator.pop(context);Navigator.pop(context);},icon: Icon(Icons.arrow_back_outlined,color:Colors.white,),),
          backgroundColor: kPrimaryColor,elevation: 0,title: const Center(child: Text('Accepted Orders')),),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Text('List of the orders',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
            ),
            Expanded(
              child: ConditionalBuilder(
                condition: state is GetDoneOrderSuccessState,
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
                                Center(child: defaultMaterialButton(function: (){

                                }, text: 'Done'))

                        ],
                      ),
                    ),


                  ],
                ),
              )),
        ),
      );

}
