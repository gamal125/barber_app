import 'package:barbers/components/constants.dart';
import 'package:barbers/moduels/profileScreens/updateprofile.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../cubit/AppCubit.dart';
import '../../cubit/states.dart';
import '../../layout/Home_layout.dart';
import '../../login/login_screen.dart';

import '../../shared/local/cache_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var selectionMode;

  var isChecked=false;

  @override
  Widget build(BuildContext context) {

    var cubit = AppCubit.get(context);

   var user= cubit.userdata!;
    cubit.getUser(user.uId!);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {


      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
        appBar: AppBar(
          leading: IconButton(onPressed: (){navigateAndFinish(context, Home_Layout());},icon: Icon(Icons.arrow_back_outlined,color:Colors.white,),),
          elevation: 0,systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: kPrimaryColor,statusBarIconBrightness: Brightness.light),backgroundColor: kPrimaryColor,iconTheme: IconThemeData(color: kPrimaryColor2),),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    width: double.infinity,

                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children:[

                                AppCubit.get(context).userdata!.image==''||AppCubit.get(context).userdata!.image==null?  CircleAvatar(backgroundImage: AssetImage('assets/icon/man2.png'),radius: 80,):
                                CircleAvatar(backgroundImage: NetworkImage('${AppCubit.get(context).userdata!.image!}'),radius: 80,),
                                Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),   border: Border.all(
                                      color: kPrimaryColor,
                                      width: 7,
                                    ),                           color: kPrimaryColor2,
                                    ),
                                    child: IconButton( onPressed: (){navigateTo(context, UpdateProfileScreen()); }, icon: Icon(Icons.edit,color: Colors.white,size: 18,))),

                              ]

                          ),
                        ),
                        Center(child: Column(children: [
                          Text(user.name!,style: TextStyle(color: kPrimaryColor2,fontSize: 25),textAlign: TextAlign.start,),
                          Text(user.email!,style: TextStyle(color: Colors.white,fontSize: 18),textAlign: TextAlign.start,),

                        ],),),
                        Text('City',style: TextStyle(color: kPrimaryColor2,fontSize: 22),textAlign: TextAlign.start,),
                        Container(alignment: AlignmentDirectional.centerStart,width: double.infinity,height: 35,decoration:BoxDecoration( color: Colors.black,borderRadius: BorderRadius.circular(10)) ,child: Row(
                          children: [
                            Icon(Icons.home,color: kPrimaryColor2,),
                            SizedBox(width: 10,),
                            Text(user.Location,style: TextStyle(color: kPrimaryColor2,fontSize: 22),textAlign: TextAlign.start,),
                          ],
                        ), ),
                        Text('Age',style: TextStyle(color: kPrimaryColor2,fontSize: 22),textAlign: TextAlign.start,),
                        Container(alignment: AlignmentDirectional.centerStart,width: double.infinity,height: 35,decoration:BoxDecoration( color: Colors.black,borderRadius: BorderRadius.circular(10)) ,child: Row(
                          children: [
                            Icon(Icons.person,color: kPrimaryColor2,),
                            SizedBox(width: 10,),
                            user.age!=''? Text(user.age,style: TextStyle(color: kPrimaryColor2,fontSize: 22),textAlign: TextAlign.start,):Text('25',style: TextStyle(color: kPrimaryColor2,fontSize: 22),textAlign: TextAlign.start,),
                          ],
                        ), ),

                        Text('Phone',style: TextStyle(color: kPrimaryColor2,fontSize: 22),textAlign: TextAlign.start,),
                        Container(alignment: AlignmentDirectional.centerStart,width: double.infinity,height: 35,decoration:BoxDecoration( color: Colors.black,borderRadius: BorderRadius.circular(10)) ,child: Row(
                          children: [
                            Icon(Icons.phone,color: kPrimaryColor2,),
                            SizedBox(width: 10,),
                           user.phone!=''? Text(user.phone!,style: TextStyle(color: kPrimaryColor2,fontSize: 22),textAlign: TextAlign.start,):Text('05XXXXXXXXX',style: TextStyle(color: kPrimaryColor2,fontSize: 22),textAlign: TextAlign.start,),
                          ],
                        ), ),
SizedBox(height: 50,)



                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

        );


      },
    );
  }



}
