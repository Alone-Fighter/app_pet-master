import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Utils/background.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/dropdown_options.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/Utils/my_text_form.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/screens/add_pet2.dart';
import 'package:app_pet/screens/pet_reg3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class AddPet1 extends StatelessWidget implements ApiStatusLogin {
  AddPet1({Key? key}) : super(key: key);

  late BuildContext context;
  String day = 'test';
  String month = 'test';
  String year = 'test';
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      body: SafeArea(child: Consumer<ApiService>(
        builder: (context, value, child) {
          value.apiListener(this);
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                child: Stack(
                  children: [
                    background(context, 0.07, '¡Describenos tu mascota!'),
                    Stack(children: [
                      Positioned(
                        child: Align(
                          alignment: Alignment.center,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.2,
                                ),
                                Row(
                                  children: const [
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(
                                      'Ingresa los datos de tu mascota',
                                      style: TextStyle(
                                          color: kLightBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.01,
                                ),
                                PetType(
                                  myHint: 'Tipo de mascota',
                                  onChanged: (val) {
                                    value.setPetType(val.toString());
                                  },
                                ),
                                SignUpForm(
                                    labelname: 'Nombre',
                                    hinttext: '',
                                    keyType: 0,
                                    whC: value.getPetNameController,
                                    myWidth: 330.0,
                                    fontsize: 12.0),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.04,
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
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.01,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child:  Row(
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
                                            'Ano',
                                            onChanged: (val) {
                                              value.setYear(val.toString());
                                            },
                                          )),

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.08,
                                ),
                                MyButton('Siguiente', 40.0, 190.0,kDarkBlue, () {
                                  value.checkPetReg2Validate();
                                  kNavigatorBack(context);
                                  kNavigator(context, AddPet2());
                                })
                              ],
                            ),
                          ),
                        ),
                      ),
                    ])
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
          );
        },
      )),
    );
  }

  @override
  void accountAvailable() {
    ModeSnackBar.show(
        context, 'you signed in before with this email', SnackBarMode.error);
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
  void inputWrong() {
    ModeSnackBar.show(
        context,
        'el correo electrónico o la contraseña son incorrectos',
        SnackBarMode.warning);
  }

  @override
  void login() {

  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'use una contraseña más fuerte por favor',
        SnackBarMode.warning);
  }
}
