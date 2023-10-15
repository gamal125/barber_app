import 'package:barbers/components/components.dart';
import 'package:barbers/layout/Home_layout.dart';
import 'package:barbers/model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../components/constants.dart';
import '../../cubit/AppCubit.dart';
import '../../cubit/states.dart';

class OrderScreen extends StatelessWidget {
    const OrderScreen({super.key,required this.shopname,required this.barbername,required this.barberid,required this.model});
 final String shopname;
   final String barbername;
   final String barberid;
   final ProductModel model;


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
    var formkey = GlobalKey<FormState>();
    var timeController = TextEditingController();
    var dateController = TextEditingController();
    double vat=double.parse( model.price!)*.25;
    double total=vat+double.parse( model.price!);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {

          if(state is CreateOrderSuccessState)
          {
            navigateTo(context, Home_Layout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            key: _scaffoldkey,
              backgroundColor: kPrimaryColor,
              appBar:AppBar(
                leading: IconButton(onPressed: (){Navigator.pop(context);},icon: const Icon(Icons.arrow_back_outlined,color:Colors.white,),),
                backgroundColor: kPrimaryColor,elevation: 0,title: const Text('check out'),

              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [


                    Expanded(
                      child: Container(

                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black,),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(

                                children: [
                                  Text("shop name :",style: TextStyle(fontSize: 20,color: kPrimaryColor3),),
                                  SizedBox(width: 10,),
                                  Expanded(child: Text(shopname ,style: TextStyle(fontSize: 18,color: kPrimaryColor2),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                ],
                              ),
                              Row(

                                children: [
                                  Text("barber name :",style: TextStyle(fontSize: 20,color: kPrimaryColor3),),
                                  SizedBox(width: 10,),
                                  Text(barbername ,style: TextStyle(fontSize: 18,color:kPrimaryColor2),),
                                ],
                              ),
                              Row(

                                children: [
                                  Text("Style Name :",style: TextStyle(fontSize: 20,color: kPrimaryColor3),),
                                  SizedBox(width: 10,),
                                  Text(model.name! ,style: TextStyle(fontSize: 18,color: kPrimaryColor2),),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Expanded(child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black,),
                      child:Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Style price :",style: TextStyle(fontSize: 20,color: kPrimaryColor3),),
                                SizedBox(width: 10,),
                                Row(
                                  children: [
                                    Text("SAR",style: TextStyle(fontSize: 20,color: kPrimaryColor3),),
                                    SizedBox(width: 5,),
                                    Text(model.price! ,style: TextStyle(fontSize: 18,color: kPrimaryColor2),),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("vat :",style: TextStyle(fontSize: 20,color: kPrimaryColor3),),
                                SizedBox(width: 10,),
                                Row(
                                  children: [
                                    Text("SAR",style: TextStyle(fontSize: 20,color: kPrimaryColor3),),
                                    SizedBox(width: 5,),
                                    Text(vat.toString() ,style: TextStyle(fontSize: 18,color: kPrimaryColor2),),
                                  ],
                                ),
                              ],
                            ),
                            myDivider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total :",style: TextStyle(fontSize: 20,color: kPrimaryColor3),),
                                SizedBox(width: 10,),
                                Row(
                                  children: [
                                    Text("SAR",style: TextStyle(fontSize: 20,color: kPrimaryColor3),),
                                    SizedBox(width: 5,),
                                    Text(total.toString() ,style: TextStyle(fontSize: 18,color: kPrimaryColor2),),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ) ,
                    )),
                    SizedBox(height: 15,),
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black,),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  height: 20.0,
                                ),
                                const Text('Schedule',style: TextStyle(fontSize: 20,color: kPrimaryColor3),),
                                Form(
                                    key: formkey,

                                    child:
                                    Column(

                                      children: [
                                      defaultTextFormField(
                                        controller: timeController,
                                        keyboardType: TextInputType.datetime,
                                        onTap: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) {
                                            timeController.text =
                                                value!.format(context).toString();
                                            print(value.format(context));
                                          });
                                        },
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'time must not be empty';
                                          }
                                          return null;
                                        },
                                        label: 'Task Time',
                                        prefix: Icons.watch_later_outlined,
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      defaultTextFormField(
                                        controller: dateController,

                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.parse('2060-05-15'),
                                          ).then((value) {
                                            dateController.text =
                                                DateFormat.yMMMd().format(value!);
                                          });
                                        },
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'date must not be empty';
                                          }
                                          return null;
                                        },
                                        label: 'Task Date',
                                        prefix: Icons.calendar_today, keyboardType: TextInputType.datetime,
                                      )
                                    ],)
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                defaultMaterialButton(function: (){
                                  if(formkey.currentState!.validate()){
                                    AppCubit.get(context).createWaitingOrder(
                                        BarberId:barberid ,
                                        Barbarname: barbername,
                                        Shopname: shopname,
                                        CustomerId: AppCubit.get(context).ud,
                                        Customername: AppCubit.get(context).userdata!.name!,
                                        date: dateController.text,
                                        StyleName: model.name!,
                                        price: model.price!,
                                        time: timeController.text);
                                  }

                                }, text: 'Order',color: kPrimaryColor2),

                              ],
                            ),
                          ),
                        ),
                      ),
                    )


                  ],),
              ),
            );

        });



  }
}
