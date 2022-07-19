import 'package:app_pet/CustomWidgets/vet_navigationbar.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Ui/main_menu.dart';
import 'package:app_pet/Utils/background.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/Utils/my_text_form.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/constants.dart';
import 'package:app_pet/screens/medical_diary.dart';
import 'package:app_pet/vet_screens/vet-menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class VetLogin extends StatelessWidget implements ApiStatusLogin {
  VetLogin({Key? key}) : super(key: key);

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Consumer<ApiService>(
      builder: (context, value, child) {
        value.apiListener(this);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.92,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        background(context, 0.05, ''),
                        Positioned(
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.32,
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 15),
                                    child: const Text(
                                      'Hola,\n¡Que gusto verte de nuevo!',
                                      style: TextStyle(
                                          color: kLightBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.08,
                              ),
                              SignUpForm(
                                labelname: 'E-mail/Usuario',
                                hinttext: 'type email',
                                fontsize: 17.0,
                                myWidth: 290.0,
                                keyType: 0,
                                whC: value.getUserNameController,
                              ),
                              SignUpForm(
                                  labelname: 'Contrasena',
                                  hinttext: '',
                                  fontsize: 17.0,
                                  myWidth: 290.0,
                                  keyType: 0,
                                  whC: value.getPassword1Controller,
                                  passkey: 1
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.15,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 10),
                                    child: const Text(
                                      'Olvidaste tu contrasena?',
                                      style: TextStyle(color: kLightBlue, fontSize: 14),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05,
                              ),
                              MyRoundButton('Iniciar sesion', 180.0, 40.0, () {
                                value.signIn();
                              }),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.03,
                              ),
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'No estas registrado? ',
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Registrate',
                                          style: const TextStyle(
                                              color: kLightBlue, fontSize: 14),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        value.isAuthLoading
                            ? Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.black.withOpacity(.05),
                            child: const Waitting(),
                          ),
                        )
                            : Container()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void accountAvailable() {

  }

  @override
  void error() {
    ModeSnackBar.show(context, 'Algo sale mal', SnackBarMode.error);
  }

  @override
  void inputEmpty() {
    ModeSnackBar.show(context, 'por favor llene toda la caja', SnackBarMode.warning);
  }

  @override
  void inputWrong() {
    ModeSnackBar.show(context, 'el correo electrónico o la contraseña son incorrectos', SnackBarMode.warning);
  }

  @override
  void login() {
    Box b = Hive.box('vet');
    b.put('vet', true);
    kNavigatorBack(context);
    kNavigator(context,  const VetNavigatorBar());
  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'use una contraseña más fuerte por favor', SnackBarMode.warning);
  }

}
