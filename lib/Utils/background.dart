
import 'package:app_pet/CustomWidgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

background(context,height,myText){
  return Scaffold(
    body: Material(
      child: SafeArea(
        child: Container(

            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
                children:[ Positioned(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SafeArea(
                          child: Row(
                            children: [
                              BackButtonIntro(
                                onClick: () {
                                  kNavigatorBack(context);
                                },
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,

                              height: 120,
                              child: const Image(
                                image: AssetImage(
                                    'assets/images/splash_top.png'),
                              ),
                            ),
                             Text(
                              myText,
                              style: const TextStyle(
                                  color: kLightBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ],
                        ),



                      ],
                    ),
                  ),
                ),
                  Positioned(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 80,
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            children: [
                              Expanded(
                                  child:
                                  Container(
                                    alignment: Alignment.centerRight,
                                    margin: const EdgeInsets.only(right: 16),
                                    height: 30,
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/splash_bottom.png'),
                                    ),
                                  )

                              )
                              ,

                            ],
                          ),
                        ),
                      )),
                ])),
      ),
    ),
  );
}