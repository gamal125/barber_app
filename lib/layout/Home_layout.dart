// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types
import 'package:barbers/components/components.dart';
import 'package:barbers/components/constants.dart';
import 'package:barbers/login/login_screen.dart';
import 'package:barbers/main.dart';
import 'package:barbers/moduels/appointment/UserAppointmentScreen.dart';
import 'package:barbers/moduels/profileScreens/profile.dart';
import 'package:barbers/moduels/shopsScreen/shopsScreen.dart';
import 'package:barbers/shared/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/AppCubit.dart';
import '../cubit/states.dart';
import '../moduels/BarbersScreen/BarbersScreen.dart';
import '../moduels/appointment/AppointmentScreen.dart';
import '../moduels/profileScreens/AllUsers.dart';



class Home_Layout extends StatefulWidget {


  @override
  State<Home_Layout> createState() => _Home_LayoutState();
}

class _Home_LayoutState extends State<Home_Layout> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: kPrimaryColor, // Replace with your desired color
    ));
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context,  state) {

        if(state is GetUserOrderSuccessState){
          navigateTo(context, const UserAppointmentScreen());
        }
        if(state is GetLocationSuccessState){
          AppCubit.get(context).getbarbers();
        }
      if(state is  GetBarBersSuccessState){
        navigateTo(context, BarbersScreen());
      }
        if(state is GetShopSuccessState){
          navigateTo(context, ShopsScreen());
        }
        if(state is GetWaitingOrderSuccessState){
          navigateTo(context, const AppointmentScreen());
        }
      },
      builder: (context, state) {
        return   Scaffold(
          appBar: AppBar(backgroundColor: kPrimaryColor,
          iconTheme: const IconThemeData(color: kPrimaryColor2),
          title: const Text('Clipper',style: TextStyle(color: kPrimaryColor2,fontSize: 22),),
          ),
          backgroundColor: kPrimaryColor,
          drawer:  const DrawerMenu() ,
          body: Column(children: [

             Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppCubit.get(context).userdata==null?
                CircleAvatar(radius: 80,backgroundColor: kPrimaryColor2,child: Image(image: AssetImage('assets/icon/man2.png'),),)
                :AppCubit.get(context).userdata!.image==''?

                CircleAvatar(radius: 80,backgroundColor: kPrimaryColor2,child: Image(image: AssetImage('assets/icon/man2.png'),),):
              Container( width: 150,height: 150,
                decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: NetworkImage(AppCubit.get(context).userdata!.image!),fit: BoxFit.cover)),)

                ,

                  AppCubit.get(context).userdata==null? Text('user',style: TextStyle(fontSize: 22,color: kPrimaryColor2,fontWeight: FontWeight.bold),):
                  Text(AppCubit.get(context).userdata!.name!,style: TextStyle(fontSize: 22,color: kPrimaryColor2,fontWeight: FontWeight.bold),),

                  myDivider(),

                  const Text('Available Services',style: TextStyle(fontSize: 18,color: kPrimaryColor2,),),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                      onTap: (){
                        if(AppCubit.get(context).userdata!.user==true){
                          AppCubit.get(context).getLocation();

                        }else{
                          AppCubit.get(context).getbarbers();
                          navigateTo(context, BarbersScreen());
                        }
                      },
                      child: Container(

                        height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kPrimaryColor2,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            color: kPrimaryColor2,
                            //  color: background,
                          ),
                          child: const Icon(Icons.fast_forward,color: kPrimaryColor,size: 60,)),
                    ),
                      InkWell(
                        onTap: (){
                    AppCubit.get(context).getAllWorkShops();
                        },
                        child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor2,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              color: kPrimaryColor2,
                              //  color: background,
                            ),
                            child: const Icon(Icons.cut,color: kPrimaryColor,size: 60,)),
                      ),
                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap:(){

                        AppCubit.get(context).userdata!=null? navigateTo(context, ProfileScreen()):navigateTo(context, LoginScreen());
                      },
                      child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kPrimaryColor2,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            color: kPrimaryColor2,
                            //  color: background,
                          ),
                          child: Icon(Icons.person,color: kPrimaryColor,size: 60,)),
                    ),
                    InkWell(
                      onTap: (){
                        AppCubit.get(context).userdata!.user==false?AppCubit.get(context).getWaitingOrder():AppCubit.get(context).getUserOrder();
                      },
                      child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kPrimaryColor2,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            color: kPrimaryColor2,
                            //  color: background,
                          ),
                          child: const Icon(Icons.calendar_month,color: kPrimaryColor,size: 60,)),
                    ),
                  ],)

              ],
            ),
                )
            )
          ],),
        );


      },
    );
  }
}
class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black87,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
           DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
            child: Center(child: Container(width:  double.infinity,color: kPrimaryColor2, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Clippers',style: TextStyle(fontSize: 30),),
            ))),
          ),
          ListTile(
            leading: Icon(Icons.home,color: Colors.white,),
            title: Text('Home',style: TextStyle(color: Colors.white),),
            onTap: () {
            Navigator.pop(context);
            },
          ),
          AppCubit.get(context).userdata!=null? ListTile(
            leading: Icon(Icons.card_giftcard,color: Colors.white,),
            title: Row(
              children: [
                Text(AppCubit.get(context).userdata!.bonus.split(".")[0],style: TextStyle(color: Colors.white),),
                SizedBox(width: 5,),
                Text('Points',style: TextStyle(color: Colors.white),),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ):ListTile(
            leading: Icon(Icons.card_giftcard,color: Colors.white,),
            title: Row(
              children: [
                Text('0',style: TextStyle(color: Colors.white),),
                Text('Points',style: TextStyle(color: Colors.white),),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.group,color: Colors.white,),
            title: Text('Users',style: TextStyle(color: Colors.white),),
            onTap: () {
            CacheHelper.getData(key: 'uId')=='GOh7JAOPyOdOc0mChNXZ9luB3mI3'? navigateTo(context, AllUsersScreen()):
            showToast(text: 'only admin could access to this screen', state: ToastStates.error)
            ;
                 },
          ),
          ListTile(
            leading: Icon(Icons.share,color: Colors.white,),
            title: Text('Share',style: TextStyle(color: Colors.white),),
            onTap: () {
              // Handle Home menu item tap
            },
          ),
          ListTile(
            leading: Icon(Icons.settings,color: Colors.white,),
            title: Text('settings',style: TextStyle(color: Colors.white),),
            onTap: () {
              // Handle Home menu item tap
            },
          ),
          ListTile(
            leading: Icon(Icons.headset_mic,color: Colors.white,),
            title: const Text('Connect Us',style: TextStyle(color: Colors.white),),
            onTap: () {
              // Handle Home menu item tap
            },
          ),
          ListTile(
            leading: Icon(Icons.info,color: Colors.white,),
            title: Text('info',style: TextStyle(color: Colors.white),),
            onTap: () {
              // Handle Home menu item tap
            },
          ),

          myDivider(),
          ListTile(
            leading: Icon(Icons.logout,color: Colors.white,),
            title: Text('Logout',style: TextStyle(color: Colors.white),),
            onTap: () {
              CacheHelper.saveData(key: 'type', value: 'customer');
              CacheHelper.saveData(key: 'uId', value: '');
             AppCubit.get(context).signout();
             navigateAndFinish(context, MyHomePage());
            },
          ),
          // Add more menu items as needed
        ],
      ),
    );
  }
}