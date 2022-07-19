// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'des_m.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Des _$DesFromJson(Map<String, dynamic> json) => Des(

  year1: json['year1'] as String,
  month1: json['month1'] as String,
  day: json['day'] as String,
  year2: json['year2'] as String,
  month2: json['month2'] as String,
  day2: json['day2'] as String,
  time1:json['time1'] as Timestamp,
  time2:json['time2'] as Timestamp,
  intern: json['internos'] as String,
  extern:json['externnos'] as String,
);

Map<String, dynamic> _$DesToJson(Des instance) => <String, dynamic>{

  'year1': instance.year1,
  'month1': instance.month1,
  'day': instance.day,
  'year2': instance.year2,
  'month2': instance.month2,
  'day2': instance.day2,
  'time1': instance.time1,
  'time2': instance.time2,
  'internos': instance.intern,
  'externnos': instance.extern,
};
