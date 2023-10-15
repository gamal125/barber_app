import 'package:barbers/components/components.dart';
import 'package:barbers/components/constants.dart';
import 'package:barbers/model/BarBersModel.dart';
import 'package:barbers/moduels/BarbersScreen/BarberProductsScreen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../cubit/AppCubit.dart';
import '../../cubit/states.dart';
import '../../layout/Home_layout.dart';

class BarbersScreen extends StatefulWidget {
   BarbersScreen({super.key,});

  @override
  State<BarbersScreen> createState() => _BarbersScreenState();
}

class _BarbersScreenState extends State<BarbersScreen> {
 // address=await getAddressFromCoordinates(double.parse(Latitude),double.parse(longitude));

  String address1='';
  @override
  Widget build(BuildContext context) {
    String longitude=  AppCubit.get(context).longitude;
    String Latitude=  AppCubit.get(context).Latitude;
  List<BarBersModel> barbers=AppCubit.get(context).BarBers;
     var cubit=AppCubit.get(context);
   var user= AppCubit.get(context).userdata;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) async {
          if(state is GetLocationSuccessState){
            setState(()  {
              longitude=  AppCubit.get(context).longitude;
              Latitude=  AppCubit.get(context).Latitude;
            });
            cubit.getAddressFromCoordinates(double.parse(Latitude),double.parse(longitude));
            AppCubit.get(context).createBarbers(
                image: user!.image!,
                id: user.uId!,
                barbername: user.name!,
                longitude: AppCubit.get(context).longitude,
                latitude: AppCubit.get(context).Latitude,
                price: '');
          }
           if(state is CreateBarbersSuccessState){
 AppCubit.get(context).getbarbers();
}
          if(state is GetBarBersSuccessState) {


              setState(()  {
                barbers=AppCubit.get(context).BarBers;



              });
           cubit.getAddressFromCoordinates(double.parse(Latitude),double.parse(longitude));




          }
          if (state is GetAllProductsBarberState){
            navigateTo(context, BarberProductsScreen(shopname: state.shopname, barbername: state.barbername, barberid: state.barberid));
          }
        },
        builder: (context, state) {

          return

          ConditionalBuilder(
            condition: state is !GetBarBersLoadingState &&user!.user==false,
            builder:(context)=> Scaffold(
              backgroundColor: kPrimaryColor,
              appBar: AppBar(
                leading: IconButton(onPressed: (){navigateAndFinish(context, Home_Layout());},icon: Icon(Icons.arrow_back_outlined,color:Colors.white,),),

                backgroundColor: kPrimaryColor,elevation: 0,title: Text('My Location'),),
              body: SingleChildScrollView(
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: (){
                          AppCubit.get(context).getBarbersProducts( user!.uId!,user.name!,address1);

                        },
                        child: Container(
                          height: 500,
                          width: double.infinity,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: kPrimaryColor3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppCubit.get(context).userdata!.image!=''?
                              Container(height: 300,width: double.infinity,
                                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(AppCubit.get(context).userdata!.image!),fit: BoxFit.cover),shape: BoxShape.rectangle),
                              )
                                  :  Container(height: 300,width:  double.infinity,
                                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/1.jpg'),fit: BoxFit.scaleDown),shape: BoxShape.circle),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
                                  child: Column(

                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(AppCubit.get(context).userdata!.name!.toUpperCase() ,style: TextStyle(color: Colors.white,overflow: TextOverflow.ellipsis,fontSize: 25,fontWeight: FontWeight.bold),maxLines: 1,),
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Text(cubit.address!=''?cubit.address:'إضغط علي اضافه لتحديث الموقع',style: const TextStyle(overflow: TextOverflow.ellipsis,color: Colors.white,fontSize: 20),maxLines: 2,)
                                    ],

                                  ),
                                ),
                              ),


                            ],),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(onPressed: (){

                          AppCubit.get(context).getLocation();
                },backgroundColor: Colors.white,child: const Icon(Icons.add_location_alt_rounded,color: Colors.green,),),
            ),
            fallback: (context)=> state is !GetBarBersLoadingState?
            Scaffold(
              backgroundColor: kPrimaryColor,
              appBar: AppBar(
                leading: IconButton(onPressed: (){navigateAndFinish(context, Home_Layout());},icon: Icon(Icons.arrow_back_outlined,color:Colors.white,),),

                backgroundColor: kPrimaryColor,elevation: 0,title: Text('BARBERS'),),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Text('List of the BARBERS',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                  ),
                  Expanded(
                    child: ConditionalBuilder(
                      condition: state is! GetBarBersLoadingState,
                      builder:(context)=> barbers.isNotEmpty?
                      ListView.builder(
                        shrinkWrap: true,
                        itemBuilder:(context,index)=> shopsItem(barbers[index],context) ,itemCount: barbers.length,)
                          :Text('no items'),
                      fallback: (BuildContext context) { return loading;  },
                    ),
                  ),
                ],
              ),
            ):loading,
          )



          ;
        });

  }
  Widget shopsItem(BarBersModel model,context,)=>Padding(
    padding: const EdgeInsets.all(18.0),
    child: InkWell(
      onTap: () async {
        var address=await AppCubit.get(context).getAddressFromCoordinates2(double.parse(model.latitude!),double.parse(model.longitude!));

        AppCubit.get(context).getBarbersProducts( model.uId!,model.name!,address);
        
        
        
        //
        //
        // ProductModel m=ProductModel(name: '',price: '20',image: '');
        // navigateTo(context, OrderScreen(
        //   shopname:address ,
        //   barbername: model.name!,
        //   barberid: model.uId!,
        //   model: m,
        //
        // ));
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(model.name!,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),

                    Row(

                      children: [
                        Text(address1=(Geolocator.distanceBetween(
                          double.parse(AppCubit.get(context).Latitude),
                          double.parse(AppCubit.get(context).longitude),
                          double.parse(model.latitude!),
                          double.parse(model.longitude!),
                        )/1000).toStringAsFixed(1),style: TextStyle(overflow: TextOverflow.ellipsis,color:double.parse(address1)<=2?Colors.green:Colors.red ),maxLines: 2,),
                        SizedBox(width: 10,),
                        Text(' Km')                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    ),
  );

}
