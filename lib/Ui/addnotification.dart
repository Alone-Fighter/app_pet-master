import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../CustomWidgets/button_widget.dart';
import '../CustomWidgets/notification.dart';
import '../Model/alarm_info.dart';
import '../Utils/config.dart';
import '../constants.dart';

class AddNotification extends StatefulWidget {
  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  TextEditingController titlealarm = TextEditingController();
  TextEditingController descriptionalarm = TextEditingController();

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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Agregar notificación'),
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
                  text: getText(),
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
         dateTime: DateTime(dateTime.year,
           dateTime.month,
           dateTime.day,
           dateTime.hour,
           dateTime.minute,),
         description: descriptionalarm.text,
         title: titlealarm.text,
         id: box.length);
     alarmset.adddata(todo);
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;

    return newDate;
  }


  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }
}
