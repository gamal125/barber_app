
import 'package:barbers/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget defaultTextFormField({
  FocusNode? focusNode,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String? Function(String?) validate,
  required String label,

  String? hint,

  onTap,
  onChanged,
  Function(String)? onFieldSubmitted,
  bool isPassword = false,
  bool isClickable = true,
  InputDecoration? decoration,
  IconData? suffix,
  IconData? prefix,
  Function? suffixPressed,
}) =>
    TextFormField(
style: TextStyle(color: kPrimaryColor2),

      maxLines: 1,
      minLines: 1,
      controller: controller,
      validator: validate,
      enabled: isClickable,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      obscureText: isPassword,
      keyboardType: keyboardType,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefix,
          color: kPrimaryColor2,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: () {
            suffixPressed!();
          },
          icon: Icon(
            suffix,
            color: kPrimaryColor2,
          ),
        )
            : null,
        filled: true,
        isCollapsed: false,
        fillColor: Colors.transparent,
        hoverColor: Colors.red.withOpacity(0.2),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
          borderSide: BorderSide(
            color: kPrimaryColor2,
            width: 2
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        labelText: label,
        labelStyle: const TextStyle(

          color: Colors.white,
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        focusColor: Colors.red,
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
          borderSide: BorderSide(
            color: kPrimaryColor2,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
Widget defaultTextFormField2({
  FocusNode? focusNode,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String? Function(String?) validate,
  required String label,

  String? hint,

  onTap,
  onChanged,
  Function(String)? onFieldSubmitted,
  bool isPassword = false,
  bool isClickable = true,
  InputDecoration? decoration,
  IconData? suffix,
  IconData? prefix,
  Function? suffixPressed,
}) =>
    TextFormField(


      maxLines: 15,
      minLines: 10,
      controller: controller,
      validator: validate,
      enabled: isClickable,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      obscureText: isPassword,
      keyboardType: keyboardType,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefix,
          color: Colors.cyan,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: () {
            suffixPressed!();
          },
          icon: Icon(
            suffix,
            color: Colors.cyan,
          ),
        )
            : null,
        filled: true,
        isCollapsed: false,
        fillColor: Colors.transparent,
        hoverColor: Colors.red.withOpacity(0.2),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Colors.cyan,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        labelText: label,
        labelStyle: const TextStyle(

          color: Colors.black,
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        focusColor: Colors.black,
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
Widget defaultMaterialButton({
  required Function function,
  required String text,
  Color color=Colors.cyan,
  double width = 250,
  double height = 50.0,
  double radius = 25.0,
  bool isUpperCase = true,
  Function? onTap,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: color,
        //  color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
         text,
          textAlign:TextAlign.start,


          style: const TextStyle(

            color: kPrimaryColor,
            fontSize: 20.0,
          ),
        ),
      ),
    );
Widget defaultMaterialButton2({
  required Function function,
  required String text,
  Color color=Colors.cyan,
  double width = 250,
  double height = 50.0,
  double radius = 25.0,
  bool isUpperCase = true,
  Function? onTap,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: kPrimaryColor2,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: color,
        //  color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
          textAlign:TextAlign.start,


          style: const TextStyle(

            color: kPrimaryColor2,
            fontSize: 20.0,
          ),
        ),
      ),
    );
Widget defaultMaterialButton3({
  required Function function,
  required String text,
  Color color=Colors.cyan,
  double width = 100,
  double height = 50.0,
  double radius = 25.0,
  bool isUpperCase = true,
  Function? onTap,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: kPrimaryColor2,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: color,
        //  color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
          textAlign:TextAlign.start,


          style: const TextStyle(

            color: kPrimaryColor,
            fontSize: 17.0,
          ),
        ),
      ),
    );
Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(text,style: const TextStyle(color: kPrimaryColor2),),
    );

Widget myDivider() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
);

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum  كذا اختيار من حاجة

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;

    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ), (route) {
  return false;
});

// void logOut(context) {
//   CacheHelper.removeData(
//     key: 'token',
//   ).then((value) {
//     if (value) {
//       navigateAndFinish(context, LoginScreen());
//     }
//   });
// }



