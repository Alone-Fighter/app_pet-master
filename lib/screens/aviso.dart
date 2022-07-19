import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Aviso extends StatefulWidget {
  const Aviso({Key? key}) : super(key: key);

  @override
  State<Aviso> createState() => _AvisoState();
}

class _AvisoState extends State<Aviso> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
      color: Colors.white,
      child: Column(
       // scrollDirection: Axis.vertical,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          Image.asset('assets/images/v1.jpeg'),
          Image.asset('assets/images/v2.jpeg'),


        ],),
    ));
  }
}
