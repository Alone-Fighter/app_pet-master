import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Utils/config.dart';

const kDarkBlue = Color(0XFF0375be);
const kLightBlue = Color(0XFF27a8e1);
const kLightestBlue = Color(0XFFbde0f3);
const kLightestBlueHeader = Color(0xFF659fff);
const kDarkBlueHeader = Color(0xFF058ae5);
const kDiaryBlue = Color(0xFF7ae3fc);
const kVacsanBlue = Color(0xFF0a6ea5);
const kDirectoryBlue = Color(0xFF2cace2);
const kVisitBlue=Color(0xFF8cc5fd);
const kDarkBlueLocation = Color(0xFF1c3661);
const kContainerLocation = Color(0xFF24a2dc);
const kBlueProduct = Color(0xFF2cace2);



kNavigator(context, page) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => page),
  );
}
myText(){
  const Text('     ¿      ,   ¡        ');
}
kNavigatorBack(context) {
  Navigator.of(context).pop();
}
MenuContainer(context,width,height,imagePath,onPressed){
  return   RawMaterialButton(
    onPressed:onPressed,
    child: Container(
      width: MediaQuery.of(context).size.width*width,
      height: MediaQuery.of(context).size.width*height ,
      child: Image.asset(imagePath),
    ),
  );

}