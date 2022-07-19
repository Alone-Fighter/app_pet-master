import 'package:app_pet/CustomWidgets/button.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Utils/background.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/dropdown_options.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/Utils/my_text_form.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/screens/pet_reg2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class PetReg1 extends StatelessWidget implements ApiStatusSignUp , ApiStatusLogin {
  PetReg1({Key? key}) : super(key: key);
  late BuildContext context;

  showSnackBar(String text) {
    SnackBar snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    String city = 'test';
//------------------------------------------------------------------------//

    return Scaffold(
      body: SafeArea(child: Consumer<ApiService>(
        builder: (context, value, child) {
          value.apiListener(this);
          value.apiListenerSignUp(this);
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height*0.95 ,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  background(context, 0.07, '¡Queremos Conocerte!'),
                  Column(children: [
                    // Row(
                    //   children: [
                    //     BackButtonIntro(onClick: () { kNavigatorBack(context); },),
                    //   ],
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.69,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.22,
                            ),
                            Row(
                              children: const [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  'Ingresa tus datos',
                                  style: TextStyle(
                                      color: kLightBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            SignUpForm(
                                labelname: 'Nombre y apellidos',
                                hinttext: '',
                                whC: value.getFullNameController,
                                myWidth: 330.0,
                                fontsize: 12.0,
                                keyType: 0),
                            SignUpForm(
                                labelname: 'Telefono',
                                hinttext: '',
                                whC: value.getNumberController,
                                myWidth: 330.0,
                                fontsize: 12.0,
                                keyType: 1),
                            SignUpForm(
                                labelname: 'Corrreo',
                                hinttext: '',
                                whC: value.getEmailController,
                                myWidth: 330.0,
                                keyType: 0,
                                fontsize: 12.0),
                            City(
                              myHint: 'Ciudad',
                              onChanged: (value) {
                                city = value.toString();

                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Row(
                              children: const [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  'Fecha de Nacimiento',
                                  style: TextStyle(
                                      color: kLightBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                      margin:
                                          const EdgeInsets.symmetric(horizontal: 18),
                                      color: Colors.white,
                                      height: 40,
                                      width: 80,
                                      child: DatePicker(
                                        true,
                                        false,
                                        false,
                                        'Dia',
                                        onChanged: (val) {
                                          value.setDay(val.toString());
                                        },
                                      )),
                                  Container(
                                      margin:
                                          const EdgeInsets.symmetric(horizontal: 17),
                                      color: Colors.white,
                                      height: 40,
                                      width: 80,
                                      child: DatePicker(
                                        false,
                                        true,
                                        false,
                                        'Mes',
                                        onChanged: (val) {
                                          value.setMonth(val.toString());
                                        },
                                      )),
                                  Container(
                                      margin:
                                          const EdgeInsets.symmetric(horizontal: 17),
                                      color: Colors.white,
                                      height: 40,
                                      width: 80,
                                      child: DatePicker(
                                        false,
                                        false,
                                        true,
                                        'Año',
                                        onChanged: (val) {
                                          value.setYear(val.toString());
                                        },
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: const [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  'Escribe una contrasena',
                                  style: TextStyle(
                                      color: kLightBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                SignUpForm(
                                    keyType: 0,
                                    labelname: 'Contasena',
                                    hinttext: '',
                                    whC: value.getPassword1Controller,
                                    myWidth: 300.0,
                                    fontsize: 12.0,
                                    passkey: 1
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                SignUpForm(
                                    keyType: 0,
                                    labelname: 'Verifica tu contrasena',
                                    hinttext: '',
                                    whC: value.getPassword2Controller,
                                    myWidth: 300.0,
                                    fontsize: 12.0,
                                    passkey: 1
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            MyButton('Siguiente', 40.0, 190.0, kDarkBlue,() {
                              value.signUpUser(city);
                            }),

                          ],
                        )),
                  ]),
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
          );
        },
      )),
    );
  }

  @override
  void accountAvailable() {
    ModeSnackBar.show(
        context, 'te registraste antes con este correo electrónico', SnackBarMode.error);
  }

  @override
  void error() {
    ModeSnackBar.show(context, 'Algo sale mal', SnackBarMode.error);
  }

  @override
  void inputEmpty() {
    ModeSnackBar.show(
        context, 'por favor llene toda la caja', SnackBarMode.warning);
  }

  @override
  void inputWrongverifypass() {
    ModeSnackBar.show(
        context, 'por favor llene toda la caja', SnackBarMode.warning);
  }


  @override
  void inputWrong() {
    ModeSnackBar.show(
        context,
        'el correo electrónico o la contraseña son incorrectos',
        SnackBarMode.warning);
  }


  bool push = false;
  @override
  void login() {
    if(!push){
      push = true;
      kNavigator(context, PetReg2());
    }

  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'use una contraseña más fuerte por favor',
        SnackBarMode.warning);
  }

  @override
  void inputEmptyEmail() {
    ModeSnackBar.show(context, 'Por favor ingrese el correo electrónico', SnackBarMode.warning);
  }



  @override
  void inputWrongEmail() {
    ModeSnackBar.show(context, 'Email inválido', SnackBarMode.warning);
  }

  @override
  void inputWrongPass() {
    // TODO: implement inputWrongPass
  }

  @override
  void inputEmptyName() {
    ModeSnackBar.show(
        context, 'Introduzca su nombre', SnackBarMode.warning);

  }

  @override
  void inputEmptyCity() {
    ModeSnackBar.show(
        context, 'Ingresa tu ciudad', SnackBarMode.warning);  }

  @override
  void inputEmptydate() {
    ModeSnackBar.show(
        context, 'Introduce la fecha completa', SnackBarMode.warning);
  }

  @override
  void inputEmptyNumber() {
    ModeSnackBar.show(
        context, 'Introduce el teléfono', SnackBarMode.warning);
  }

  @override
  void inputEmptyPass1() {
    ModeSnackBar.show(
        context, 'Introduce la contraseña', SnackBarMode.warning);
  }

  @override
  void inputEmptyPass2() {
    ModeSnackBar.show(
        context, 'Introduce la contraseña de nuevo', SnackBarMode.warning);
  }


}
