import 'package:hive/hive.dart';

part 'alarm_info.g.dart';

@HiveType(typeId: 1)
class AlarmInfo {
  @HiveField(0)
  bool active;

  @HiveField(1)
  DateTime dateTime;

  @HiveField(2)
  String description;

  @HiveField(3)
  String title;

  @HiveField(4)
  int id;

  AlarmInfo({required this.active, required this.dateTime,required this.description,required this.title,required this.id});

}