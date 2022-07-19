import 'package:app_pet/CustomWidgets/notification.dart';
import 'package:app_pet/Model/alarm_info.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../main.dart';
import 'addnotification.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Alarm_Set alarmset = Alarm_Set();
    return Scaffold(
      appBar: AppBar(
        title: Text('alarm List'),
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // var box = await Hive.openBox('alarm');
          // AlarmInfo todo = AlarmInfo(
          //     active: true,
          //     dateTime: DateTime.now().add(Duration(seconds: 10)),
          //     description: 'salam',
          //     title: 'test',
          //     id: box.length);
          // alarmset.adddata(todo);
          kNavigator(context, AddNotification());
        },
        child: Icon(Icons.add),
      ),
      body: Stack(children: [
        Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        FutureBuilder(
          future: loadData(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return listViewBuilder();
            } else {
              return const Waitting();
            }
          },
        ),
      ]),
    );
  }
}

Future<Box> loadData() {
  return Hive.openBox('alarm');
}

Widget listViewBuilder() {
  final Box todoBox = Hive.box('alarm');
  return ValueListenableBuilder(
    valueListenable: todoBox.listenable(),
    builder: (BuildContext context, Box box, _) {
      if (box.values.isEmpty) {
        return const Center(
          child: Text('Sin alarma disponible'),
        );
      } else {
        return ListView.builder(
          itemBuilder: (context, index) {
            final AlarmInfo alarmInfo = box.getAt(index);
              return Visibility(
                visible: alarmInfo.active,
                child: Card(
                  child: ListTile(
                    onTap: () {},
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        remove(index);
                      },
                    ),
                    title: Text(alarmInfo.title + "  :  " + alarmInfo.description),
                    subtitle: Text(
                        alarmInfo.dateTime.toString().substring(0, 19)),
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.greenAccent,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Text(
                          alarmInfo.dateTime.day.toString(),
                        ),
                      ),
                    ),
                  ),
                ),
              );
          },
          itemCount: todoBox.length,
        );
      }
    },
  );
}

remove(int index) async {
  Box box = Hive.box('alarm');
  await flutterLocalNotificationsPlugin.cancel(index);
  box.deleteAt(index);
}
