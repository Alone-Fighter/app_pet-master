import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../CustomWidgets/button_widget.dart';
import '../CustomWidgets/notification.dart';
import '../Model/alarm_info.dart';
import '../Provider/ApiService.dart';
import '../Utils/config.dart';
import '../constants.dart';

class AddEvents extends StatefulWidget {
  DateTime? selectedDate;

  AddEvents({Key? key, required this.selectedDate}) : super(key: key);

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  TextEditingController titlealarm = TextEditingController();
  TextEditingController descriptionalarm = TextEditingController();

  var dateTime = DateTime.now();



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Agregar Eventos'),
            backgroundColor: Colors.grey.shade100,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          body: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 180,
                    ),
                    ButtonHeaderWidget(
                      title: 'Fecha y hora :',
                      text: widget.selectedDate.toString().substring(0, 19),
                      onClicked: () => pickDateTime(context),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'ingrese su título'),
                        onChanged: (value) {
                          titlealarm.text = value;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'ingresa tu descripción'),
                        onChanged: (value) {
                          descriptionalarm.text = value;
                          print(descriptionalarm.text);
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        onSave();
                        BoxOpen();
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 350,
                        height: 50,
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: kDarkBlue,
                        ),
                        child: Text(
                          'GUARDAR',
                          style: Config.textStyleH(Config.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future BoxOpen()async{
    Alarm_Set alarmset = Alarm_Set();
    var box = await Hive.openBox('alarm');
    AlarmInfo todo = AlarmInfo(
        active: true,
        dateTime: DateTime(widget.selectedDate!.year,
          widget.selectedDate!.month,
          widget.selectedDate!.day,
          widget.selectedDate!.hour,
          widget.selectedDate!.minute,),
        description: descriptionalarm.text,
        title: titlealarm.text,
        id: box.length);
    alarmset.adddata(todo);
    print(widget.selectedDate);
  }

  Future onSave() async {
    Provider.of<ApiService>(context, listen: false).setCalendarItem(
        titlealarm.text,
        widget.selectedDate?.year,
        widget.selectedDate?.month,
        widget.selectedDate?.day,
        descriptionalarm.text);


    print(widget.selectedDate?.year);
    print(widget.selectedDate?.month);
    print(widget.selectedDate?.day);
    print(widget.selectedDate?.hour);
    print(widget.selectedDate?.minute);
    print(descriptionalarm.text);
    print(titlealarm.text);
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      widget.selectedDate = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
    print(widget.selectedDate);
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate!,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: widget.selectedDate != null
          ? TimeOfDay(hour: widget.selectedDate!.hour, minute: widget.selectedDate!.minute)
          : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }
}
