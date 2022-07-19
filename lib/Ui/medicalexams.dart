import 'dart:core';
import 'dart:io';
import 'package:app_pet/CustomWidgets/calendar.dart';
import 'package:app_pet/CustomWidgets/drawer.dart';
import 'package:app_pet/Model/pet.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Provider/RecordControler.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/history.dart';
import 'package:app_pet/Utils/medical_exam_history.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class MedicalExams extends StatelessWidget
    implements CalendarCallBack, UploadStatus {
  MedicalExams({Key? key}) : super(key: key);
  late BuildContext context;
  String petId = '';
  var imagePath = '-1';
  bool imagePicked=false;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    context.read<ApiService>().resetUpdate();
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              size: 35,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: kDarkBlueHeader,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Spacer(
              flex: 1,
            ),
            Text(
              'Exámenes médicos',
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
          if(value.imagePath=='-1'){
            value.imagePath='';
            imagePath='-1';
            imagePicked=false;
          }
          value.apiListenerUpload(this);
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
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                    );
                  }
                  // return Text('data');
                  print(PetData.fromJson(snapshot.data!.docs.elementAt(0).data()
                  as Map<String, dynamic>)
                      .id);
                  if(value.petId.isEmpty){
                    value.setPetId(PetData.fromJson(snapshot.data!.docs
                        .elementAt(0)
                        .data() as Map<String, dynamic>)
                        .id);
                  }
                  return Stack(
                    children: [
                      Positioned(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height * 1.1,
                                    child:  PageView(
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged: (val) {
                                        PetData petData = PetData.fromJson(snapshot.data!.docs.elementAt(val).data() as Map<String, dynamic>);
                                        petId = petData.id;
                                        value.setPetId(petData.id);
                                        print('change $petId');
                                      },
                                      children: snapshot.data!.docs.map((
                                          DocumentSnapshot document) {
                                        // Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                                        PetData petData = PetData.fromJson(document.data()!  as Map<String, dynamic>);

                                        return Stack(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.8,
                                              width:
                                              MediaQuery.of(context).size.width,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/background3.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Container(
                                                    child: Stack(children: [
                                                      Positioned(
                                                        child: Align(
                                                          alignment: Alignment.center,
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 26,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .navigate_before_rounded,
                                                                    color: Config.white,
                                                                    size: 30,
                                                                  ),
                                                                  const Spacer(
                                                                    flex: 5,
                                                                  ),
                                                                  Stack(
                                                                    children: [
                                                                      Container(
                                                                          decoration:
                                                                          const BoxDecoration(
                                                                            shape: BoxShape
                                                                                .circle,
                                                                            color:
                                                                            kLightBlue,
                                                                          ),
                                                                          height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                              0.1,
                                                                          width: MediaQuery.of(
                                                                              context)
                                                                              .size
                                                                              .width *
                                                                              0.2,
                                                                          child: (petData
                                                                              .image
                                                                              .length >
                                                                              3)
                                                                              ? ClipRRect(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  40),
                                                                              child: Image
                                                                                  .network(
                                                                                petData.image,
                                                                                fit:
                                                                                BoxFit.fill,
                                                                              ))
                                                                              : const Center(
                                                                              child:
                                                                              Text('?'))),
                                                                      // Positioned(
                                                                      //   bottom: 0,
                                                                      //   right: -15,
                                                                      //   child:
                                                                      //   IconButton(
                                                                      //     onPressed:
                                                                      //         () async {
                                                                      //       _pickImageFromGallery(
                                                                      //           true,
                                                                      //           context);
                                                                      //     },
                                                                      //     icon:
                                                                      //     const Icon(
                                                                      //       Icons
                                                                      //           .add_circle,
                                                                      //       color: Colors
                                                                      //           .white,
                                                                      //     ),
                                                                      //   ),
                                                                      // ),
                                                                    ],
                                                                  ),
                                                                  const Spacer(
                                                                    flex: 1,
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      Text(
                                                                        petData.name,
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                            30,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                                      ),
                                                                      Text(
                                                                        petData.breed,
                                                                        style:
                                                                        const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize: 15,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  const Spacer(
                                                                    flex: 5,
                                                                  ),
                                                                  Icon(
                                                                    Icons.navigate_next,
                                                                    color: Config.white,
                                                                    size: 30,
                                                                  ),
                                                                ],
                                                              ),
                                                              Container(
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal: 35),
                                                                child: Column(
                                                                  children: [
                                                                    const SizedBox(
                                                                      height: 80,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        const SizedBox(
                                                                          width: 15,
                                                                        ),
                                                                        InkWell(
                                                                          onTap: () {
                                                                            showDialog<
                                                                                String>(
                                                                                context:
                                                                                context,
                                                                                builder:
                                                                                    (BuildContext context) {
                                                                                      return Dialog(
                                                                                          child: medicalExamHistory(
                                                                                              petData.id,
                                                                                              'medicalExam'));

                                                                                    });
                                                                          },
                                                                          child: Text(
                                                                            'Historial',
                                                                            style: TextStyle(
                                                                                color: Colors
                                                                                    .grey
                                                                                    .shade600,
                                                                                decoration:
                                                                                TextDecoration.underline),
                                                                          ),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_sharp,
                                                                          color: Config
                                                                              .gray,
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            15),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color: Colors
                                                                                .grey
                                                                                .withOpacity(
                                                                                0.5),
                                                                            spreadRadius:
                                                                            5,
                                                                            blurRadius:
                                                                            7,
                                                                            offset: const Offset(
                                                                                0,
                                                                                3), // changes position of shadow
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      width: MediaQuery.of(
                                                                          context)
                                                                          .size
                                                                          .width *
                                                                          0.95,
                                                                      height: 160,
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                        children: [
                                                                          RawMaterialButton(
                                                                            onPressed:
                                                                                () {

                                                                            },
                                                                            child: SizedBox(
                                                                                height:
                                                                                120,
                                                                                width:
                                                                                130,
                                                                                child: value.imagePath.isNotEmpty
                                                                                    ? Image.file(File(value.imagePath))
                                                                                    : Image.asset('assets/images/examenesmedicos.png')),
                                                                          ),
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceEvenly,
                                                                            children: [
                                                                              Text(
                                                                                "Agrega los resultados de exámenes médicos \ny radiografías",
                                                                                style: TextStyle(
                                                                                    fontSize:
                                                                                    8,
                                                                                    color:
                                                                                    Colors.grey.shade600),
                                                                              ),
                                                                              MyButton(
                                                                                  'Agregar',
                                                                                  29.0,
                                                                                  90.0,
                                                                                  kDarkBlue,
                                                                                      () {
                                                                                    imagePicked=true;
                                                                                        _pickImageFromGallery(
                                                                                            false,
                                                                                            context);
                                                                                  })
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 20,
                                                                    ),

                                                                    const SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    Container(
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        color: kDarkBlueHeader,
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            15),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color: Colors
                                                                                .grey
                                                                                .withOpacity(
                                                                                0.5),
                                                                            spreadRadius:
                                                                            5,
                                                                            blurRadius:
                                                                            7,
                                                                            offset: const Offset(
                                                                                0,
                                                                                3), // changes position of shadow
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      width: MediaQuery.of(
                                                                          context)
                                                                          .size
                                                                          .width *
                                                                          0.95,
                                                                      height: 150,
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                        children: [
                                                                        const Text(
                                                                        'Registra la informacion importante de esta visita (voz y Texto)',
                                                                        style: TextStyle(
                                                                        fontSize: 9,
                                                                        color: Colors
                                                                            .white),
                                                                        ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceEvenly,
                                                                            children: [
                                                                              RawMaterialButton(
                                                                                onPressed:
                                                                                    () {
                                                                                  showDialog(
                                                                                    context:
                                                                                    context,
                                                                                    builder:
                                                                                        (context) {
                                                                                      return const RecordDialog();
                                                                                    },
                                                                                  );
                                                                                },
                                                                                child:
                                                                                Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.circular(40)
                                                                                  ),
                                                                                  height:
                                                                                  100,
                                                                                  width:
                                                                                  100,
                                                                                  child:
                                                                                  Image.asset('assets/images/IconMic.png'),
                                                                                ),
                                                                              ),
                                                                              Column(
                                                                                mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                                crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                                children: [
                                                                                  const Text(
                                                                                    'Comments',
                                                                                    style:
                                                                                    TextStyle(
                                                                                  fontSize: 9,
                                                                                  color: Colors
                                                                                      .white),
                                                                                  ),
                                                                                  Container(
                                                                                    width:
                                                                                    180.0,
                                                                                    height:
                                                                                    80,
                                                                                    decoration:
                                                                                    BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(10)),
                                                                                    child:
                                                                                    TextField(
                                                                                      controller: value.getRecordTextController,
                                                                                      decoration: const InputDecoration(border: InputBorder.none, focusedBorder: InputBorder.none, enabledBorder: InputBorder.none, errorBorder: InputBorder.none, disabledBorder: InputBorder.none, contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15), hintText: "Escribe aqui...", hintStyle: TextStyle(
                                                                                          fontSize: 9,
                                                                                          color: Colors
                                                                                              .white),),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap: () {
                                                                        if(imagePicked==false){
                                                                          context.read<ApiService>().setImagePath('-1');
                                                                          //print(imagePath);
                                                                        }
                                                                        value
                                                                            .updateMedicalExamImage(
                                                                            petData
                                                                                .id);
                                                                      },
                                                                      child: Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height: 50,
                                                                        margin: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                            16),
                                                                        alignment:
                                                                        Alignment
                                                                            .center,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              15),
                                                                          color:
                                                                          kDarkBlueHeader,
                                                                        ),
                                                                        child: Text(
                                                                          'GUARDAR',
                                                                          style: Config
                                                                              .textStyleH(
                                                                              Config
                                                                                  .white),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ]))),
                                          ],
                                        );

                                        //-------------------------------------------------------------------------//
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                      value.loadingAuth
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
                }

                return const Center(
                  child: Waitting(),
                );
              });
        },
      ),
    );
  }

  Future<void> _pickImageFromGallery(bool profile, BuildContext context) async {
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

  @override
  void call(int day, int month, int year,int hour,int min) {
    print('$day' + '${month-1}' + '$year');
    context.read<ApiService>().setVacDate('$day', '$month', '$year');
    ModeSnackBar.show(context, 'operación exitosa', SnackBarMode.success);
  }

  @override
  void error() {
    ModeSnackBar.show(context, 'Algo sale mal', SnackBarMode.error);
  }

  @override
  void uploaded() {
    ModeSnackBar.show(context, 'operación exitosa', SnackBarMode.success);
  }

  @override
  void uploading() {}
}
