
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); //800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}

Widget space(double wide, double high) {
  return SizedBox(
    width: wide,
    height: high,
  );
}

String? token = '';

String uId = '';

int cartLength = 0;
const kPrimaryColor = Color(0xFF0F1120);

const kPrimaryColor2 = Color(0xFFB29F81);
const kPrimaryColor3 = Color(0xFF7B5409);
 Widget loading=    Center(
     child: LoadingAnimationWidget.inkDrop(
       color: kPrimaryColor2.withOpacity(.8),
       size: 20,
     ));