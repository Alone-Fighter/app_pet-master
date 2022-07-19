import 'package:app_pet/CustomWidgets/vet_navigationbar.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Ui/main_menu.dart';
import 'package:app_pet/Utils/background.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/dropdown_options.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/Utils/my_text_form.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/screens/pet_reg2.dart';
import 'package:app_pet/vet_screens/vet-menu.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class VetReg2 extends StatelessWidget implements ApiStatusSignUpVet2 ,  ApiStatusLogin{
  VetReg2({Key? key}) : super(key: key);

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      body: SafeArea(child: Consumer<ApiService>(
        builder: (context, value, child) {
          value.apiListener(this);
          value.apiListenerSignUpVet2(this);
          return Material(
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
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                            Row(
                              children: const [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  'Establecimiento veterinario',
                                  style: TextStyle(
                                      color: kLightBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            SignUpForm(
                              labelname: 'Nombre del establecimiento',
                              hinttext: '',
                              whC: value.getVetPropertyController,
                              fontsize: 12.0,
                              myWidth: 330.0,
                              keyType: 0,
                            ),
                            SignUpForm(
                              labelname: 'NIT',
                              hinttext: '',
                              whC: value.getVetNitController,
                              fontsize: 12.0,
                              myWidth: 330.0,
                              keyType: null,
                            ),
                            SignUpForm(
                              labelname: 'Direccion',
                              hinttext: '',
                              whC: value.getVetDirectionController,
                              fontsize: 12.0,
                              myWidth: 330.0,
                              keyType: 0,
                            ),
                            City(
                              myHint: 'Ciudad',
                              onChanged: (val) {
                                value.setVetCity(val.toString());
                              },
                            ),
                             MultiSelected (
                               onChanged: (List<String>? val) {
                                 String service = '';
                                 val!.map((e){
                                   service += '-$e';
                                 }).toList();
                                 value.setServices(service);
                               },
                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            MyButton('Guardar', 40.0, 130.0, kDarkBlue,() {
                               value.setSignUpVet('2');
                               value.signUpVet(true,context);
                            })
                          ],
                        ),
                      ),
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
                ])
              ],
            ),
          );
        },
      )),
    );
  }

  @override
  void accountAvailable() {
    ModeSnackBar.show(context, 'you signed in before with this email', SnackBarMode.error);
  }

  @override
  void error() {
    print(error.toString());
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
  void inputEmptyDirection() {
    ModeSnackBar.show(context, 'Por favor ingrese Dirección',
        SnackBarMode.warning);
  }

  @override
  void inputEmptyName() {
    ModeSnackBar.show(context, 'Por favor ingrese Nombre del establecimiento',
        SnackBarMode.warning);
  }

  @override
  void inputEmptynit() {
    ModeSnackBar.show(context, 'Por favor ingrese NIT',
        SnackBarMode.warning);
  }

  @override
  void inputWrongEmail() {
    // TODO: implement inputWrongEmail
  }

  @override
  void inputWrongPass() {
    // TODO: implement inputWrongPass
  }

  @override
  void inputWrongverifypass() {
    // TODO: implement inputWrongverifypass
  }

  @override
  void inputEmptycity() {
    ModeSnackBar.show(context, 'Ingresa tu ciudad',
        SnackBarMode.warning);
  }

  @override
  void inputEmptyservices() {
    ModeSnackBar.show(context, 'Por favor ingrese servicios',
        SnackBarMode.warning);
  }

}
