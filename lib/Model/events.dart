import 'package:json_annotation/json_annotation.dart';

part 'events.g.dart';

@JsonSerializable()
class EventsData {


  String title = '';
  String details = '';
  String image= '';
  String link= '';



  EventsData({

    required this.image,
    required this.details,
    required this.title,
    required this.link,

  });

  factory EventsData.fromJson(Map<String, dynamic> json) => _$EventsDataFromJson(json);

  Map<String, dynamic> toJson() => _$EventsDataToJson(this);

}