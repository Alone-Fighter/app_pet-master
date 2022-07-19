import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Utils/background.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/dropdown_options.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/Utils/my_text_form.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/screens/add_pet2.dart';
import 'package:app_pet/screens/pet_reg3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../CustomWidgets/navigatebar.dart';
import '../constants.dart';
import 'add_pet1.dart';

class EditPet1 extends StatelessWidget implements ApiStatusLogin {
  var name;

  var breed;

  var weight;

  var sex;

  var age;

  var petId;

  //List<QueryDocumentSnapshot> snapshot;
  EditPet1(
      {Key? key,
        required this.petId,
      required this.breed,
      required this.name,
      required this.year,
        required this.month,
        required this.day,
      required this.sex,
      required this.weight})
      : super(key: key);

  late BuildContext context;
  String day ;
  String month ;
  String year ;

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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.28,
                            ),
                            Row(
                              children: const [
                                SizedBox(
                                  width: 40,
                                ),
                              ],
                            ),
                            SignUpForm(
                                labelname: name,
                                hinttext: '',
                                keyType: 0,
                                whC: value.getPetNameController,
                                myWidth: 330.0,
                                fontsize: 12.0),
                            SignUpForm(
                                labelname: sex,
                                hinttext: '',
                                keyType: 0,
                                whC: value.getPetSexController,
                                myWidth: 330.0,
                                fontsize: 12.0),
                            SignUpForm(
                                labelname: breed,
                                hinttext: '',
                                keyType: 0,
                                whC: value.getPetBreedController,
                                myWidth: 330.0,
                                fontsize: 12.0),
                            SignUpForm(
                                labelname: year,
                                hinttext: '',
                                keyType: 0,
                                whC: value.getPetEditYearController,
                                myWidth: 330.0,
                                fontsize: 12.0),
                            SignUpForm(
                                labelname: month,
                                hinttext: '',
                                keyType: 0,
                                whC: value.getPetEditMonthController,
                                myWidth: 330.0,
                                fontsize: 12.0),
                            SignUpForm(
                                labelname: day,
                                hinttext: '',
                                keyType: 0,
                                whC: value.getPetEditDayController,
                                myWidth: 330.0,
                                fontsize: 12.0),
                            SignUpForm(
                                labelname: weight,
                                hinttext: '',
                                keyType: 0,
                                whC: value.getPetSizeController,
                                myWidth: 330.0,
                                fontsize: 12.0),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            MyButton('Actualizar', 40.0, 190.0, kDarkBlue, () {
                              value.updateProfilePetDetails(petId,context);

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
  void login() {}

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'use una contraseña más fuerte por favor',
        SnackBarMode.warning);
  }
}
