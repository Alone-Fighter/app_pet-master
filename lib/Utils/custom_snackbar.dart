

import 'package:flutter/material.dart';

import 'config.dart';

enum SnackBarMode {
  error,warning,success
}

class ModeSnackBar {

 static show(BuildContext context,String text , SnackBarMode snackBarMode){

   Color textColor = Config.white;
   Color backGroundColor = Colors.green;

   switch(snackBarMode){
     case SnackBarMode.error:
       backGroundColor = Colors.redAccent;
       textColor = Config.gray;
       break;
     case SnackBarMode.warning:
       backGroundColor = Colors.yellowAccent;
       textColor = Config.gray;
       break;
     case SnackBarMode.success:
       backGroundColor = Colors.green;
       textColor = Config.gray;
       break;
   }

    SnackBar snackBar = SnackBar(
      content: Text(text ,style: Config.textStyleM(textColor),),
      backgroundColor: backGroundColor,
      duration: const Duration(seconds: 2),
      elevation: 2,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}