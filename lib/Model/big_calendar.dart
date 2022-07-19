import 'package:json_annotation/json_annotation.dart';

part 'big_calendar.g.dart';

@JsonSerializable()
class CalendarData {

  String day= '';
  String mode= '';
  String month= '';
  String year= '';
  String description= '';




  CalendarData({

    required this.day,
    required this.mode,
    required this.month,
    required this.year,
    required this.description,



  });

  factory CalendarData.fromJson(Map<String, dynamic> json) => _$CalendarDataFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarDataToJson(this);

}