import 'package:app_pet/Ui/intro.dart';
import 'package:app_pet/Utils/background.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'login_register.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background(context, 0.005, 'Selecciona el tipo de prefil'),
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.53,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyImagedButton(
                    'assets/images/start2.png', 120.0, 120.0, () {
                      kNavigator(context, IntroPage(vet: true));
                }),
                MyImagedButton('assets/images/start3.png', 120.0, 120.0, (){
                  kNavigator(context,  IntroPage(vet:false));
                })

              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            RichText(
              text:  TextSpan(
                text: '¿Ya estás registrado? ',style: const TextStyle(color: Colors.grey,

                  fontSize: 14
              ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Inicia sesión',
                    style: const TextStyle(color: kLightBlue,

                        fontSize: 14
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('Registrate');
                      },
                  ),
                ],
              ),
            ) ],
        ),
      ],
    );
  }
}
