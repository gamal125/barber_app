import 'package:barbers/register/cubit/cubit.dart';
import 'package:barbers/register/register_screen.dart';
import 'package:barbers/shared/local/bloc_observer.dart';
import 'package:barbers/shared/local/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'components/components.dart';
import 'components/constants.dart';
import 'cubit/AppCubit.dart';
import 'layout/Home_layout.dart';
import 'login/cubit/maincubit.dart';
import 'login/login_screen.dart';

main() async {
  Widget widget;
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  var uId=CacheHelper.getData(key: 'uId');
  if(uId != null&&uId!=''){

    widget=Home_Layout();




  }
  else{

    widget=MyHomePage();




  }
  runApp( MyApp(startWidget: widget));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key,   required this.startWidget});
  final Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LoginCubit()

        ),
        BlocProvider(
            create: (context) => AppCubit()..getusers()..getUser(CacheHelper.getData(key: 'uId'))


        ),
        BlocProvider(
            create: (context) => RegisterCubit()

        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return  Scaffold(
backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/icon/logo.png'))),),
          Column(
            children: [
              defaultMaterialButton(function: (){
                navigateTo(context, RegisterScreen());
              }, text: 'Sign Up',color:kPrimaryColor2 ),
              const SizedBox(height: 40,),
              defaultMaterialButton2(function: (){navigateTo(context, LoginScreen());}, text: 'Login',color:kPrimaryColor ),
              const SizedBox(height: 15,),
              defaultMaterialButton2(function: (){
                CacheHelper.saveData(key: 'uId', value: "");
                navigateTo(context, Home_Layout());}, text: 'Direct to HomePage',color:kPrimaryColor ),

            ],
          )

        ],
          ),
        ),
      ),
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
