import 'package:barbers/components/constants.dart';
import 'package:barbers/layout/Home_layout.dart';
import 'package:barbers/model/UserModel.dart';
import 'package:barbers/shared/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../../cubit/AppCubit.dart';
import '../../cubit/states.dart';

class AddBarbersShopScreen extends StatelessWidget {


  final  formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final PriceController = TextEditingController();

      final String name;
     final String id;
  AddBarbersShopScreen({super.key,required this.name,required this.id});
  @override
  Widget build(BuildContext context) {


    var c= AppCubit.get(context);
    List<UserModel> BarBers=[];
      BarBers= c.AllBarbers;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

        if (state is CreateBarbersShopSuccessState) {

          navigateAndFinish(context, Home_Layout());

        }
        if (state is ImageSuccessStates) {



        }
        if (state is UpdateProductSuccessStates) {



        }

      },
      builder: (context, state) {

        return Scaffold(
          backgroundColor: kPrimaryColor,
appBar: AppBar(iconTheme: const IconThemeData(color: kPrimaryColor2),backgroundColor: kPrimaryColor,elevation: 0,),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConditionalBuilder(
              condition: state is GetAllBarBersShopState,
              builder:(context)=> BarBers.isNotEmpty?
              SingleChildScrollView(
                child: Column(
                  children: [
                    BarBers.isNotEmpty?   Text('Select BarBer from List',style: TextStyle(color: Colors.white),):Text(''),
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder:(context,index)=> shopsItem(BarBers[index],context,) ,itemCount: BarBers.length,),
                  ],
                ),
              )
                  :Text('no BarBers'),
              fallback: (BuildContext context) { return loading;  },
            ),
          ),
        );
      },
    );
  }
  Widget shopsItem(UserModel model,context,)=>Padding(
    padding: const EdgeInsets.all(18.0),
    child: InkWell(
      onTap: (){

        AppCubit.get(context).createBarbersShop(
            barbername:model.name!,
            barber_id: model.uId!,
            image: model.image!,
            uId: id,
            name: name,
            price: '');

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
                  Text(model.Location,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                ],
              ),
            ],
          )),
    ),
  );
}
