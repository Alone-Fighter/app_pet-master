import 'package:app_pet/Utils/term_screen.dart';
import 'package:app_pet/screens/aviso.dart';
import 'package:app_pet/screens/politica.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

MyButton(
  buttonText,
  height,
  width,
  myColor,
  onPress,
) {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            myColor,
            kLightBlue,
          ],
        ),
        color: kDarkBlue,
        borderRadius: BorderRadius.circular(8)),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPress,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Center(
              child: Text(
            buttonText,
            style: const TextStyle(color: Colors.white),
          )),
        ),
      ),
    ),
  );
}

class MyButton2 extends StatefulWidget {
  MyButton2({Key? key, this.myText, this.onChanged}) : super(key: key);
  final myText;
  final ValueChanged<bool?>? onChanged;
  bool currentSelectedValue = false;

  @override
  _MyButton2State createState() => _MyButton2State();
}

class _MyButton2State extends State<MyButton2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 40),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.currentSelectedValue) {
                setState(() {
                  widget.currentSelectedValue = false;
                  widget.onChanged!.call(widget.currentSelectedValue);
                });
              } else {
                setState(() {
                  widget.currentSelectedValue = true;
                  widget.onChanged!.call(widget.currentSelectedValue);
                });
              }
            },
            child: Container(
              height: 100,
              width: 20,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade800),
                  shape: BoxShape.circle,
                  color: !widget.currentSelectedValue
                      ? Colors.white
                      : Colors.grey.shade400),
            ),
          ),
          const SizedBox(
            width: 5,
          ),

          // Text(widget.myText,maxLines: 20,style: TextStyle(fontSize: 13,color: Colors.grey.shade500,),)
          RichText(
            text: TextSpan(
              text: 'Autorizo expresamente a Boehringer Ingelheim \n',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              children: <TextSpan>[
                const TextSpan(
                    text: 'S.A., en calidad de Responsable del Tratamiento,\n'),
                const TextSpan(text: 'para que, por sí mismo o en asocio \n'),
                const TextSpan(text: 'con terceros,realice el tratamiento de los\n'),
                const TextSpan(
                    text: 'datos personales aquí suministrados para los\n'),
                const TextSpan(text: 'fines contemplados en nuestro \n'),
                TextSpan(
                  text: 'Aviso de Privacidad ',
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                    kNavigator(context, Aviso());
                      print('Terms of Service');
                    },
                ),
                const TextSpan(text: 'y '),
                TextSpan(
                  text: '  términos y condiciones\n',
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                    kNavigator(context, TermsScreen());
                      print('Terms of Service');
                    },
                ),
                const TextSpan(text: ' Para más información consulte nuestra\n'),
                TextSpan(
                  text: ' Política de Tratamiento de Datos Personales.\n',
                  style: const TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                    kNavigator(context, Policitia());
                      print('Terms of Service');
                    },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

MyRoundButton(buttonText, height, width, onPress) {
  return Container(
    decoration: BoxDecoration(
        // gradient: const LinearGradient(
        //   begin: Alignment.topRight,
        //   end: Alignment.bottomLeft,
        //   colors: [
        //     kDarkBlue,
        //     kLightBlue,
        //   ],
        // ),
        color: kLightBlue,
        borderRadius: BorderRadius.circular(40)),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: onPress,
        child: Container(
          height: width,
          width: height,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
          child: Center(
              child: Text(
            buttonText,
            style: const TextStyle(color: Colors.white),
          )),
        ),
      ),
    ),
  );
}

MyImagedButton(imagePath, height, width, onPress) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        color: kLightBlue,
        borderRadius: BorderRadius.circular(19)),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(19),
        onTap: onPress,
        child: Container(
          height: width,
          width: height,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(19)),
        ),
      ),
    ),
  );
}
