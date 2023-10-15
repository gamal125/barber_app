abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}
class UpdateProductSuccessStates extends AppStates {}
class UpdateProfileSuccessStates extends AppStates {}
class UpdateProductErrorStates extends AppStates {
  final String error;

  UpdateProductErrorStates( this.error);
}
class CreateUserSuccessState extends AppStates {}
class CreateUserErrorState extends AppStates {
  final String error;

  CreateUserErrorState( this.error);
}
class CreateShopSuccessState extends AppStates {}
class CreateShopErrorState extends AppStates {
  final String error;
  CreateShopErrorState( this.error);
}
class CreateProductsSuccessState extends AppStates {}
class CreateBarberProductsSuccessState extends AppStates {}
class CreateOrderSuccessState extends AppStates {}
class CreateShopOrderLoadingState extends AppStates {}
class CreateShopOrderSuccessState extends AppStates {}
class GetWaitingOrderLoadingState extends AppStates {}
class GetWaitingOrderSuccessState extends AppStates {}
class GetDoneOrderLoadingState extends AppStates {}
class GetDoneOrderSuccessState extends AppStates {}
class CreateProductsErrorState extends AppStates {
  final String error;
  CreateProductsErrorState( this.error);
}
class CreateBarbersShopSuccessState extends AppStates {}
class CreateBarbersShopErrorState extends AppStates {
  final String error;
  CreateBarbersShopErrorState( this.error);
}
class GetLocationSuccessState extends AppStates {}

class CreateBarbersSuccessState extends AppStates {}
class CreateBarbersErrorState extends AppStates {
  final String error;
  CreateBarbersErrorState( this.error);
}
class GetShopSuccessState extends AppStates {}
class GetShopLoadingState extends AppStates {}
class GetShopErrorState extends AppStates {
  final String error;
  GetShopErrorState( this.error);
}
class GetBarBersShopSuccessState extends AppStates {
  final String id;
  final String name;
  final bool user;
  GetBarBersShopSuccessState( this.id,this.name,this.user);
}
class GetBarBersShopLoadingState extends AppStates {}
class GetAllBarBersShopState extends AppStates {}
class GetBarBersShopErrorState extends AppStates {
  final String error;
  GetBarBersShopErrorState( this.error);
}
class GetProductsShopLoadingState extends AppStates {}
class GetAllProductsShopState extends AppStates {
  final String barbername;
  final String barberid;
  GetAllProductsShopState(this.barbername,this.barberid);
}
class GetProductsShopErrorState extends AppStates {
  final String error;
  GetProductsShopErrorState( this.error);
}
class GetProductsBarberLoadingState extends AppStates {}
class GetAllProductsBarberState extends AppStates {
  final String barbername;
  final String barberid;
 final String shopname;
  GetAllProductsBarberState(this.barbername,this.barberid, this.shopname);
}
class GetProductsBarberErrorState extends AppStates {
  final String error;
  GetProductsBarberErrorState( this.error);
}
class GetBarBersSuccessState extends AppStates {}
class GetBarBersLoadingState extends AppStates {}
class GetBarBersErrorState extends AppStates {
  final String error;
  GetBarBersErrorState( this.error);
}
class LogoutLoadingState extends AppStates {}
class LogoutSuccessState extends AppStates {}
class ImageintStates extends AppStates {}

class ImageErrorStates extends AppStates {
  final String error;

  ImageErrorStates( this.error);
}
class UpdateProductImageErrorStates extends AppStates {
  final String error;

  UpdateProductImageErrorStates( this.error);
}
class UpdateProductImageSuccessStates extends AppStates {}

class ImageSuccessStates extends AppStates {}
class GetUsersSuccessStates extends AppStates {}
class GetUserSuccessStates extends AppStates {}
class GetOneSuccessStates extends AppStates {
   final String BarberId;
  final String Barbarname;
 final  String Shopname;
   final String CustomerId;
   final String Customername;
   final String date;
   final String StyleName;
   final  String price;
   final  String time;
   final String bonus;
   GetOneSuccessStates(this.BarberId,this.Barbarname,this.Shopname,this.CustomerId,this.Customername,this.date,this.StyleName,this.price,this.time,this.bonus);
}
class GetUserOrderLoadingState extends AppStates {}
class GetUserOrderSuccessState extends AppStates {}