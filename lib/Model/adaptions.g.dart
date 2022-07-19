// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adaptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdaptionsData _$AdaptionsDataFromJson(Map<String, dynamic> json) =>
    AdaptionsData(
      name: json['name'] as String,
      image: json['image'] as String,
      link: json['link'] as String,
      city: json['city'] as String,
    );

Map<String, dynamic> _$AdaptionsDataToJson(AdaptionsData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'link': instance.link,
      'city': instance.city,
    };
