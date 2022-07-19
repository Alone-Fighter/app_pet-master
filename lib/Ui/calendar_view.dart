import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Ui/new_calender_view.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/dropdown_options.dart';
import 'package:app_pet/Utils/my_text_form.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalendarViewChangeNotifier extends ChangeNotifier {
  DateTime now = DateTime.now();
  int month = DateTime.now().month;
  int day = 30;
  int year = DateTime.now().year;
  bool start = true;
  String monthName = '';
  int selected = 6;

  int get getYear => year;

  int get getMonth => month;

  String get getMouthName => monthName;

  int get getDays => day;

  int get isSelected => selected;

  init() {
    DateTime lastDayOfMonth = DateTime(getYear, getMonth, 0);
    day = lastDayOfMonth.day + 1;
    if (start) {
      selected = DateTime.now().day;
      start = false;
    }
    initMonthName();
  }

  initMonthName() {
    DateTime lastDayOfMonth = DateTime(getYear, getMonth + 1, 0);
    DateFormat format = DateFormat("MMMM");
    var formattedDate = format.format(lastDayOfMonth);
    monthName = formattedDate.toString();
    notifyListeners();
  }

  setSelected(BuildContext context,int index , int week) {
    if (selected == index) {
      showDialogCal(context , week);
    } else {
      selected = index;
    }
    notifyListeners();
  }

  showDialogCal(BuildContext context , int week) {
    double w = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: w * 0.80,
            height: w * 0.80,
            color: Config.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {
                  Provider.of<ApiService>(context , listen: false).setCalendarItem('vaccine', year, month, selected -  (week - 1),'');
                }, child: const Text('vaccine')),
                TextButton(onPressed: () {
                  Provider.of<ApiService>(context , listen: false).setCalendarItem('visit', year, month, selected -  (week - 1),'');
                }, child: const Text('visit')),
                TextButton(onPressed: () {
                  Provider.of<ApiService>(context , listen: false).setCalendarItem('medicalExam', year, month, selected - (week - 1),'');
                }, child: const Text('medicalExam')),
              ],
            ),
          ),
        );
      },
    );
  }

  nextMonth() {
    if (getMonth < 12) {
      month++;
      initMonthName();
      notifyListeners();
    } else {
      year++;
      month = 1;
      initMonthName();
      notifyListeners();
    }
  }

  setYear(int year) {
    this.year = year;
    notifyListeners();
  }

  pervMonth() {
    if (getMonth > 1) {
      month--;
      initMonthName();
      notifyListeners();
    } else {
      year--;
      month = 12;
      initMonthName();
      notifyListeners();
    }
  }

  static getWeekNumber(String week) {
    switch (week) {
      case 'Sun':
        return 0;
      case 'Mon':
        return 1;
      case 'Tue':
        return 2;
      case 'Wed':
        return 3;
      case 'Thu':
        return 4;
      case 'Fri':
        return 5;
      case 'Sat':
        return 6;
    }
  }
}

