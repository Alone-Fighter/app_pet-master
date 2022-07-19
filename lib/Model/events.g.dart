// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventsData _$EventsDataFromJson(Map<String, dynamic> json) => EventsData(
      image: json['image'] as String,
      details: json['details'] as String,
      title: json['title'] as String,
  link: json['link'] as String,
    );

Map<String, dynamic> _$EventsDataToJson(EventsData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'details': instance.details,
      'image': instance.image,
      'link': instance.link,
    };
