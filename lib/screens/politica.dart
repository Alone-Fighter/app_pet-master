import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Policitia extends StatefulWidget {
  const Policitia({Key? key}) : super(key: key);

  @override
  State<Policitia> createState() => _PolicitiaState();
}

class _PolicitiaState extends State<Policitia> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
      color: Colors.white,
      child: PageView(
        scrollDirection: Axis.vertical,
        children: [
          Image.asset('assets/images/f1.jpeg'),
          Image.asset('assets/images/f2.jpeg'),
          Image.asset('assets/images/f3.jpeg'),
          Image.asset('assets/images/f4.jpeg'),
          Image.asset('assets/images/f5.jpeg'),
          Image.asset('assets/images/f6.jpeg'),
          Image.asset('assets/images/f7.jpeg'),
          Image.asset('assets/images/f8.jpeg'),
          Image.asset('assets/images/f9.jpeg'),
          Image.asset('assets/images/f10.jpeg'),
          Image.asset('assets/images/f11.jpeg'),
          Image.asset('assets/images/f12.jpeg'),
          Image.asset('assets/images/f13.jpeg'),
          Image.asset('assets/images/f14.jpeg'),
          Image.asset('assets/images/f15.jpeg'),
          Image.asset('assets/images/f16.jpeg'),
          Image.asset('assets/images/f17.jpeg'),
          Image.asset('assets/images/f18.jpeg'),



        ],),
    ));
  }
}