class CalendarView extends StatelessWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image(
                    image: const AssetImage('assets/images/cal_background_top.png'),
                    height: h / 3,
                    fit: BoxFit.cover,
                  ),
                )),
            Positioned(
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0, top: 40, right: 16, left: 16),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 16),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Calendar',
                                    style: Config.textStyleH(Colors.white),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Image(
                          image: AssetImage('assets/images/splash_top.png'),
                          color: Colors.white,
                          width: 90,
                          height: 90,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 32, top: 16, bottom: 16),
                        child: Row(
                          children: [
                            ElevatedButton(onPressed: (){
                              kNavigator(context, NewCalendarView());
                            }, child: Text('new calendar')),
                            Container(
                                margin:
                                const EdgeInsets.symmetric(horizontal: 17),
                                color: Colors.white,
                                height: 40,
                                width: 80,
                                child: NewYear(
                                  myHint: '',
                                  onChanged: (val) {
                                    Provider.of<CalendarViewChangeNotifier>(
                                        context,
                                        listen: false)
                                        .setYear(int.parse(val.toString()));
                                  },
                                )),
                            Text(
                              Provider.of<CalendarViewChangeNotifier>(context)
                                  .getMouthName,
                              style: Config.textStyleH(Config.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                        margin:
                        const EdgeInsets.only(left: 50, right: 50, top: 20),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Sun',
                                    style: Config.textStyleS(Config.gray),
                                  ),
                                )),
                            Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Mon',
                                    style: Config.textStyleS(Config.gray),
                                  ),
                                )),
                            Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Tue',
                                    style: Config.textStyleS(Config.gray),
                                  ),
                                )),
                            Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Wed',
                                    style: Config.textStyleS(Config.gray),
                                  ),
                                )),
                            Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Thu',
                                    style: Config.textStyleS(Config.gray),
                                  ),
                                )),
                            Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Fri',
                                    style: Config.textStyleS(Config.gray),
                                  ),
                                )),
                            Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Sat',
                                    style: Config.textStyleS(Config.gray),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Provider.of<CalendarViewChangeNotifier>(context,
                                  listen: false)
                                  .pervMonth();
                            },
                            child: Container(
                              width: 25,
                              margin: const EdgeInsets.only(left: 5),
                              height: ((w - 100) / 8) * 6,
                              alignment: Alignment.center,
                              child: const Icon(Icons.arrow_back_ios),
                            ),
                          ),
                          Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: Provider.of<ApiService>(context).getCalendarItem(),
                              builder: (context,
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
                                  print('ok 1');
                                  if (snapshot.data!.docs.isNotEmpty) {

                                    print('data : ${snapshot.data!.size}');
                                    String petId = Provider.of<ApiService>(context).getSelectedPet;
                                    List<Map<String, dynamic>> data = [];
                                    snapshot.data!.docs.map((e) {
                                      data.add(e.data() as Map<String, dynamic>);
                                    }).toList();


                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child:
                                      Consumer<CalendarViewChangeNotifier>(
                                        builder: (context, value, child) {
                                          String week = DateFormat('E')
                                              .format(DateTime(value.getYear, value.getMonth, 1))
                                              .substring(0, 3);
                                          int weekNum =
                                          CalendarViewChangeNotifier
                                              .getWeekNumber(week);
                                          return Column(
                                            children: [
                                              SizedBox(
                                                height: ((w - 100) / 8) * 6,
                                                child: GridView.count(
                                                  crossAxisCount: 7,
                                                  mainAxisSpacing: 0,
                                                  shrinkWrap: false,
                                                  physics:
                                                  const NeverScrollableScrollPhysics(),
                                                  children: List.generate(
                                                      value.getDays + weekNum,
                                                          (index) {
                                                        bool event = false;
                                                        data.map((e) {
                                                          if (int.parse(e['year']) == value.getYear) {
                                                            if (int.parse(e['month']) == value.getMonth) {
                                                              if((index - weekNum) + 1 == int.parse(e['day'])){
                                                                event = true;
                                                              }
                                                            }
                                                          }
                                                        }).toList();
                                                        if (index >= weekNum) {
                                                          print('list : ${(index - weekNum) + 1}');
                                                          print('event : $event');
                                                          return InkWell(
                                                            onTap: () {
                                                              value.setSelected(context, index , weekNum);
                                                            },
                                                            child: Center(
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .center,
                                                                margin:
                                                                const EdgeInsets
                                                                    .all(3),
                                                                decoration: BoxDecoration(
                                                                    color: index == value.isSelected
                                                                        ? Config.blue
                                                                        : event ? Config.blue.withOpacity(.5) : Colors.transparent,
                                                                    shape: BoxShape.circle),
                                                                child: Text(
                                                                  '${(index - weekNum) + 1}',
                                                                  style: Config.textStyleM(index ==
                                                                      value
                                                                          .isSelected
                                                                      ? Config.white
                                                                      : Colors.black
                                                                      .withOpacity(
                                                                      .7)),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          return Center(
                                                            child: Container(
                                                              alignment:
                                                              Alignment.center,
                                                              width: (w - 48) / 7,
                                                              height: (w - 48) / 7,
                                                              child: Text(
                                                                '',
                                                                style: Config
                                                                    .textStyleM(Colors
                                                                    .black
                                                                    .withOpacity(
                                                                    .7)),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      }),
                                                ),
                                              ),
                                              Container(
                                                height: 20,
                                                alignment: Alignment.centerLeft,
                                                margin: const EdgeInsets.only(
                                                    left: 10, top: 16),
                                                child: Text(
                                                  'event',
                                                  textAlign: TextAlign.left,
                                                  style: Config.textStyleH(
                                                      Colors.black),
                                                ),
                                              ),
                                              ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                const NeverScrollableScrollPhysics(),
                                                itemCount: data.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return eventView(
                                                      data.elementAt(index));
                                                },
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child:
                                      Consumer<CalendarViewChangeNotifier>(
                                        builder: (context, value, child) {
                                          String week = DateFormat('E')
                                              .format(DateTime(value.getYear,
                                              value.getMonth, 1))
                                              .substring(0, 3);
                                          int weekNum =
                                          CalendarViewChangeNotifier
                                              .getWeekNumber(week);
                                          return Column(
                                            children: [
                                              SizedBox(
                                                height: ((w - 100) / 8) * 6,
                                                child: GridView.count(
                                                  crossAxisCount: 7,
                                                  mainAxisSpacing: 0,
                                                  shrinkWrap: false,
                                                  physics:
                                                  const NeverScrollableScrollPhysics(),
                                                  children: List.generate(
                                                      value.getDays + weekNum,
                                                          (index) {
                                                        // int event = -1 ;
                                                        // mData.map((e){
                                                        //   if(e['year'] == value.getYear ){
                                                        //     if(e['month'] == value.getMonth){
                                                        //       event = e['day'];
                                                        //     }
                                                        //   }
                                                        // }).toList();
                                                        if (index >= weekNum) {
                                                          return InkWell(
                                                            onTap: () {
                                                              value.setSelected(context, index , weekNum);
                                                            },
                                                            child: Center(
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .center,
                                                                margin:
                                                                const EdgeInsets
                                                                    .all(3),
                                                                decoration: BoxDecoration(
                                                                    color: index ==
                                                                        value
                                                                            .isSelected
                                                                        ? Config
                                                                        .blue
                                                                        : Colors
                                                                        .transparent,
                                                                    shape: BoxShape
                                                                        .circle),
                                                                child: Text(
                                                                  '${(index - weekNum) + 1}',
                                                                  style: Config.textStyleM(index ==
                                                                      value
                                                                          .isSelected
                                                                      ? Config.white
                                                                      : Colors.black
                                                                      .withOpacity(
                                                                      .7)),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          return Center(
                                                            child: Container(
                                                              alignment:
                                                              Alignment.center,
                                                              width: (w - 48) / 7,
                                                              height: (w - 48) / 7,
                                                              child: Text(
                                                                '',
                                                                style: Config
                                                                    .textStyleM(Colors
                                                                    .black
                                                                    .withOpacity(
                                                                    .7)),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      }),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  }
                                } else {
                                  return const Center(
                                    child: Waitting(),
                                  );
                                }
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Provider.of<CalendarViewChangeNotifier>(context,
                                  listen: false)
                                  .nextMonth();
                            },
                            child: Container(
                              width: 25,
                              margin: const EdgeInsets.only(right: 5),
                              height: ((w - 100) / 8) * 6,
                              alignment: Alignment.center,
                              child: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget eventView(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 55,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: double.infinity,
                  height: 70,
                  margin: const EdgeInsets.only(left: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: Row(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          data['day'],
                          style: Config.textStyleB(Config.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: Text(
                          data['mode'],
                          style: Config.textStyleH(Config.white),
                        ),
                      )
                    ],
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
    );
  }
}
