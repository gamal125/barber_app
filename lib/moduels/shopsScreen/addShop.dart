import 'package:barbers/components/constants.dart';
import 'package:barbers/layout/Home_layout.dart';
import 'package:barbers/shared/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../../cubit/AppCubit.dart';
import '../../cubit/states.dart';

class AddShopScreen extends StatelessWidget {


  final  formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final LocationController = TextEditingController();


  AddShopScreen({super.key});
  @override
  Widget build(BuildContext context) {


    var c= AppCubit.get(context);


    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

        if (state is CreateShopSuccessState) {

          navigateAndFinish(context, Home_Layout());

        }



      },
      builder: (context, state) {

        return Scaffold(
          backgroundColor: kPrimaryColor,
appBar: AppBar(iconTheme: const IconThemeData(color: kPrimaryColor2),backgroundColor: kPrimaryColor,elevation: 0,),
          body: GestureDetector(
            onTap: (){
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: (){
                            c.getImage2();
                          },
                          child: Container(
                            width: 150,
                            height: 150,

                            decoration: c.PickedFile2!=null?
                            BoxDecoration(
                                shape: BoxShape.circle, image: DecorationImage(image: FileImage(c.PickedFile2!),fit: BoxFit.cover))
                                : const BoxDecoration(

                                shape: BoxShape.circle,

                           image: DecorationImage(image: AssetImage('assets/icon/addimage.png'),fit: BoxFit.cover)


                            )
                            ,
                          ),
                        ) ,

                        Center(

                          child: Column(
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(top: 20.0,right: 20,left: 20,bottom:10),
                                child: Column(children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  defaultTextFormField(
                                    onTap: (){

                                    },
                                    controller: nameController,
                                    keyboardType: TextInputType.text,
                                    prefix: Icons.drive_file_rename_outline_sharp,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter shop name ';
                                      }
                                      return null;
                                    },
                                    label: 'Shop Name',
                                    hint: 'Enter your Shop name',
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  defaultTextFormField(
                                    onTap: (){

                                    },
                                    controller: LocationController,
                                    keyboardType: TextInputType.text,
                                    prefix: Icons.home,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Location';
                                      }
                                      return null;
                                    },
                                    label: 'Location',
                                    hint: 'Enter Location',
                                  ),


                                  SizedBox(
                                    height: 20,
                                  ),

                                  ConditionalBuilder(
                                    condition:state is! ImageintStates ,
                                    builder: ( context)=> Center(
                                      child: defaultMaterialButton(
                                        function: () {
                                        if (formKey.currentState!.validate()) {
                                          if(AppCubit.get(context).PickedFile2!=null){
                                            AppCubit.get(context).uploadShopImage(
                                              shopname: nameController.text,
                                              location: LocationController.text,
                                              publisher_id: 'GOh7JAOPyOdOc0mChNXZ9luB3mI3'

                                            );}
                                          else{
                                           showToast(text: 'insert image frist', state: ToastStates.error);
                                          }

                                        }

                                      }, text: 'Save', radius: 20, color: kPrimaryColor2,),
                                    ),
                                    fallback: (context)=>loading,),

                                  SizedBox(
                                    height: 20,
                                  ),

                                ]),
                              ),


                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
