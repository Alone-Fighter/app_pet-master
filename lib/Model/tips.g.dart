// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tips.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

tipsData _$tipsDataFromJson(Map<String, dynamic> json) => tipsData(
      day: json['day'] as String,
      details: json['details'] as String,
      image: json['image'] as String,
      month: json['month'] as String,
      title: json['title'] as String,
      link: json['link'] as String,
      tname: json['tname'] as String,
      tlink: json['tlink'] as String,
      timage: json['timage'] as String,
    );

Map<String, dynamic> _$tipsDataToJson(tipsData instance) => <String, dynamic>{
      'day': instance.day,
      'details': instance.details,
      'image': instance.image,
      'month': instance.month,
      'title': instance.title,
      'link': instance.link,
    };
