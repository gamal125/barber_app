import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../components/constants.dart';
import '../../cubit/AppCubit.dart';
import '../../cubit/states.dart';
import '../../model/UserModel.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({Key? key}) : super(key: key);

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  var isChecked = false;
  List<bool> _switchValues = [];

  List<UserModel> list = [];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var cubit = AppCubit.get(context);
cubit.getusers();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

        if (state is GetUsersSuccessStates) {
          list = [];
          list = AppCubit.get(context).AllUsers;
          list.forEach((element) {
            _switchValues.add(element.user!);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
title: const Center(child: Text('All Users',style: TextStyle(color: Colors.white),)),
leading: IconButton(onPressed: (){Navigator.pop(context);},icon:const Icon( Icons.arrow_back_rounded,),),
            iconTheme: const IconThemeData(color: kPrimaryColor2),backgroundColor: kPrimaryColor,elevation: 0,

          ),
          body: ConditionalBuilder(
            builder: (context) => list.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsetsDirectional.only(start: 10.0, top: 10),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) =>
                        UsersList(list[index], index, context),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10.0,
                    ),
                    itemCount: list.length,
                  )
                :  loading,
            condition: state is GetUsersSuccessStates,
            fallback: (context) =>Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: Colors.blue.withOpacity(.8),
                  size: screenSize.width / 12,
                )) ,
          ),

        );
      },
    );
  }

  Widget UsersList(UserModel model, int i, context) => InkWell(
    onTap: (){

    },
    child: Card(
          color: kPrimaryColor2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.none,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    model.image != ''
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(model.image!),
                            radius: 40,
                          )
                        : const CircleAvatar(
                            backgroundImage: AssetImage('assets/icon/man2.png'),
                            radius: 40,
                          ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(child: Text(model.name!,maxLines: 1,overflow: TextOverflow.ellipsis,)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        _switchValues[i]
                            ? Text(
                      'User',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                ),
                              )
                            : Text(
                    'barber',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.red),
                              ),
                        Switch(
                          value: _switchValues[i],
                          onChanged: (value) {
                            setState(() {
                              _switchValues[i] = value;

                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(model.uId)
                                  .update({'user': _switchValues[i]});
                            });
                          },
                        ),
                      ],
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),
  );
}
