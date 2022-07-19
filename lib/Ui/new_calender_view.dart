import 'dart:core';
import 'dart:io';
import 'package:app_pet/CustomWidgets/calendar.dart';
import 'package:app_pet/CustomWidgets/drawer.dart';
import 'package:app_pet/Model/pet.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Provider/RecordControler.dart';
import 'package:app_pet/Ui/event_details.dart';
import 'package:app_pet/Ui/testEvent.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/history.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:table_calendar/table_calendar.dart';
import '../Model/big_calendar.dart';
import '../utils.dart';
import 'add_events.dart';

class NewCalendarView extends StatelessWidget
    implements CalendarCallBack, UploadStatus {
  NewCalendarView({Key? key}) : super(key: key);
  late BuildContext context;
  late final ValueNotifier<List> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime datetime = DateTime.now();
  var displayingMonth = DateTime.now().month;
  List<int> evetos=[1,2,3,4];
  FirebaseFirestore fs = FirebaseFirestore.instance;
  // Map<DateTime,List> _groupedEvents;

  // void initState() {
  //   _selectedDay = _focusedDay;
  //   _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  // }
  @override
  Widget build(BuildContext context) {
    this.context = context;
    context.read<ApiService>().resetUpdate();
    return Scaffold(
      body: Consumer<ApiService>(
        builder: (context, value, child) {
          value.apiListenerUpload(this);
          return StreamBuilder<QuerySnapshot>(
              stream: context.read<ApiService>().getCalendarEvent(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                Map<DateTime, List<CalendarData>> _groupedEvents;
                _groupEvents(List<CalendarData> events) {
                  _groupedEvents = {};
                  events.forEach((event) {
                    DateTime date =
                    DateTime.utc(int.parse(event.year), int.parse(event.month), int.parse(event.day), 12);
                    if (_groupedEvents[date] == null) _groupedEvents[date] = [];
                    _groupedEvents[date]?.add(event);
                  });
                }

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
                  final events = snapshot.data;
                  List<CalendarData> foot=[];
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    CalendarData calendarData = CalendarData.fromJson(
                        document.data()! as Map<String, dynamic>);
                    return foot.add(calendarData);
                  }).toList();
                   print(foot.runtimeType);
                  _groupEvents(foot);

                  String petId =
                      Provider.of<ApiService>(context).getSelectedPet;
                  List<Map<String, dynamic>> data = [];
                  snapshot.data!.docs.map((e) {
                    data.add(e.data() as Map<String, dynamic>);
                  }).toList();
                  if (snapshot.data!.docs.isEmpty) {

                    Provider.of<ApiService>(context, listen: false)
                        .setCalendarItem('', 1, 1, 1, '');
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
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          )),
                    );
                  }
                  // return Text('data');
                  return SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(children: [
                              Positioned(
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/images/cal_background_top.png'),
                                      height: MediaQuery.of(context).size.height * 0.34,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Positioned(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 16.0,
                                            top: 40,
                                            right: 16,
                                            left: 16),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 16),
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                    'Calendario',
                                                    style: Config.textStyleH(
                                                        Colors.white),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: const Image(
                                          image: AssetImage(
                                              'assets/images/splash_top.png'),
                                          color: Colors.white,
                                          width: 90,
                                          height: 90,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height:
                                          MediaQuery.of(context).size.height *
                                              0.26),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                                        child: TableCalendar(


                                          onPageChanged: (day){


                                            // displayingMonth=day.month;
                                            // print(day.month);
                                          },
                                          calendarBuilders: CalendarBuilders(

                                            singleMarkerBuilder: (context, date, _) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    color: date == _selectedDay ? Colors.white : Colors.orange), //Change color
                                                width: 15.0,
                                                height: 2.0,
                                                margin: const EdgeInsets.symmetric(horizontal: 1.5),
                                              );
                                            },
                                          ),
                                          calendarStyle: const CalendarStyle(


                                            // Use `CalendarStyle` to customize the UI
                                            outsideDaysVisible: false,
                                          ),
                                          eventLoader: (day) {
                                            print(day.month);
                                            //value.setEventMonth(day.month);
                                            value.eventsMonth=day.month;
                                          for(int i=0;i<foot.length;i++){
                                            if (day.year== int.parse(foot[i].year)) {
                                              if (day.month== int.parse(foot[i].month)) {
                                                if (day.day== int.parse(foot[i].day)) {
                                                  print(day);

                                                  return [('Cyclic event')];
                                                }

                                              }
                                            }

                                          }

                                            return [];
                                          },
                                          headerStyle: HeaderStyle(
                                              titleCentered: true,
                                              titleTextFormatter: (date, locale) => DateFormat.yMMMd(locale).format(date),
                                              formatButtonVisible: false,
                                              titleTextStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05)
                                          ),
                                          firstDay: DateTime.utc(2010, 10, 16),
                                          lastDay: DateTime.utc(2030, 3, 14),
                                          focusedDay: _focusedDay,
                                          selectedDayPredicate: (day) {

                                            return isSameDay(_selectedDay, day);
                                          },
                                          onDaySelected: (selectedDay, focusedDay) {
                                            if (!isSameDay(
                                                _selectedDay, selectedDay)) {
                                              _selectedDay = selectedDay;
                                              _focusedDay = focusedDay;
                                              value.notifyListeners();
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                            ]),
                            Column(
                              children: [
                                Container(
                                  height: 20,
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(left: 30, top: 16),
                                  child: Text(
                                    'eventos',
                                    textAlign: TextAlign.left,
                                    style: Config.textStyleH(Colors.black),
                                  ),
                                ),
                                Container(
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: snapshot.data!.docs.map(

                                            (DocumentSnapshot document) {

                                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                          print(value.eventsMonth);



                                          return Column(

                                            children: [
                                              //(int.parse(data['month'])==value.eventsMonth)?eventView(data,document.id):Container()
                                              (int.parse(data['month'])!= 1)?eventView(data,document.id):Container()

                                            ],
                                          );



                                          //-------------------------------------------------------------------------//
                                        }).toList(),

                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ));
                }

                return const Center(
                  child: Waitting(),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print(_selectedDay);
          // kNavigator(context, TableEventsExample());
          print(_selectedDay);
          print(_focusedDay);
          kNavigator(
              context,
              AddEvents(
                selectedDate:
                (_selectedDay) != null ? _selectedDay : DateTime.now(),
              ));
        },
        child: Icon(
          Icons.add,
          color: Config.white,
        ),
      ),
    );
  }
  Widget eventView(Map<String, dynamic> data,documentId) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          height: 55,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        print(documentId);
                        kNavigator(
                            context,
                            EventDetails(
                              month: data['month'],
                              day: data['day'],
                              year: data['year'],
                              description: data['description'], title: data['mode'], documentId: documentId,
                            ));

                      },
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        margin: const EdgeInsets.only(left: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //color: Colors.blue,
                            border: Border.all(color: Colors.blue)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                data['day'],
                                style: Config.textStyleB(Colors.blue),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 32),
                              child: Text(
                                data['mode'],
                                style: Config.textStyleH(Colors.blue),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
              Positioned(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 8,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }


  @override
  void call(int day, int month, int year, int hour, int min) {
    print('$day' + '$month' + '$year');
    datetime = DateTime(year, month, day, hour, min);
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


