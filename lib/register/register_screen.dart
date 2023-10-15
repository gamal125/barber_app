import 'dart:io';
import 'package:barbers/components/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import '../components/components.dart';
import '../cubit/AppCubit.dart';
import '../layout/Home_layout.dart';
import '../login/login_screen.dart';
import '../shared/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';


class RegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();


  late final String name ;
  late final String email ;
  late final String imageUrl ;

  late final File? profileImage;
  final pickerController = ImagePicker();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
       listener: (context, state) {
        if (state is RegisterSuccessState) {

          navigateAndFinish(context, LoginScreen());
        }
        if (state is SuccessState) {

          CacheHelper.saveData(key: 'uId', value: state.uId);
           AppCubit.get(context).ud=state.uId;
          AppCubit.get(context).getUser(state.uId);

          AppCubit.get(context).currentIndex=0;
           navigateAndFinish(context, Home_Layout());
        }

      },
      builder: (context, state) {
        return Scaffold(
backgroundColor: kPrimaryColor,
          body: SafeArea(
            child: GestureDetector(
              onTap: (){
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [


                        const Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Dubai',),),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 18.0),
                          child: Text('Create Your Account',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'Dubai',),),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 50,left: 50,bottom:10),
                          child: Column(children: [

                            defaultTextFormField(

                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Insert Email';
                                }
                                return null;
                              },
                              label: 'Email',
                              hint: 'Insert Email',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultTextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.text,

                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Insert User Name';
                                }
                                return null;
                              },
                              label: 'User Name',
                              hint: 'Insert User Name',
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            defaultTextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.text,

                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Insert PassWord';
                                }
                                return null;
                              },
                              label: 'PassWord',
                              hint: 'PassWord',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [


                                const Text('i\'m a member!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: kPrimaryColor2),),
                                TextButton(onPressed: () { navigateTo(context, LoginScreen()); },
                                  child:Text('Login Now',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: HexColor('#F88B94'),),),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ConditionalBuilder(
                              condition: state is! CreateUserInitialState,
                              builder: (context) => Center(
                                child: defaultMaterialButton(
                                   function: () {
                                    if (formKey.currentState!.validate()) {


                                          RegisterCubit.get(context).userRegister(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            name: nameController.text,
                                            phone: '',
                                          );
                                    }
                                   },
                                  text: 'Confirm ',
                                  radius: 20, color: kPrimaryColor2,
                                ),
                              ),
                              fallback: (context) => loading
                            ),




                          ]),
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
