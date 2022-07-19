import 'package:app_pet/CustomWidgets/navigatebar.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigatorBar(),
      body: SafeArea(
        child: Center(
          child: CalendarWeek(),
        ),
      ),
    );
  }
}

class CalendarChangeNotifier extends ChangeNotifier {
  ScrollController scrollController = ScrollController();
  DateTime now = DateTime.now();
  int month = DateTime.now().month;
  int week = 0;
  int day = 30;
  int year = DateTime.now().year;
  bool start = true;
  List<int> points = [];
  int selected = 6;
  String monthName = '';

  int get getYear => year;

  int get getMonth => month;

  String get getMouthName => monthName;

  int get getDays => day;

  ScrollController get getScrollController => scrollController;

  int get isSelected => selected;

  List<int> get isPoint => points;

  setSelected(int index) {
    selected = index;
    notifyListeners();
  }

  init(double w) {
    DateTime lastDayOfMonth = DateTime(getYear, getMonth, 0);
    day = lastDayOfMonth.day + 1;
    if (start) {
      selected = DateTime.now().day;
      if (selected > (day - 7)) {
        week = day - 7;
        scrollController = ScrollController(initialScrollOffset: w * week);
      } else {
        week = selected;
        scrollController = ScrollController(initialScrollOffset: w * week);
      }
      start = false;
    }
    initMonthName(w);
  }

  initMonthName(double w) {
    DateTime lastDayOfMonth = DateTime(getYear, getMonth, 0);
    DateFormat format = DateFormat("MMMM");
    var formattedDate = format.format(lastDayOfMonth);
    monthName = formattedDate.toString();
  }

  down(double w) {
    if (week > 0) {
      week--;
      scrollController.jumpTo(w * week);
    } else {
      if (getMonth == 1) {
        year--;
        month = 12;
        init(w);
        week = day - 7;
        scrollController.jumpTo(w * week);
      } else {
        month--;
        init(w);
        week = day - 7;
        scrollController.jumpTo(w * week);
      }
      notifyListeners();
    }
  }

  monthUp(double w) {
    if (getMonth == 12) {
      year++;
      month = 1;
      init(w);
      week = 0;
      scrollController.jumpTo(w * week);
    } else {
      month++;
      init(w);
      week = 0;
      scrollController.jumpTo(w * week);
    }
    notifyListeners();
  }

  monthDown(double w) {
    if (getMonth == 1) {
      year--;
      month = 12;
      init(w);
      week = day - 7;
      scrollController.jumpTo(w * week);
    } else {
      month--;
      init(w);
      week = day - 7;
      scrollController.jumpTo(w * week);
    }
    notifyListeners();
  }

  up(double w) {
    if (week < (getDays - 7)) {
      week++;
      scrollController.jumpTo(w * week);
    } else {
      if (getMonth == 12) {
        year++;
        month = 1;
        init(w);
        week = 0;
        scrollController.jumpTo(w * week);
      } else {
        month++;
        init(w);
        week = 0;
        scrollController.jumpTo(w * week);
      }
      notifyListeners();
    }
  }
}

class CalendarWeek extends StatelessWidget {
  CalendarWeek(
      {Key? key,
      this.color,
      this.height,
      this.calendarCallBack,
      this.title,
      this.buttonText})
      : super(key: key);

  final Color? color;
  final double? height;
  final CalendarCallBack? calendarCallBack;
  final String? title;
  final String? buttonText;

  DateTime dateTime = DateTime.now();

