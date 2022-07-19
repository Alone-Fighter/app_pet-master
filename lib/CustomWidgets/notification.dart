import 'dart:async';

import 'package:app_pet/Model/alarm_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';

import '../main.dart';


class Alarm_Set extends ChangeNotifier {
  adddata(AlarmInfo alarmInfo) async {
    var box = await Hive.openBox('alarm');
    int result = await box.add(alarmInfo).whenComplete(() async{
      var scheduledtime = alarmInfo.dateTime;
      var endtime = alarmInfo.dateTime.add(Duration(minutes: 1));
      var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'Alarm',
        'Knock - Knock Alarm',
        channelDescription: 'Setted up for alamr notification',
        icon: '@mipmap/ic_launcher',
        largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        styleInformation: BigTextStyleInformation(''),
        playSound: true,
        enableVibration: true,
      );
      var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
          sound: 'a_long_cold_sting.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true);
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.schedule(alarmInfo.id, alarmInfo.title, alarmInfo.description,
          scheduledtime, platformChannelSpecifics,androidAllowWhileIdle: true).whenComplete((){
        Timer.periodic(Duration(seconds: 1), (timer) {
          final currentTime = DateTime.now();
          if (currentTime.isAfter(scheduledtime.add(Duration(seconds: 4))) &&
              currentTime.isBefore(endtime)) {
            print("Hello World");
            AlarmInfo alarm = AlarmInfo(active: false, dateTime: alarmInfo.dateTime, description: alarmInfo.description, title: alarmInfo.title, id: alarmInfo.id);
            box.putAt(alarmInfo.id, alarm);
          }
        });
      });

    });
    print(alarmInfo.id);
    notifyListeners();
  }
}

