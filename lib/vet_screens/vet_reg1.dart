import 'package:app_pet/CustomWidgets/vet_navigationbar.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Utils/background.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/dropdown_options.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/Utils/my_text_form.dart';
import 'package:app_pet/Utils/term_screen.dart';

import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/vet_screens/vet_reg2.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../constants.dart';




class VetReg1 extends StatelessWidget implements ApiStatusSignUpVet ,ApiStatusLogin {
  VetReg1({Key? key}) : super(key: key);
  late BuildContext context;
  bool checkRegister1 = false;
  bool checkRegister2 = false;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      body: SafeArea(child: Consumer<ApiService>(
        builder: (context, value, child) {
          value.apiListener(this);
          value.apiListenerSignUpVet(this);
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.97,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        child: Stack(
                          children: [
                            background(context, 0.07, ''),
                            Stack(children: [
                              Positioned(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(

                                         height: MediaQuery.of(context).size.height*0.7,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height * 0.2,
                                                ),
                                                Row(
                                                  children: const [
                                                    SizedBox(
                                                      width: 40,
                                                    ),
                                                    Text(
                                                      'Profesional de Medicina Veterinaria',
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
                                                  whC: value.getVetNameController,
                                                  fontsize: 12.0,
                                                  myWidth: 330.0,
                                                  keyType:0,),
                                                SignUpForm(labelname: 'Telefono',
                                                  hinttext: '',
                                                  whC: value.getVetNumberController,
                                                  fontsize: 12.0,
                                                  myWidth: 330.0,
                                                  keyType: null,),
                                                City(
                                                  myHint: 'Ciudad',
                                                  onChanged: (val) {
                                                    value.setVetCityShop(val.toString());
                                                  },
                                                ),
                                                Expert(
                                                  myHint: 'Especialidad',
                                                  onChanged: (val) {
                                                    value.setExpert(val.toString());
                                                  },
                                                ),
                                                SignUpForm(labelname: 'Tarjeta profesional',
                                                  hinttext: '',
                                                  whC: value.getVetProfessionalCard,
                                                  fontsize: 12.0,
                                                  myWidth: 330.0,
                                                  keyType: 0,),
                                                WorkAs(
                                                  myHint: 'Trabajas Como',
                                                  onChanged: (val) {
                                                    value.setWorkAs(val.toString());
                                                  },
                                                ),
                                                SignUpForm(
                                                    labelname: 'Correo',
                                                    hinttext: '',
                                                    whC: value.getVetEmailController,
                                                    myWidth: 330.0,
                                                    keyType: 0,
                                                    fontsize: 12.0),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 17,
                                                    ),
                                                    SignUpForm(
                                                        keyType: 0,
                                                        labelname: 'Contasena',
                                                        hinttext: '',
                                                        whC: value.getVetPassword1Controller,
                                                        myWidth: 300.0,
                                                        fontsize: 12.0,
                                                        passkey: 1
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 17,
                                                    ),
                                                    SignUpForm(
                                                        keyType: 0,
                                                        labelname: 'Verifica tu contrasena',
                                                        hinttext: '',
                                                        whC: value.getVetPassword2Controller,
                                                        myWidth: 300.0,
                                                        fontsize: 12.0,
                                                        passkey: 1
                                                    ),

                                                  ],
                                                ),
                                                MyButton2(
                                                  myText:
                                                  'Autorizo la politica de tratamiento de\ndatos personalas',
                                                  onChanged: <bool>(val) {
                                                    value.setCheckRegister1(val);
                                                    print(value.checkRegister1.toString());
                                                  },
                                                ),
                                                MyButton2(
                                                  myText: 'Autorizo las politicas de la aplicacion',
                                                  onChanged: <bool>(val) {
                                                    value.setCheckRegister2(val);
                                                  },
                                                ),
                                                // RawMaterialButton(
                                                //   onPressed: () {
                                                //     kNavigator(context, TermsScreen());
                                                //   },
                                                //   child: Container(
                                                //     child: Text('TÉRMINOS Y CONDICIONES'),
                                                //   ),
                                                // )
                                                TextButton(onPressed: (){
                                                  kNavigator(context, TermsScreen());
                                                }, child: Text('TÉRMINOS Y CONDICIONES')),

                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.02,
                                        ),
                                        MyButton('Guardar', 40.0, 130.0,kDarkBlue, () {
                                          if (value.checkRegister1 == true &&
                                              value.checkRegister2 == true) {
                                          print(value.workAs);

                                          if(value.workAs=='Independiente'){
                                            value.signUpVet(true,context);
                                            kNavigator(context,VetNavigatorBar());
                                          }
                                          else
                                          {
                                            value.signUpVet(false,context);
                                            // kNavigator(context,  VetReg2());
                                          }
                                        }
                                          else if(value.checkRegister1 == false &&
                                              value.checkRegister2 == false){
                                            ModeSnackBar.show(context, "Debes aceptar los terminos y condiciones para continuar", SnackBarMode.error);


                                        }})
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
                  ),
                ),
              ],
            ),
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
    Box b = Hive.box('vet');
    b.put('vet', true);
    kNavigatorBack(context);
    kNavigator(context, const VetNavigatorBar());
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

  @override
  void inputEmptySpecialty() {
    ModeSnackBar.show(
        context, 'Por favor ingrese Especialidad ', SnackBarMode.warning);
  }

  @override
  void inputWrongverifypass() {
    ModeSnackBar.show(
        context, 'Introduce la contraseña de nuevo', SnackBarMode.warning);
  }

  @override
  void inputEmptyProfessional() {
    ModeSnackBar.show(
        context, 'Por favor ingrese Tarjeta profesional ', SnackBarMode.warning);
  }

  @override
  void inputEmptyWorkAs() {
    ModeSnackBar.show(
        context, 'Por favor ingresa trabajas como ', SnackBarMode.warning);
  }
}