  String getText() {
    if (dateTime == null) {
      return 'Select DateTime';
    } else {
      return DateFormat('MM/dd/yyyy HH:mm').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width * 0.95;
    double size = (w - 60) / 7;
    Provider.of<CalendarChangeNotifier>(context).init(size);

    return Consumer<CalendarChangeNotifier>(
      builder: (context, value, child) {
        return Container(
          width: w,
          height: (height == null) ? 220 : height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color ?? color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //           child: Container(
              //         height: 30,
              //         alignment: Alignment.centerLeft,
              //         child: Text(
              //           title!,
              //           style: Config.textStyleS(Config.white),
              //         ),
              //       )),
              //       InkWell(
              //         onTap: () {
              //           calendarCallBack?.call(
              //               dateTime.day, dateTime.month, dateTime.year);
              //         },
              //         child: Container(
              //           height: 30,
              //           alignment: Alignment.center,
              //           padding: const EdgeInsets.symmetric(horizontal: 10),
              //           decoration: BoxDecoration(
              //             color: Config.white,
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //           child: Text(
              //             buttonText!,
              //             style: Config.textStyleM(Colors.black),
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                width: double.infinity,

                child: Column(
                  children: [
                    Text('Fecha y hora :',style: TextStyle(color: Config.white,fontFamily: 'Mont',fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        pickDateTime(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        decoration: BoxDecoration(
                          color: Config.white,
                          borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 20,
                                  offset: Offset(0, 0)
                              ),
                            ]
                        ),
                        child: Center(child: Text(dateTime.toString().substring(0,19),style: TextStyle(fontFamily: 'Mont',fontSize: 20,fontWeight: FontWeight.bold),)),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   height: 40,
              //   alignment: Alignment.center,
              //   margin: const EdgeInsets.only(bottom: 8),
              //   child: Row(
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           double size = (w - 60) / 7;
              //           value.monthDown(size);
              //         },
              //         child:  SizedBox(
              //           width: 40,
              //           height: 40,
              //           child: Icon(Icons.arrow_back_ios , color: Config.white,),
              //         ),
              //       ),
              //       Expanded(
              //           child: Text('${value.getMouthName} ${value.getYear}',
              //               style: Config.textStyleH(Config.white))),
              //       InkWell(
              //         onTap: () {
              //           double size = (w - 60) / 7;
              //           value.monthUp(size);
              //         },
              //         child:  SizedBox(
              //           width: 40,
              //           height: 40,
              //           child: Icon(Icons.arrow_forward_ios , color: Config.white,),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   height: 90,
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           double size = (w - 60) / 7;
              //           value.down(size);
              //         },
              //         child: SizedBox(
              //           width: 30,
              //           height: 90,
              //           child: Container(
              //             alignment: Alignment.centerRight,
              //             child: Icon(
              //               Icons.arrow_back_ios,
              //               color: Config.white,
              //             ),
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //           child: ListView.builder(
              //         physics: const NeverScrollableScrollPhysics(),
              //         scrollDirection: Axis.horizontal,
              //         controller: value.getScrollController,
              //         itemCount: value.getDays,
              //         itemBuilder: (context, index) {
              //           String week = DateFormat('EEEE')
              //               .format(DateTime(
              //                   value.getYear, value.getMonth, index + 1))
              //               .substring(0, 3);
              //           bool point = false;
              //           value.isPoint.map((e) {
              //             if (index == e) {
              //               point = true;
              //             }
              //           }).toList();
              //           return InkWell(
              //               onTap: () {
              //                 value.setSelected(index);
              //               },
              //               child: daysItem(
              //                   w,
              //                   week,
              //                   '$index',
              //                   index == value.isSelected ? true : false,
              //                   point));
              //         },
              //       )),
              //       InkWell(
              //         onTap: () {
              //           double size = (w - 60) / 7;
              //           value.up(size);
              //         },
              //         child: SizedBox(
              //           width: 30,
              //           height: 90,
              //           child: Container(
              //             alignment: Alignment.centerLeft,
              //             child: Icon(
              //               Icons.arrow_forward_ios,
              //               color: Config.white,
              //             ),
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        );
      },
    );
  }

  Widget daysItem(
      double w, String week, String day, bool selected, bool point) {
    double size = (w - 60) / 7;
    return Container(
      width: size,
      height: 90,
      decoration: BoxDecoration(
          color: selected ? Config.white : color,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 30,
            child: Text(
              week,
              style: Config.textStyleS(selected ? Config.blue : Config.white),
            ),
            alignment: Alignment.center,
          ),
          Container(
            height: 30,
            alignment: Alignment.center,
            child: Text(
              day,
              style: Config.textStyleH(selected ? Config.blue : Config.white),
            ),
          ),
          Container(
            height: 30,
            alignment: Alignment.center,
            child: Icon(
              Icons.calendar_today_rounded,
              color: point
                  ? selected
                      ? color
                      : Config.white.withOpacity(.7)
                  : selected
                      ? Config.white
                      : color,
              size: point
                  ? selected
                      ? 22
                      : 18
                  : 22,
            ),
          ),
        ],
      ),
    );
  }
  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    calendarCallBack?.call(
        dateTime.day, dateTime.month, dateTime.year,dateTime.hour,dateTime.minute);
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      cancelText: 'cancelar',
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      cancelText: 'cancelar',
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }
}


abstract class CalendarCallBack {
  void call(int day, int month, int year,int hour,int min);
}
