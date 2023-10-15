import 'package:barbers/components/constants.dart';
import 'package:barbers/moduels/profileScreens/profile.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../../cubit/AppCubit.dart';
import '../../cubit/states.dart';

class UpdateProfileScreen extends StatelessWidget {


  final  formKey = GlobalKey<FormState>();
  final imageController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final LocationController = TextEditingController();
  final AgeController = TextEditingController();

  UpdateProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {


    var c= AppCubit.get(context);
    imageController.text=c.userdata!.image!;
    nameController.text=c.userdata!.name!;
    phoneController.text=c.userdata!.phone!;
    LocationController.text=c.userdata!.Location;
    AgeController.text=c.userdata!.age;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {


        if (state is ImageSuccessStates) {
          c.getUser(c.userdata!.uId!);


        }
        if (state is UpdateProfileSuccessStates) {
          c.getUser(c.userdata!.uId!);


        }
        if (state is GetUserSuccessStates) {

          navigateAndFinish(context, ProfileScreen());

        }

      },
      builder: (context, state) {
        var imageo=c.userdata!.image!;
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
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Container(
                              width: 150,
                              height: 150,

                              decoration: c.PickedFile2!=null?
                              BoxDecoration(color: Colors.orange,
                                  shape: BoxShape.circle, image: DecorationImage(image: FileImage(c.PickedFile2!),fit: BoxFit.cover))
                                  : BoxDecoration(
                                color: Colors.orange,
                                  shape: BoxShape.circle,
                                  image: imageo==''?
                              DecorationImage(image: AssetImage('assets/icon/man2.png'),fit: BoxFit.cover):
                              DecorationImage(image: NetworkImage(imageo),fit: BoxFit.cover )

                              )
                              ,
                            ),
                            Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),   border: Border.all(
                                  color: kPrimaryColor,
                                  width: 7,
                                ),                           color: kPrimaryColor2,
                                ),
                                child: IconButton( onPressed: (){ c.getImage2(); }, icon: Icon(Icons.add_a_photo,color: Colors.white,size: 20,))),
                          ],
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
                                        return 'Please enter name ';
                                      }
                                      return null;
                                    },
                                    label: 'User Name',
                                    hint: 'Enter your name',
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),

                                  ////////////////////
                                  defaultTextFormField(
                                    onTap: (){

                                    },
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    prefix: Icons.phone,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter phone';
                                      }
                                      return null;
                                    },
                                    label: 'phone',
                                    hint: 'Enter phone',
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
                                  defaultTextFormField(
                                    onTap: (){

                                    },
                                    controller: AgeController,
                                    keyboardType: TextInputType.number,
                                    prefix: Icons.person,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Age';
                                      }
                                      return null;
                                    },
                                    label: 'Age',
                                    hint: 'Enter Age',
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
                                            AppCubit.get(context).uploadProfileImage(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              location: LocationController.text,
                                              age: AgeController.text,
                                              email: AppCubit.get(context).userdata!.email!,
                                            );}
                                          else{
                                            AppCubit.get(context).updateProfile(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              email: AppCubit.get(context).userdata!.email!, image: c.userdata!.image!,
                                              location: LocationController.text,
                                              age: AgeController.text,

                                            );
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
