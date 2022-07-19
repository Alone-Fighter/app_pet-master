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
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../CustomWidgets/button_widget.dart';
import '../CustomWidgets/notification.dart';
import '../Model/alarm_info.dart';

class Vaccination extends StatelessWidget
    implements CalendarCallBack, UploadStatus {
  Vaccination({Key? key}) : super(key: key);
  late BuildContext context;

  // String petId = '';
  var imagePath = '-1';
  PageController pageController = PageController(
      //initialPage: 0,
      keepPage: true);
  int currentPage = 0;
  bool imagePicked = false;
  DateTime datetime = DateTime.now();


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
        backgroundColor: kVacsanBlue,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Spacer(
              flex: 1,
            ),
            Text(
              'Vacunas',
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
          if (value.imagePath == '-1') {
            value.imagePath = '';
            imagePath = '-1';
            imagePicked = false;
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
                  if (value.petId.isEmpty) {
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
                                child: PageView(

                                  controller: pageController,
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (val) {
                                    currentPage = val;
                                    print(val);

                                    PetData petData = PetData.fromJson(snapshot
                                        .data!.docs
                                        .elementAt(val)
                                        .data() as Map<String, dynamic>);
                                    // petId = petData.id;

                                    value.setPetId(petData.id);
                                    print('change ${petData.id}');
                                  },
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    // Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                                    PetData petData = PetData.fromJson(document
                                        .data()! as Map<String, dynamic>);

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
                                                  "assets/images/vacsinate.png"),
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
                                                          IconButton(
                                                            onPressed: () {
                                                              // pageController.previousPage(
                                                              //     duration: Duration(
                                                              //         milliseconds:
                                                              //         400),
                                                              //     curve: Curves
                                                              //         .easeIn);
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .navigate_before,
                                                              color:
                                                                  Config.white,
                                                              size: 30,
                                                            ),
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
                                                                        28,
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
                                                          IconButton(
                                                            onPressed: () {
                                                              // pageController.nextPage(
                                                              //     duration: Duration(
                                                              //         milliseconds:
                                                              //             400),
                                                              //     curve: Curves
                                                              //         .easeIn);
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .navigate_next,
                                                              color:
                                                                  Config.white,
                                                              size: 30,
                                                            ),
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
                                                                            (BuildContext
                                                                                context) {
                                                                          return Dialog(
                                                                              child: History(petData.id, 'vaccine'));
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
                                                              height: 120,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  RawMaterialButton(
                                                                    onPressed:
                                                                        () {},
                                                                    child: SizedBox(
                                                                        height:
                                                                            120,
                                                                        width:
                                                                            130,
                                                                        child: (value.imagePath.isNotEmpty)
                                                                            ? Image.file(File(value.imagePath))
                                                                            : Image.asset('assets/images/vac1.png')),
                                                                  ),
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Text(
                                                                        'sube la foto del carnet de vacunacion',
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
                                                                        imagePicked =
                                                                            true;
                                                                        _pickImageFromGallery(
                                                                            false,
                                                                            context,
                                                                            petData.id);
                                                                      })
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            SizedBox(
                                                                height: 190,
                                                                child:
                                                                    CalendarWeek(
                                                                  color:
                                                                      kDarkBlue,
                                                                  height: 190,
                                                                  calendarCallBack:
                                                                      this,
                                                                  title:
                                                                      'Agenda tu proxima vacuna',
                                                                  buttonText:
                                                                      'Agendar',
                                                                )

                                                                ),
                                                            const SizedBox(
                                                              height: 20,
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
                                                              height: 150,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Text(
                                                                    'Registra la informacion importante de esta visita (voz y Texto)',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            9,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600),
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
                                                                            SizedBox(
                                                                          height:
                                                                              100,
                                                                          width:
                                                                              100,
                                                                          child:
                                                                              Image.asset('assets/images/vac2.png'),
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            'Comments',
                                                                            style:
                                                                                TextStyle(fontSize: 11, color: Colors.grey.shade600),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                180.0,
                                                                            height:
                                                                                80,
                                                                            decoration:
                                                                                BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                                                                            child:
                                                                                TextField(
                                                                              controller: value.getRecordTextController,
                                                                              decoration: const InputDecoration(border: InputBorder.none, focusedBorder: InputBorder.none, enabledBorder: InputBorder.none, errorBorder: InputBorder.none, disabledBorder: InputBorder.none, contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15), hintText: "Escribe aqui...", hintStyle: TextStyle(fontSize: 10)),
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
                                                                if (imagePicked ==
                                                                    false) {
                                                                  context
                                                                      .read<
                                                                          ApiService>()
                                                                      .setImagePath(
                                                                          '-1');
                                                                  //print(imagePath);
                                                                }
                                                                value.updateVaccineImage(
                                                                    petData.id);
                                                                print(
                                                                    petData.id);
                                                                BoxOpen(petData);
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
                                                                      kDarkBlue,
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



  Future<void> _pickImageFromGallery(
      bool profile, BuildContext context, petId) async {
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
  Future BoxOpen(PetData petData)async{
    Alarm_Set alarmset = Alarm_Set();
    var box = await Hive.openBox('alarm');
    String name = petData.name;
    String type = petData.petType;
    AlarmInfo todo = AlarmInfo(
        active: true,
        dateTime: DateTime(datetime.year,
          datetime.month,
          datetime.day,
          datetime.hour,
          datetime.minute,),
        description: 'Hoy es un día especial para el cuidado y la salud de tu mascota. Recuerda agendar el recordatorio de la próxima fecha de vacunación en el calendario.',
        title: '$type    $name',
        id: box.length);
    alarmset.adddata(todo);
  }

  @override
  void call(int day, int month, int year,int hour,int min) {
    print('$day' + '$month' + '$year');
    datetime = DateTime(
      year,
      month,
      day,
      hour,
      min
    );
    context.read<ApiService>().setVacDate('$day', '${month}', '$year');
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
