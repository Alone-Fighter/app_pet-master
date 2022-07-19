// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'big_calendar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalendarDataFromJson(Map<String, dynamic> json) => CalendarData(
  day: json['day'] as String,
  mode: json['mode'] as String,
  month: json['month'] as String,
  year: json['year'] as String,
  description: json['description'] as String,

);

Map<String, dynamic> _$CalendarDataToJson(CalendarData instance) =>
    <String, dynamic>{
      'day': instance.day,
      'mode': instance.mode,
      'month': instance.month,
      'year': instance.year,
      'description': instance.description,
    };
