// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalHistory _$MedicalHistoryFromJson(Map<String, dynamic> json) => MedicalHistory(
  address: json['address'] as String,
  record: json['record'] as String,
  comment: json['comment'] as String,
  time:json['time'] as Timestamp,
);

Map<String, dynamic> _$MedicalHistoryToJson(MedicalHistory instance) => <String, dynamic>{
  'comment': instance.comment,
  'record': instance.address,
  'address': instance.record,
  'time': instance.time,
};
