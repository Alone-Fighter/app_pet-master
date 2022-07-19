import 'package:app_pet/CustomWidgets/calendar.dart';
import 'package:app_pet/CustomWidgets/drawer.dart';
import 'package:app_pet/Model/adaptions.dart';
import 'package:app_pet/Model/vet.dart';
import 'package:app_pet/Model/vet_esp.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/dropdown_options.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/screens/pet_reg2.dart';
import 'package:app_pet/screens/vaccination.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

class Cardiology extends StatefulWidget  {
  Cardiology({Key? key}) : super(key: key);

  @override
  State<Cardiology> createState() => _CardiologyState();
}

class _CardiologyState extends State<Cardiology> implements ApiStatusLogin{
  late BuildContext context;

  showSnackBar(String text) {
    SnackBar snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String dropdownValue = 'todo';

  @override
  Widget build(BuildContext context) {
    this.context = context;
    String city = 'BOGOTA';
//------------------------------------------------------------------------//

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              // height: MediaQuery.of(context).size.height*0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage("assets/images/direct.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Cardiología',
                      style: TextStyle(
                          color: Config.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'City :  ',
                      style: TextStyle(color: Colors.white),
                    ),
                    DropDownCity(),
                  ],),
                SizedBox(height: 50,),
                Consumer<ApiService>(
                  builder: (context, value, child) {
                    value.apiListener(this);
                    //////////////////////////////////should change with adaption api
                    value.getAllVet();

                    return StreamBuilder<QuerySnapshot>(
                        stream:(dropdownValue == 'todo') ? context.read<ApiService>().getAllVet() : context.read<ApiService>().getcityVet(dropdownValue) ,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            print('hasError');
                            return const Text('Something went wrong');
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: Waitting(),
                            );
                          }

                          if (snapshot.hasData) {
                            if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(15)),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(16),
                                    child: const Text(
                                      'No Contact...',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )),
                              );
                            }
                            // return Text('data');

                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height *
                                              0.6,
                                          child: ListView(
                                            // scrollDirection: Axis.horizontal,
                                            padding: const EdgeInsets.only(top: 5),
                                            children: snapshot.data!.docs
                                                .map((DocumentSnapshot document) {
                                              VetEsp vetData = VetEsp.fromJson(
                                                  document.data()!
                                                  as Map<String, dynamic>);
                                              if (vetData.expertise ==
                                                  'Cardiología.') {
                                                return Container(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.17,
                                                  margin: EdgeInsets.all(10),
                                                  child: Container(
                                                      decoration: const BoxDecoration(
                                                          border: Border(
                                                            top: BorderSide(
                                                                color: kLightestBlue,
                                                                width: 2),
                                                            bottom: BorderSide(
                                                                color: kLightestBlue,
                                                                width: 2),
                                                          )),
                                                      margin: EdgeInsets.all(20),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 50,
                                                            width: 50,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                Colors.deepOrange,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(5)),
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(50),
                                                                child: Image.asset(
                                                                    'assets/images/direct2.png')),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                            MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                                0.2,
                                                          ),
                                                          Container(
                                                            margin:
                                                            const EdgeInsets.symmetric(
                                                                vertical: 10),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  vetData.name,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      color:
                                                                      kLightBlue,
                                                                      fontSize: 20),
                                                                ),
                                                                Text(
                                                                  vetData.expertise,
                                                                  style: const TextStyle(

                                                                      color:Colors.grey,
                                                                      fontSize: 15),
                                                                ),
                                                                Text(
                                                                  vetData.number,
                                                                  style: const TextStyle(

                                                                      color:Colors.grey,
                                                                      fontSize: 12),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                );
                                              } else {
                                                return Container(
                                                  // child:Text(
                                                  //   'There is No Match Data',
                                                  //   style: TextStyle(
                                                  //       color: Config.white,
                                                  //       fontSize: 20,
                                                  //       fontWeight: FontWeight.bold),
                                                  // )
                                                );
                                              }
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return const Center(
                            child: Waitting(),
                          );
                        });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget DropDownCity () {
    return DropdownButton<String>(
      dropdownColor: Colors.lightBlueAccent,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward,color: Colors.white,),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>[
        'todo',
        'BOGOTA',
        'MEDELLIN',
        'CALI',
        'BUCARAMANGA',
        'BARRANQUILLA',
        'CARTAGENA',
        'SANTA MARTA',
        'MANIZALES',
        'CUCUTA',
        'PEREIRA',
        'IBAGUE',
        'VILLAVICENCIO',
        'PASTO',
        'TUNJA',
        'VALLEDUPAR',
        'MONTERIA',
        'ARMENIA',
        'POPAYAN',
        'NEIVA',
        'RIOHACHA',
        'BUENAVENTURA',
        'QUIBDO',
        'SINCELEJO',
        'FLORENCIA',
        'YOPAL',
        'SOACHA',
        'BARRANCABERMEJA',
        'IPIALES',
        'TULUA',
        'PALMIRA',
        'LETICIA',
        'CARTAGO',
        'TUMACO',
        'ZIPAQUIRAÀ',
        'SAN JOSÈ DEL GUAVIARE',
        'GIRARDOT',
        'MOCOA',
        'PUERTO CARREÑO',
        'BELLO',
        'DUITAMA',
        'MITÙ',
        'BUGA',
        'APARTADO',
        'MAICAO',
        'CIÈNAGA',
        'ITAGÙI',
        'YUMBO',
        'MOMPÒS',
        'FUSAGASUGÀ',
        'INIRIDA',
        'JAMUNDI',]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
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
