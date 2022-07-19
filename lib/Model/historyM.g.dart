// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historyM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

historyData _$historyDataFromJson(Map<String, dynamic> json) => historyData(
  address: json['address'] as String,
  record: json['record'] as String,
  comment: json['comment'] as String,
  year: json['year'] as String,
  month: json['month'] as String,
  day: json['day'] as String,
  time:json['time'] as Timestamp,
);

Map<String, dynamic> _$historyDataToJson(historyData instance) => <String, dynamic>{
  'comment': instance.comment,
  'record': instance.address,
  'address': instance.record,
  'year': instance.year,
  'month': instance.month,
  'day': instance.day,
  'time': instance.time,
};
