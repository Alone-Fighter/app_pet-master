import 'dart:core';
import 'package:app_pet/CustomWidgets/calendar.dart';
import 'package:app_pet/CustomWidgets/calendar2.dart';
import 'package:app_pet/CustomWidgets/calendar3.dart';
import 'package:app_pet/CustomWidgets/drawer.dart';
import 'package:app_pet/CustomWidgets/headerpage.dart';
import 'package:app_pet/Model/pet.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Ui/Location.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/desparas_history.dart';
import 'package:app_pet/Utils/history.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../CustomWidgets/notification.dart';
import '../Model/alarm_info.dart';

class Desparasitacion extends StatelessWidget
    implements CalendarCallBack2, CalendarCallBack3, UploadStatus {
  Desparasitacion({Key? key}) : super(key: key);
  late BuildContext context;
  String petId = '';
  var imagePath = '-1';
  DateTime datetime1 = DateTime.now();
  DateTime datetime2 = DateTime.now();
  bool isselectdate =false;
  bool isselecttime = false ;
  bool isselecttime2 = false ;
  bool isselectdate2 = false ;



  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      backgroundColor: kVacsanBlue,
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
              'Desparasitación',
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

                  if (value.petId.isEmpty) {
                    value.setPetId(PetData.fromJson(snapshot.data!.docs
                            .elementAt(0)
                            .data() as Map<String, dynamic>)
                        .id);
                  }
                  return SingleChildScrollView(
                    child: SizedBox(
                      height: 1000,
                      child: HeaderPage(
                        widget: Expanded(
                          child: PageView(
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (val) {
                              PetData petData = PetData.fromJson(
                                  snapshot.data!.docs.elementAt(val).data()
                                      as Map<String, dynamic>);
                              petId = petData.id;
                              value.setPetId(petData.id);
                              print('change $petId');
                            },
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              // Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                              PetData petData = PetData.fromJson(
                                  document.data()! as Map<String, dynamic>);

                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Container(
                                      child: Stack(children: [
                                    Positioned(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.navigate_before_rounded,
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
                                                          shape:
                                                              BoxShape.circle,
                                                          color: kLightBlue,
                                                        ),
                                                        height:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                0.1,
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.2,
                                                        child: (petData.image
                                                                    .length >
                                                                3)
                                                            ? ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40),
                                                                child: Image
                                                                    .network(
                                                                  petData.image,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ))
                                                            : const Center(
                                                                child:
                                                                    Text('?'))),
                                                    // Positioned(
                                                    //   bottom: 0,
                                                    //   right: -15,
                                                    //   child: IconButton(
                                                    //     onPressed: () {
                                                    //       _pickImageFromGallery(context);
                                                    //     },
                                                    //     icon: const Icon(
                                                    //       Icons.add_circle,
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
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      petData.breed,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
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
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.18,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showDialog<String>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Dialog(
                                                          child: DesparasitHistory(
                                                              petData.id,
                                                              'desparasitacion',
                                                              '1'));
                                                    });
                                              },
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                  ),
                                                  Text(
                                                    'Historial',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 35),
                                              child: CalendarWeek2(
                                                height: 250,
                                                color: Colors.blue,
                                                buttonText: 'Agendar',
                                                title: '',
                                                calendarCallBack: this,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showDialog<String>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Dialog(
                                                          child: DesparasitHistory(
                                                              petData.id,
                                                              'desparasitacion',
                                                              '2'));
                                                    });
                                              },
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                  ),
                                                  Text(
                                                    'Historial',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 35),
                                              child: CalendarWeek3(
                                                height: 250,
                                                color: Colors.blue,
                                                buttonText: 'Agendar',
                                                title: '',
                                                calendarCallBack: this,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                value.updateDesparasitacionImage(petData.id);
                                                if(isselectdate && isselecttime){
                                                  BoxOpen1(petData);

                                                };
                                                if(isselectdate2 && isselecttime2){
                                                  BoxOpen2(petData);
                                                };
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 50,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16,
                                                        horizontal: 35),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: kLightBlue,
                                                ),
                                                child: Text(
                                                  'GUARDAR',
                                                  style: Config.textStyleH(
                                                      Config.white),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ])));
                            }).toList(),
                          ),
                        ),
                        background: "assets/images/background3.png",
                        color: kDarkBlueHeader,
                      ),
                    ),
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

  Future<void> _pickImageFromGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      context.read<ApiService>().updateProfilePetImage(pickedFile.path, petId);
      print('path is:' + pickedFile.path.toString());
    }
  }

  @override
  void call(int day, int month, int year, String inter,DateTime dateTime,bool isseldate,bool isseltime) {
    print('$day' + '$month' + '$year');
    isselectdate = isseldate;
    isselecttime = isseltime;
    datetime1 = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute
    );
    context.read<ApiService>().setDesDate('$day', '${month}', '$year', inter,dateTime,isseldate,isseltime);
    ModeSnackBar.show(context, 'operación exitosa', SnackBarMode.success);
  }

  @override
  void error() {
    // TODO: implement error
  }

  @override
  void uploaded() {
    // TODO: implement uploaded
  }

  @override
  void uploading() {
    // TODO: implement uploading
  }

  Future BoxOpen1(PetData petData)async{
    Alarm_Set alarmset = Alarm_Set();
    var box = await Hive.openBox('alarm');
    String name = petData.name;
    String type = petData.petType;
    print(datetime1);
    AlarmInfo todo = AlarmInfo(
        active: true,
        dateTime: DateTime(datetime1.year,
          datetime1.month,
          datetime1.day,
          datetime1.hour,
          datetime1.minute,),
        description: '¡Muy bien! Hoy es un día especial porque desparasitaste a tu mascota. Recuerda programar en tu calendario el recordatorio de desparasitación del próximo mes',
        title: '$type   $name',
        id: box.length);
    alarmset.adddata(todo);
  }
  Future BoxOpen2(PetData petData)async{
    Alarm_Set alarmset = Alarm_Set();
    var box = await Hive.openBox('alarm');
    String name = petData.name;
    String type = petData.petType;
    print(datetime2);
    AlarmInfo todo = AlarmInfo(
        active: true,
        dateTime: DateTime(datetime2.year,
          datetime2.month,
          datetime2.day,
          datetime2.hour,
          datetime2.minute,),
        description: '¡Bien por usted! Hoy es un día especial porque protegiste a tu mascota contra los parásitos internos. Recuerda programar en tu calendario el recordatorio de desparasitación del próximo mes.',
        title: '$type   $name',
        id: box.length);
    alarmset.adddata(todo);
  }

  @override
  void call2(int day, int month, int year, String exter,DateTime dateTime,bool isseldate,bool isseltime) {
    print('$day' + '$month' + '$year');
    isselectdate2 = isseldate;
    isselecttime2 = isseltime;
    datetime2 = DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        dateTime.hour,
        dateTime.minute
    );
    context.read<ApiService>().setDesEDate('$day', '${month}', '$year', exter,dateTime,isseldate,isseltime);
    ModeSnackBar.show(context, 'operación exitosa', SnackBarMode.success);
  }
}
