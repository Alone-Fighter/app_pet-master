import 'package:app_pet/Ui/new_calender_view.dart';
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

class EditeEvent extends StatefulWidget {
  String selectedDate;

  var documentId;

  var description;

  var title;

  EditeEvent({Key? key, required this.selectedDate,required this.documentId,required this.title,required this.description}) : super(key: key);

  @override
  State<EditeEvent> createState() => _EditeEventState();
}

class _EditeEventState extends State<EditeEvent> {
  TextEditingController titlealarm = TextEditingController();

  TextEditingController descriptionalarm = TextEditingController();

  var dateTime = DateTime.now();
   bool picked=false;
  String getText() {
    if (picked==false) {
      return widget.selectedDate;
    } else {
      return DateFormat('MM/dd/yyyy HH:mm').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Agregar Eventos'),
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
                    const SizedBox(
                      height: 180,
                    ),
                    ButtonHeaderWidget(
                      title: 'Fecha y hora :',
                      text: getText(),
                      onClicked: () => pickDateTime(context),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: TextFormField(
                        decoration:  InputDecoration(
                            border:  OutlineInputBorder(),
                            labelText: widget.title),
                        onChanged: (value) {
                          titlealarm.text = value;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: TextFormField(
                        decoration:  InputDecoration(
                            border: OutlineInputBorder(),

                            labelText: widget.description),
                        onChanged: (value) {
                          descriptionalarm.text = value;
                          print(descriptionalarm.text);
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        onSave();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => NewCalendarView()),
                        );
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
                          'ACTUALIZAR',
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

  Future onSave() async {
    Provider.of<ApiService>(context, listen: false).editCalendarItem(
        titlealarm.text,
        dateTime.year,
        dateTime.month,
        dateTime.day,
        descriptionalarm.text,
         widget.documentId
    );


    print(descriptionalarm.text);
    print(titlealarm.text);
  }

  Future pickDateTime(BuildContext context) async {
    picked=true;
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
    final initialTime = const TimeOfDay(hour: 9, minute: 0);
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
