import 'package:app_pet/CustomWidgets/navigatebar.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Ui/main_menu.dart';
import 'package:app_pet/Utils/background.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/dropdown_options.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/Utils/my_text_form.dart';
import 'package:app_pet/Utils/term_screen.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/screens/add_pet1.dart';
import 'package:app_pet/screens/pet_reg2.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'medical_diary.dart';

class AddPet2 extends StatelessWidget implements ApiStatusLogin {

  late BuildContext context;

  AddPet2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      body: SafeArea(
        child: Consumer<ApiService>(
          builder: (context, value, child) {
            value.apiListener(this);
            return Stack(
              children: [
                background(context, 0.05, ''),
                Stack(children: [
                  Positioned(
                    child: Align(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.32,
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
                          SexType(
                            myHint: 'Male',
                            onChanged: (val) {
                              value.setSex(val.toString());
                            },
                          ),
                          Container(
                              child: (value.petType=='Perro')?BreedType(
                                myHint: 'Talla',
                                onChanged: (val) {
                                  value.setBreed(val.toString());
                                },
                              )
                                  :BreedType2(
                                myHint: 'Talla',
                                onChanged: (val) {
                                  value.setBreed(val.toString());
                                },
                              )
                          ),
                          Container(
                              child: (value.petType=='Perro')?PetSize(
                                myHint: 'Talla',
                                onChanged: (val) {
                                  value.setSize(val.toString());
                                },
                              )
                                  :PetSize2(
                                myHint: 'Talla',
                                onChanged: (val) {
                                  value.setSize(val.toString());
                                },
                              )
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          SizedBox(
                              height: 18,
                              child: RawMaterialButton(
                                  onPressed: () {
                                    value.checkRegister1=true;
                                    value.checkRegister2=true;
                                    value.addPet();
                                    kNavigator(context, AddPet1());
                                  },
                                  child: Image.asset(
                                      'assets/images/vetReg2_middle.png'))),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),



                          MyButton('AGREGAR', 40.0, 190.0,kDarkBlue, () {

                              value.checkRegister1=true;
                              value.checkRegister2=true;
                              value.addPet();
                              kNavigator(context, NavigatorBar());

                          })
                        ],
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
            );
          },
        ),
      ),
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
    b.put('vet', false);
    kNavigatorBack(context);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => NavigatorBar()));
  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'use una contraseña más fuerte por favor',
        SnackBarMode.warning);
  }
}
