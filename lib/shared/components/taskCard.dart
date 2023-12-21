// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';




void navigateTo (context,widget)=>Navigator.push(context,
 MaterialPageRoute(builder: (context)=>widget));

 void navigateAndFinish(context,widget) {
   Navigator.pushAndRemoveUntil(
  context,
    MaterialPageRoute(builder: (context)=>widget),
    (route) => false);
 }


 ToastFuture flutterToast({
  required String msg,
  BuildContext? context,
 required ToastState state ,
 })=> showToast(
                msg,
                context: context,
                duration: const Duration(seconds: 5),
                borderRadius: BorderRadius.circular(10),
                backgroundColor: changeToastColor(state),
                textStyle: const TextStyle(
                  color: Colors.white
                )
                
                


              );


enum ToastState  {success, error,warning}

Color changeToastColor (ToastState state){
  late Color color;
  switch (state) {
    case ToastState.success:
    color = Colors.green;
      break;
      case ToastState.error:
    color = Colors.red;
      break;
      case ToastState.warning:
    color = Colors.amber;
      break;
    
  }
  return color;
}