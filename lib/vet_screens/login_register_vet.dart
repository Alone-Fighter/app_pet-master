import 'package:app_pet/Ui/pet_login.dart';
import 'package:app_pet/Ui/vet_login.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/constants.dart';
import 'package:app_pet/screens/pet_reg1.dart';
import 'package:app_pet/vet_screens/vet_reg1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginOrRegisterVet extends StatefulWidget {
  const LoginOrRegisterVet({Key? key}) : super(key: key);

  @override
  _LoginOrRegisterVetState createState() => _LoginOrRegisterVetState();
}

class _LoginOrRegisterVetState extends State<LoginOrRegisterVet> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
            children: [

              Positioned(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        margin: const EdgeInsets.only(top: 36),
                        height: 200,
                        child: const Image(
                          image: AssetImage(
                              'assets/images/splash_top.png'),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                      ),
                      MyButton('Registrarse', 40.0, 160.0,kDarkBlue, (){
                         kNavigator(context, VetReg1());
                      }),

                      TextButton(
                        onPressed: () {
                          kNavigator(context, VetLogin());
                        },
                        child: const Text(
                          'Iniciar Sesion',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
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
            ]
        ),
      ),
    );
  }
}
