import 'package:app_pet/CustomWidgets/calendar.dart';
import 'package:app_pet/CustomWidgets/drawer.dart';
import 'package:app_pet/Model/pet.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Ui/Desparasitacion.dart';
import 'package:app_pet/Ui/medicalexams.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/constants.dart';
import 'package:app_pet/screens/test_stream.dart';
import 'package:app_pet/screens/vaccination.dart';
import 'package:app_pet/screens/visit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import '../constants.dart';

class MedicalDiary extends StatelessWidget
    implements ApiStatusLogin {
  late BuildContext context;
  // String petId = '';
  var imagePath = '-1';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu_rounded,
                size: 35,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          backgroundColor: kDiaryBlue,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Spacer(
                flex: 1,
              ),
              Text(
                'Diario Medico',
                style: TextStyle(color: Config.white, fontSize: 25),
              ),
              const Spacer(
                flex: 2,
              )
            ],
          ),
        ),
        drawer: Drawer(
          child: myDrawer(),
        ),
        body: Consumer<ApiService>(
          builder: (context, value, child) {
            value.apiListener(this);
            // value.getImageProfileLink(petId);
            value.getAllPets();
            return StreamBuilder<QuerySnapshot>(
                stream: context.read<ApiService>().getAllPets(),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      );
                    }
                    // return Text('data');

                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage("assets/images/diary.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 110,
                            child:  Container(
                          child: Image.asset('assets/images/wlogo.png'),
                    ),
                            // child: ListView(
                            //   scrollDirection: Axis.horizontal,
                            //   padding: const EdgeInsets.only(top: 5),
                            //   children: snapshot.data!.docs
                            //       .map((DocumentSnapshot document) {
                            //     PetData petData = PetData.fromJson(document.data()! as Map<String, dynamic>);
                            //    // petId = petData.id;
                            //
                            //    return Container(
                            //      width: MediaQuery.of(context).size.width,
                            //      child: Row(
                            //        children: [
                            //          Icon(Icons
                            //              .navigate_before_rounded,
                            //            color: Config.white,
                            //            size: 30,),
                            //          const Spacer(
                            //            flex: 5,
                            //          ),
                            //          Stack(
                            //            children: [
                            //              RawMaterialButton(
                            //                onPressed: () { print(petData.id); },
                            //                child: Container(
                            //                    decoration: const BoxDecoration(
                            //                      shape: BoxShape
                            //                          .circle,
                            //                      color: kLightBlue,
                            //                    ),
                            //                    height:
                            //                    MediaQuery
                            //                        .of(context)
                            //                        .size
                            //                        .height * 0.1,
                            //                    width: MediaQuery
                            //                        .of(context)
                            //                        .size
                            //                        .width * 0.2,
                            //                    child: (petData.image.length>3)
                            //                        ? ClipRRect(
                            //                        borderRadius: BorderRadius
                            //                            .circular(
                            //                            40),
                            //                        child: Image
                            //                            .network(
                            //                          petData.image,
                            //                          fit: BoxFit
                            //                              .fill,))
                            //                        : Center(child: Icon(Icons.person,color: Config.white,))
                            //
                            //                ),
                            //              ),
                            //
                            //            ],
                            //          ),
                            //          const Spacer(
                            //            flex: 1,
                            //          ),
                            //
                            //          Container(
                            //            height: MediaQuery.of(context).size.height*0.1,
                            //            child: Column(
                            //              children: [
                            //                Text(
                            //                  petData.name,
                            //                  style: const TextStyle(
                            //                      color: Colors
                            //                          .white,
                            //                      fontSize: 30,
                            //                      fontWeight: FontWeight
                            //                          .bold),
                            //                ),
                            //                Text(
                            //                  petData.breed,
                            //                  style: const TextStyle(
                            //                    color: Colors.white,
                            //                    fontSize: 17,
                            //                  ),
                            //                )
                            //              ],
                            //            ),
                            //          ),
                            //          const Spacer(
                            //            flex: 5,
                            //          ),
                            //          Icon(Icons.navigate_next,
                            //            color: Config.white,
                            //            size: 30,),
                            //        ],
                            //      ),
                            //    );
                            //   }).toList(),
                            // ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RawMaterialButton(
                                onPressed: () {
                                  kNavigator(context, Desparasitacion());
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child:
                                      Image.asset('assets/images/2diary.png'),
                                ),
                              ),
                              RawMaterialButton(
                                onPressed: () {
                                  kNavigator(context, Vaccination());
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child:
                                      Image.asset('assets/images/3diary.png'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RawMaterialButton(
                                onPressed: () {
                                  kNavigator(context, Visits());
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child:
                                      Image.asset('assets/images/5diary.png'),
                                ),
                              ),
                              RawMaterialButton(
                                onPressed: () {
                                  kNavigator(context, MedicalExams());
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child:
                                      Image.asset('assets/images/4diary.png'),
                                ),
                              ),
                            ],
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

  Future<void> _pickImageFromGallery(bool profile, BuildContext context,petId) async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (profile) {
        context
            .read<ApiService>()
            .updateProfilePetImage(pickedFile.path, petId);
      } else {
        context.read<ApiService>().setImagePath(pickedFile.path);
      }
    }
  }


}
