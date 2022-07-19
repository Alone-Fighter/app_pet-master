import 'package:app_pet/CustomWidgets/calendar.dart';
import 'package:app_pet/CustomWidgets/drawer.dart';
import 'package:app_pet/CustomWidgets/navigatebar.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/dropdown_options.dart';
import 'package:app_pet/Utils/expert_search.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/screens/cardiologi.dart';
import 'package:app_pet/screens/dermatologi.dart';
import 'package:app_pet/screens/general.dart';
import 'package:app_pet/screens/oftomologi.dart';
import 'package:app_pet/screens/oncologi.dart';
import 'package:app_pet/screens/ortoped.dart';
import 'package:app_pet/screens/pet_reg2.dart';
import 'package:app_pet/screens/vaccination.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import '../constants.dart';

class Directory extends StatelessWidget implements ApiStatusLogin {
  Directory({Key? key}) : super(key: key);
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
      backgroundColor: kLightBlue,
      appBar: AppBar(
        toolbarHeight: 150,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              size: 35,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: kLightBlue,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Spacer(
              flex: 1,
            ),
            Text(
              'Directorio de Profesionales \n de Medicina Veterinaria ',
              style: TextStyle(color: Config.white, fontSize: 19),
            ),
            const Spacer(
              flex: 1,
            )
          ],
        ),
      ),
      drawer:  Drawer(
        child: myDrawer(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage("assets/images/direct.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<ApiService>(
          builder: (context, value, child) {
            value.apiListener(this);
            //////////////////////////////////should change with adaption api
            value.getAllVet();
            return Column(
              children: [

                Row(
                  children: [
                    const Spacer(flex: 2,),
                    RawMaterialButton(
                      onPressed: () async {
                        showSearch(context: context, delegate: ExpertSearch());

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey.shade300)),

                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: const BoxDecoration(),
                      child: RawMaterialButton(
                          onPressed: () async {
                            showSearch(context: context, delegate: ExpertSearch());

                          },
                          child: Image.asset(
                            'assets/images/menu8.png',
                          )),
                    ),
                    const Spacer()
                  ],
                ),
                SizedBox(
                  height:MediaQuery.of(context).size.height*0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MenuContainer(context, 0.5,0.4,'assets/images/direct1.png',(){
                      kNavigator(context, MedicalGeneral());
                    }),
                    MenuContainer(context, 0.5,0.4,'assets/images/direct2.png',(){
                      kNavigator(context, Cardiology());
                    }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MenuContainer(context, 0.5,0.4,'assets/images/direct3.png',(){
                      kNavigator(context, Dermatology());
                    }),
                    MenuContainer(context, 0.5,0.4,'assets/images/direct4.png',(){
                      kNavigator(context, Ortoped());
                    }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MenuContainer(context, 0.5,0.4,'assets/images/direct5.png',(){
                      kNavigator(context, Oftomologi());
                    }),
                    MenuContainer(context, 0.5,0.4,'assets/images/direct6.png',(){
                      kNavigator(context, Oncology());
                    }),
                  ],
                ),
                const SizedBox(height: 10,),

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
    kNavigatorBack(context);
    kNavigator(context, PetReg2());
  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'use una contraseña más fuerte por favor',
        SnackBarMode.warning);
  }
}
