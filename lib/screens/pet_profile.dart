import 'package:app_pet/Model/pet.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Ui/Desparasitacion.dart';
import 'package:app_pet/Ui/medicalexams.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/screens/edit_pet1.dart';
import 'package:app_pet/screens/edit_pet2.dart';
import 'package:app_pet/screens/vaccination.dart';
import 'package:app_pet/screens/visit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';

class PetProfile extends StatelessWidget implements ApiStatusLogin {
  var petId;

  PetProfile({required this.petId});

  @override
  //return fs.collection('users').doc(myUser).snapshots();
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String myId = auth.currentUser!.uid;
    return SafeArea(
      child: Scaffold(
        body: Consumer<ApiService>(
          builder: (context, value, child) {
            value.apiListener(this);
            // value.getImageProfileLink(petId);
            value.getAllPets();
            return SingleChildScrollView(
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: context.read<ApiService>().getAllPets(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          print('hasError');
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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

                          return Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView(
                                    padding: const EdgeInsets.only(top: 5),
                                    children: snapshot.data!.docs
                                        .map((DocumentSnapshot document) {
                                      PetData petData = PetData.fromJson(
                                          document.data()!
                                              as Map<String, dynamic>);
                                      var brth = int.parse(petData.year);
                                      return Container(
                                          child: (petData.id == petId)
                                              ? Container(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                          color: Colors.pink,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.5,
                                                          child: (petData.image
                                                                  .isNotEmpty)
                                                              ? InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    _pickImageFromGallery(
                                                                        true,
                                                                        context,
                                                                        petData
                                                                            .id);
                                                                  },
                                                                  child: Image
                                                                      .network(
                                                                    petData
                                                                        .image,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                )
                                                              : Container(
                                                                  child: Center(
                                                                    child:
                                                                        IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        _pickImageFromGallery(
                                                                            true,
                                                                            context,
                                                                            petData.id);
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .add_a_photo_outlined,
                                                                        color: Config
                                                                            .white,
                                                                        size:
                                                                            40,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )),
                                                      Positioned(
                                                        bottom: 0,
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.65,
                                                          decoration: const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          40),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          40))),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                  margin: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          30,
                                                                      vertical:
                                                                          20),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        petData
                                                                            .name,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                25,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            kNavigator(
                                                                                context,
                                                                                EditPet1(
                                                                                  name: petData.name,
                                                                                  sex: petData.sex,
                                                                                  breed: petData.breed,
                                                                                  weight: petData.size,
                                                                                  year: petData.year,
                                                                                  month: petData.month,
                                                                                  day: petData.day, petId: petData.id,
                                                                                ));
                                                                          },
                                                                          icon:
                                                                              Icon(Icons.edit)),
                                                                      const Spacer(),
                                                                      Container(
                                                                          width: MediaQuery.of(context).size.width *
                                                                              0.12,
                                                                          height: MediaQuery.of(context).size.height *
                                                                              0.05,
                                                                          child:
                                                                              Image.asset(
                                                                            'assets/images/splash_top.png',
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ))
                                                                    ],
                                                                  )),
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                                thickness: 1,
                                                              ),

                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  DetailContainer(
                                                                      context,
                                                                      'Raza',
                                                                      petData
                                                                          .breed,
                                                                      () {}),
                                                                  DetailContainer(
                                                                      context,
                                                                      'Edad',
                                                                      '${DateTime.now().year - brth}' +
                                                                          ' años',
                                                                      () {}),
                                                                  DetailContainer(
                                                                      context,
                                                                      'Sexo',
                                                                      petData
                                                                          .sex,
                                                                      () {}),
                                                                  DetailContainer(
                                                                      context,
                                                                      'Peso',
                                                                      petData
                                                                          .size,
                                                                      () {})
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 50,
                                                              ),
                                                              FutureBuilder<
                                                                  DocumentSnapshot>(
                                                                future: users
                                                                    .doc(myId)
                                                                    .get(),
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            DocumentSnapshot>
                                                                        snapshot) {
                                                                  if (snapshot
                                                                      .hasError) {
                                                                    return const Text(
                                                                        "Something went wrong");
                                                                  }

                                                                  if (snapshot
                                                                          .hasData &&
                                                                      !snapshot
                                                                          .data!
                                                                          .exists) {
                                                                    return const Text(
                                                                        "Document does not exist");
                                                                  }

                                                                  if (snapshot
                                                                          .connectionState ==
                                                                      ConnectionState
                                                                          .done) {
                                                                    Map<String,
                                                                        dynamic> data = snapshot
                                                                            .data!
                                                                            .data()
                                                                        as Map<
                                                                            String,
                                                                            dynamic>;
                                                                    return RawMaterialButton(
                                                                      onPressed: () {
                                                                        kNavigator(context, EditOwner(email: data['email'], name: data['name'], phone: data['number'],));
                                                                      },
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .end,
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.12,
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.8,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              borderRadius:
                                                                                  BorderRadius.only(topLeft: Radius.circular(40), bottomLeft: Radius.circular(40)),
                                                                              gradient:
                                                                                  LinearGradient(
                                                                                begin: Alignment.topRight,
                                                                                end: Alignment.bottomLeft,
                                                                                colors: [
                                                                                  kDarkBlue,
                                                                                  kLightBlue,
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment.start,
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                                                                  child: Text(
                                                                                    'Responsable : ${data['name']}',
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                                                                                  child: Text(
                                                                                    'email : ${data['email']}',
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                                                                                  child: Text(
                                                                                    'número de teléfono : ${data['number']}',
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }

                                                                  return const Text(
                                                                      "loading");
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container());
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return const Center(
                          child: Waitting(),
                        );
                      }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void accountAvailable() {
    // TODO: implement accountAvailable
  }

  @override
  void error() {
    // TODO: implement error
  }

  @override
  void inputEmpty() {
    // TODO: implement inputEmpty
  }

  @override
  void inputWrong() {
    // TODO: implement inputWrong
  }

  @override
  void login() {
    // TODO: implement login
  }

  @override
  void passwordWeak() {
    // TODO: implement passwordWeak
  }
}

DetailContainer(context, text1, text2, onPressd) {
  return InkWell(
    onTap: onPressd,
    child: Container(
      width: MediaQuery.of(context).size.width * 0.23,
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            kDarkBlue,
            kLightBlue,
          ],
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            text1,
            style: const TextStyle(color: Colors.white),
          ),
          Center(
            child: Text(
              text2,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ),
  );
}

Future<void> _pickImageFromGallery(
    bool profile, BuildContext context, petId) async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    if (profile) {
      context.read<ApiService>().updateProfilePetImage(pickedFile.path, petId);
    } else {
      context.read<ApiService>().setImagePath(pickedFile.path);
    }
  }
}
