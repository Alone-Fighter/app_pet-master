// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

newsData _$newsDataFromJson(Map<String, dynamic> json) => newsData(
      image: json['image'] as String,
      link: json['link'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$newsDataToJson(newsData instance) => <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'image': instance.image,
    };
