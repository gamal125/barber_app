
import 'package:barbers/components/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/components.dart';
import '../cubit/AppCubit.dart';
import '../layout/Home_layout.dart';
import '../register/register_screen.dart';
import '../shared/local/cache_helper.dart';
import 'cubit/maincubit.dart';
import 'cubit/state.dart';



class LoginScreen extends StatelessWidget {
 final  formKey = GlobalKey<FormState>();

 final emailController = TextEditingController();

 final passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var c=AppCubit.get(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
         if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId);
           c.getUser(state.uId);
            AppCubit.get(context).ud=state.uId;
                navigateAndFinish(context,  Home_Layout());
      }},
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
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            const Text('Login',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Dubai',),),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.0),
                              child: Text('Enter Your Information',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'Dubai',),),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defaultTextFormField(
                              onTap: (){
                              },
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              prefix: Icons.email,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter email';
                                }
                                return null;
                              },
                              label: 'Email',
                              hint: 'Enter your email',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultTextFormField(
                              onTap: (){
                                // LoginCubit.get(context).emit(LoginInitialState());
                              },
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              prefix: Icons.key,
                              suffix: LoginCubit.get(context).suffix,
                              isPassword: LoginCubit.get(context).isPassword,
                              suffixPressed: () {
                                LoginCubit.get(context).ChangePassword();
                              },
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                              label: 'Password',
                              hint: 'Enter your password',
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Don\'t have an account?',
                                  style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),

                                defaultTextButton(
                                  function: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  text: 'Register Now!',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context) => Center(
                                child: defaultMaterialButton(

                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  text: 'Confirm',
                                  radius: 20,
                                  color: kPrimaryColor2
                                ),
                              ),
                              fallback: (context) =>
                                  loading
                            ),




                          ],
                        ),
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
