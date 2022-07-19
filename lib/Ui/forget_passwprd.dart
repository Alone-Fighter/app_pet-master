import 'package:app_pet/CustomWidgets/navigatebar.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Ui/main_menu.dart';
import 'package:app_pet/Utils/background.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/Utils/my_text_form.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/constants.dart';
import 'package:app_pet/screens/medical_diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatelessWidget implements ApiStatusLogin {
  ForgetPassword({Key? key}) : super(key: key);

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

                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.15,
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05,
                              ),
                              MyRoundButton('restablecer la contraseña', 180.0, 40.0, () {
                                print(value.getUserNameController.text);
                                //kNavigator(context, Navigator());
                                value.auth.sendPasswordResetEmail(email: value.getUserNameController.text).whenComplete((){
                                  ModeSnackBar.show(context, 'correo electrónico enviado con éxito', SnackBarMode.success);
                                });
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
  void inputEmptyEmail() {
    ModeSnackBar.show(context, 'Por favor ingrese el correo electrónico', SnackBarMode.warning);
  }

  @override
  void inputEmptyPass() {
    ModeSnackBar.show(context, 'Por favor introduzca la contraseña', SnackBarMode.warning);
  }


  @override
  void inputEmpty() {
    ModeSnackBar.show(
        context, 'por favor llene toda la caja', SnackBarMode.warning);
  }


  @override
  void inputWrongPass() {
    ModeSnackBar.show(context, 'La contraseña es débil', SnackBarMode.warning);
  }

  @override
  void inputWrongEmail() {
    ModeSnackBar.show(context, 'Email inválido', SnackBarMode.warning);
  }

  @override
  void login(){
    Box b = Hive.box('vet');
    b.put('vet', false);
    kNavigatorBack(context);
    kNavigator(context,  const NavigatorBar());
  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'use una contraseña más fuerte por favor', SnackBarMode.warning);
  }

  @override
  void inputWrong() {
    ModeSnackBar.show(context, 'Email inválido / La contraseña es débil', SnackBarMode.warning);
  }


}
