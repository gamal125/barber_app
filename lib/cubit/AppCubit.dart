import 'dart:io';

import 'package:barbers/cubit/states.dart';
import 'package:barbers/model/OrderModel.dart';
import 'package:barbers/model/ProductModel.dart';
import 'package:barbers/model/ShopBarBersModel.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


import '../model/BarBersModel.dart';
import '../model/ShopModel.dart';
import '../model/UserModel.dart';
import '../moduels/profileScreens/profile.dart';
import '../shared/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [

    ProfileScreen(),
  ];
  List<String> titles = [

    'profile',
  ];
  List<BottomNavigationBarItem> BottomItems = [
    const BottomNavigationBarItem(
        icon:   Icon(  Icons.person,),
        label: 'profile'),

  ];
  void signout(){
    emit(LogoutLoadingState());
    FirebaseAuth.instance.signOut().then((value) {
      emit(LogoutSuccessState());
    });
  }
  UserModel? userdata;
  List<UserModel> AllUsers=[];

  void getusers() {
    AllUsers.clear();
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        AllUsers.add(UserModel.fromjson(element.data()));}
      emit(GetUsersSuccessStates());


    });
  }

  void getUser(uid) {
    if(uid!=''&&uid!=null) {
      FirebaseFirestore.instance.collection('users').doc(uid.toString())
        .get()
        .then((value) {
      userdata = UserModel.fromjson(value.data()!);
      emit(GetUserSuccessStates());
    });
    }
  }
  UserModel? user;
  void getOneUser({
  required String BarberId,
  required String Barbarname,
  required String Shopname,
  required String CustomerId,
  required String Customername,
  required String date,
  required String StyleName,
  required String price,
  required String time,

}) {
    if(CustomerId!='') {
      FirebaseFirestore.instance.collection('users').doc(CustomerId.toString())
          .get()
          .then((value) {
        user = UserModel.fromjson(value.data()!);

        emit(GetOneSuccessStates(BarberId,Barbarname,Shopname,CustomerId,Customername,date,StyleName,price,time,user!.bonus));
      });
    }
  }
  void updateProfile({
    required String image,
    required String name,
    required String phone,
    required String location,
    required String age,
    required String email,}) {
    UserModel model = UserModel(
        image: image,
        name: name,
        uId: ud,
        phone: phone,
        email: email,
        Longitude: '',
        Latitude: '', Location: location, age: age, bonus: '',
    );
    emit(ImageintStates());
    FirebaseFirestore.instance.collection('users').doc(ud).update(model.Tomap()).then((value) {
      emit(UpdateProfileSuccessStates());
    }).catchError((error) {
      emit(UpdateProductErrorStates(error.toString()));
    });
  }
  String ImageUrl2 = '';
  String ImageUrl3 = '';

  void uploadProfileImage({
    required String name,
    required String email,
    required String phone,
    required String location,
    required String age,
  }) {
    emit(ImageintStates());
    FirebaseStorage.instance.ref().child('users/${Uri
        .file(PickedFile2!.path)
        .pathSegments
        .last}').putFile(PickedFile2!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        ImageUrl2 = value;
        print(ImageUrl2);
        createUser(
            image: ImageUrl2,
            name: name,

            email: email,
            phone: phone,

            uId: ud, location: location, age: age);
        PickedFile2 = null;

        emit(ImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }
  void createUser({
    required String image,
    required String email,
    required String uId,
    required String name,
    required String phone,
    required String location,
    required String age,
  }) {


    FirebaseFirestore.instance.collection("users").doc(uId).update({
      'name':name,
      'phone':phone,
      'email':email,
      'uId':uId,
      'image':image,
      'Location':Location,
      'Latitude':'',
      'Longitude':'',
      'age':age,

     }).then((value) {

      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }
  void changeIndex(int index) {
    currentIndex = index;
    if (currentIndex==0){}
    if (currentIndex==1){}
    if (currentIndex==2){}


    emit(AppChangeBottomNavBarState());
  }
/////////////////////////iamge///////////

  void getbarbers() {
    BarBers.clear();
    myBarBer.clear();
    emit(GetBarBersLoadingState());
    FirebaseFirestore.instance.collection('barbers')
        .get()
        .then((value) {
      value.docs.forEach((element) {

        element.id!=ud? BarBers.add(BarBersModel.fromjson(element.data())):myBarBer.add(BarBersModel.fromjson(element.data()));
      });

      emit(GetBarBersSuccessState());
    }).catchError((error) {
      emit(GetBarBersErrorState(error.toString()));
    });
  }

  void uploadBarbersImage({

    required String id,
    required String barbername,
    required String longitude,
    required String latitude,
    required String price,

  }) {
    emit(ImageintStates());
    FirebaseStorage.instance.ref().child('users/${Uri
        .file(PickedFile3!.path)
        .pathSegments
        .last}').putFile(PickedFile3!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        ImageUrl3 = value;
        print(ImageUrl3);
        createBarbers(
          image: ImageUrl3,
          barbername: barbername,
          price: price,
          id: id,
          longitude: longitude,
          latitude: latitude,
        );
        PickedFile3 = null;

        emit(ImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }
  void createBarbers({
    required String image,
    required String id,
    required String barbername,
    required String longitude,
    required String latitude,
    required String price,
  }) {
    BarBersModel model=BarBersModel(

      name: barbername,
      uId: id,
      image: image,
      price: price,
      latitude: latitude,
      longitude: longitude,

    );

    FirebaseFirestore.instance.collection("barbers").doc(id).set(model.Tomap()).then((value) {

      emit(CreateBarbersSuccessState());
    }).catchError((error) {
      emit(CreateBarbersErrorState(error.toString()));
    });
  }

  String Latitude = '';
  String longitude = '';

  Future<void> getLocation() async {
    // Check if location permissions are granted
    if (await Permission.location.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );


      Latitude = position.latitude.toString();
      longitude= position.longitude.toString();
      emit(GetLocationSuccessState());

    } else {
      // Request location permissions
      PermissionStatus permissionStatus = await Permission.location.request();

      if (permissionStatus.isGranted) {
        // Permission granted, retrieve location
        await getLocation();

      } else {
        // Permission denied

        Latitude = '';

      }
    }
  }

  ///////////////////////////////////////////done functions///////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
  final ImagePicker picker2 = ImagePicker();
  final ImagePicker picker3 = ImagePicker();
  File? PickedFile2;
  File? PickedFile3;
  Future<void> getImage2() async {
    final imageFile = await picker2.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      PickedFile2 = File(imageFile.path);
      emit(UpdateProductImageSuccessStates());
    }
    else {
      var error = 'no Image selected';
      emit(UpdateProductImageErrorStates(error.toString()));
    }
  }
  Future<void> getImage3() async {
    final imageFile = await picker3.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      PickedFile3 = File(imageFile.path);
      emit(UpdateProductImageSuccessStates());
    }
    else {
      var error = 'no Image selected';
      emit(UpdateProductImageErrorStates(error.toString()));
    }
  }
  final ImagePicker picker = ImagePicker();
  File? PickedFile;
  Future<void> getImage() async {
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      PickedFile = File(imageFile.path);
      emit(UpdateProductImageSuccessStates());
    }
    else {
      var error = 'no Image selected';
      emit(UpdateProductImageErrorStates(error.toString()));
    }
  }
  ////////////////////upload workshop/////////////
  String ImageUrl = '';
  String ud =  CacheHelper.getData(key: 'uId');
  void uploadShopImage({
    required String shopname,
    required String publisher_id,
    required String location,

  }) {
    emit(ImageintStates());
    FirebaseStorage.instance.ref().child('users/${Uri
        .file(PickedFile2!.path)
        .pathSegments
        .last}').putFile(PickedFile2!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        ImageUrl2 = value;
        print(ImageUrl2);
        createShop(
          image: ImageUrl2,
          name: shopname,
          uId: publisher_id,
          location: location, );
        PickedFile2 = null;

        emit(ImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }
  void createShop({
    required String image,
    required String uId,
    required String name,
    required String location,
  }) {
    ShopModel model=ShopModel(

      name: name,
      uId: uId,
      image: image,
      Location: location,

    );

    FirebaseFirestore.instance.collection("users").doc(uId).collection('shops').doc(name).set(model.Tomap()).then((value) {

      emit(CreateShopSuccessState());
    }).catchError((error) {
      emit(CreateShopErrorState(error.toString()));
    });
  }
  List<ShopModel> shops=[];
  List<ProductModel> products=[];
  List<ProductModel> Barberproducts=[];
  List<ShopBarBersModel> shopBarBers=[];

  List<BarBersModel> BarBers=[];
  List<BarBersModel> myBarBer=[];

  void getAllWorkShops(){
    shops.clear();
    getworkshop('GOh7JAOPyOdOc0mChNXZ9luB3mI3');

  }
  void getworkshop(String id) {

    emit(GetShopLoadingState());
    FirebaseFirestore.instance.collection('users').doc(id)
        .collection('shops')
        .get()
        .then((value) {

      value.docs.forEach((element) {

        shops.add(ShopModel.fromjson(element.data()));
      });

      emit(GetShopSuccessState());
    }).catchError((error) {
      emit(GetShopErrorState(error.toString()));
    });
  }

  void getbarbersshop(String id,String name,bool user) {
    shopBarBers.clear();
    emit(GetBarBersShopLoadingState());
    FirebaseFirestore.instance.collection('users').doc('GOh7JAOPyOdOc0mChNXZ9luB3mI3')
        .collection('shops').doc(name).collection('barbers')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        shopBarBers.add(ShopBarBersModel.fromjson(element.data()));
      });

      emit(GetBarBersShopSuccessState(id,name,user));
    }).catchError((error) {
      emit(GetBarBersShopErrorState(error.toString()));
    });
  }
  void getproductsshop(String shopname,String barbername,String barberid) {
    products.clear();
    emit(GetProductsShopLoadingState());
    FirebaseFirestore.instance.collection('users').doc('GOh7JAOPyOdOc0mChNXZ9luB3mI3')
        .collection('shops').doc(shopname).collection('products')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        products.add(ProductModel.fromjson(element.data()));
      });

      emit(GetAllProductsShopState(barbername,barberid));
    }).catchError((error) {
      emit(GetProductsShopErrorState(error.toString()));
    });
  }
  List<UserModel> AllBarbers=[];
  void getallbarbers(){
    AllBarbers.clear();
    AllUsers.forEach((element) {
      !element.user!?AllBarbers.add(element):null;
    });
    emit(GetAllBarBersShopState());
  }
  var address ='';
  void getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
         address = ' ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';

      } else {
        address='';
      }
    } catch (e) {
     'Error: $e';
    }
  }
  Future<String> getAddressFromCoordinates2(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        address = ' ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
return address;
      } else {
        address='';
        return address;
      }
    } catch (e) {
      return 'Error: $e';

    }
  }
  void createBarbersShop({
    required String barbername,
    required String barber_id,
    required String image,
    required String uId,
    required String name,
    required String price,
  }) {
    ShopBarBersModel model=ShopBarBersModel(

      name: barbername,
      uId: barber_id,
      image: image,
      price: price,

    );

    FirebaseFirestore.instance.collection("users").doc(uId).collection('shops').doc(name).collection('barbers').doc(barber_id).set(model.Tomap()).then((value) {

      emit(CreateBarbersShopSuccessState());
    }).catchError((error) {
      emit(CreateBarbersShopErrorState(error.toString()));
    });
  }

  void uploadProductImage({
    required String shopname,
    required String name,
    required String price,

  }) {
    emit(ImageintStates());
    FirebaseStorage.instance.ref().child('users/${Uri
        .file(PickedFile2!.path)
        .pathSegments
        .last}').putFile(PickedFile2!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        ImageUrl2 = value;
        print(ImageUrl2);
        createProduct(
          image: ImageUrl2,
          name: name,
          price: price,
          shopname: shopname,
          );
        PickedFile2 = null;

        emit(ImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }
  void createProduct({
    required String image,
    required String shopname,
    required String name,
    required String price,
  }) {
    ProductModel model=ProductModel(

      name: name,
      image: image,
      price: price,

    );

    FirebaseFirestore.instance.collection("users").doc('GOh7JAOPyOdOc0mChNXZ9luB3mI3').collection('shops').doc(shopname).collection('products').doc(name).set(model.Tomap()).then((value) {

      emit(CreateProductsSuccessState());
    }).catchError((error) {
      emit(CreateProductsErrorState(error.toString()));
    });
  }
  void createWaitingOrder({
    required String BarberId,
    required String Barbarname,
    required String Shopname,
    required String CustomerId,
    required String Customername,
    required String date,
    required String StyleName,
    required String price,
    required String time
  }) {
    OrderModel model=OrderModel(
      BarberId: BarberId,
      Barbarname:Barbarname ,
      Shopname: Shopname,
      CustomerId:CustomerId ,
      Customername: Customername,
      date: date,
      time: time,
      StyleName:StyleName ,
      price:price ,


    );

    FirebaseFirestore.instance.collection("users").doc(BarberId).collection('waiting').doc(CustomerId).set(model.Tomap()).then((value) {

      emit(CreateOrderSuccessState());
    }).catchError((error) {
      emit(CreateProductsErrorState(error.toString()));
    });
  }

  List<OrderModel> waitingOrder=[];
  void getWaitingOrder(){
    waitingOrder.clear();
    emit(GetWaitingOrderLoadingState());
    FirebaseFirestore.instance.collection("users").doc(ud).collection('waiting').get().then((value) {
      value.docs.forEach((element) {
        waitingOrder.add(OrderModel.fromjson(element.data()));
      });
      emit(GetWaitingOrderSuccessState());
    });
  }
  List<OrderModel> DoneOrder=[];
  void getDoneOrder(){
    DoneOrder.clear();
    emit(GetDoneOrderLoadingState());
    FirebaseFirestore.instance.collection("users").doc(ud).collection('orders').get().then((value) {
      value.docs.forEach((element) {
        DoneOrder.add(OrderModel.fromjson(element.data()));
      });
      emit(GetDoneOrderSuccessState());
    });
  }
  void deleteDoneOrder(String customerid){
    DoneOrder.clear();
    emit(GetDoneOrderLoadingState());

    FirebaseFirestore.instance.collection("users").doc(ud).collection('orders').doc(customerid).delete();
    FirebaseFirestore.instance.collection("users").doc(customerid).collection('orders').doc(ud).delete().then((value) {
      getDoneOrder();
    });
  }
  void createOrder({
    required String BarberId,
    required String Barbarname,
    required String Shopname,
    required String CustomerId,
    required String Customername,
    required String date,
    required String StyleName,
    required String price,
    required String time,
    required String bonus
  }) {
    OrderModel model=OrderModel(
      BarberId: BarberId,
      Barbarname:Barbarname ,
      Shopname: Shopname,
      CustomerId:CustomerId ,
      Customername: Customername,
      date: date,
      time: time,
      StyleName:StyleName ,
      price:price ,


    );
    emit(CreateShopOrderLoadingState());
    bonus==''?bonus='0':null;
    bonus=(double.parse(bonus)+10).toString();
    FirebaseFirestore.instance.collection("users").doc(BarberId).collection('orders').doc(CustomerId).set(model.Tomap());
    FirebaseFirestore.instance.collection("users").doc(CustomerId).collection('orders').doc(BarberId).set(model.Tomap());
    FirebaseFirestore.instance.collection("users").doc(CustomerId).update({"bonus":bonus});
    FirebaseFirestore.instance.collection("users").doc(BarberId).collection('waiting').doc(CustomerId).delete();
    emit(CreateShopOrderSuccessState());
  }
  List<OrderModel> acceptedOrders=[];
  void getUserOrder(){
    acceptedOrders.clear();
    emit(GetUserOrderLoadingState());
    FirebaseFirestore.instance.collection("users").doc(ud).collection('orders').get().then((value) {
      value.docs.forEach((element) {
        acceptedOrders.add(OrderModel.fromjson(element.data()));
      });
      emit(GetUserOrderSuccessState());
    });
  }
  void uploadBarberProductImage({
    required String id,
    required String name,
    required String price,

  }) {
    emit(ImageintStates());
    FirebaseStorage.instance.ref().child('users/${Uri
        .file(PickedFile2!.path)
        .pathSegments
        .last}').putFile(PickedFile2!).
    then((value) {
      value.ref.getDownloadURL().then((value) {
        ImageUrl2 = value;
        print(ImageUrl2);
        createBarberProduct(
          image: ImageUrl2,
          name: name,
          price: price,
          id: id,
        );
        PickedFile2 = null;

        emit(ImageSuccessStates())
        ;
      }).catchError((error) {
        emit(ImageErrorStates(error));
      });
    }).catchError((error) {
      emit(ImageErrorStates(error));
    });
  }
  void createBarberProduct({
    required String image,
    required String id,
    required String name,
    required String price,
  }) {
    ProductModel model=ProductModel(

      name: name,
      image: image,
      price: price,

    );

    FirebaseFirestore.instance.collection("barbers").doc(id).collection('products').doc(name).set(model.Tomap()).then((value) {

      emit(CreateBarberProductsSuccessState());
    }).catchError((error) {
      emit(CreateProductsErrorState(error.toString()));
    });
  }
  void getBarbersProducts(String barberid,String barbername,String shopname) {
    Barberproducts.clear();
    emit(GetProductsBarberLoadingState());
    FirebaseFirestore.instance.collection("barbers").doc(barberid).collection('products').get()
        .then((value) {
      value.docs.forEach((element) {
        Barberproducts.add(ProductModel.fromjson(element.data()));
      });
          print(Barberproducts.length);
      emit(GetAllProductsBarberState(barbername,barberid,shopname));
    }).catchError((error) {
      emit(GetProductsBarberErrorState(error.toString()));
    });
  }
}
