import 'package:app_pet/Ui/pet_login.dart';
import 'package:app_pet/Utils/background.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/constants.dart';
import 'package:app_pet/screens/pet_reg1.dart';
import 'package:app_pet/vet_screens/vet_reg1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  _LoginOrRegisterState createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            body: SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          background(context, 0.07, ''),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                ),
                MyButton('Registrarse', 40.0, 160.0, kDarkBlue, () {
                  kNavigator(context, PetReg1());
                }),
                TextButton(
                  onPressed: () {
                    kNavigator(context, Login());
                  },
                  child: const Text(
                    'Iniciar Sesion',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
