import 'package:json_annotation/json_annotation.dart';

part 'tips.g.dart';

@JsonSerializable()
class tipsData {


  String day = '';
  String details = '';
  String image = '';
  String month= '';
  String title = '';
  String link = '';
  String tname= '';
  String timage = '';
  String tlink = '';


  tipsData({
    required this.day ,
    required this.details,
    required this.image,
    required this.month,
    required this.title,
    required this.link,
    required this.tname,
    required this.timage,
    required this.tlink,

  });

  factory tipsData.fromJson(Map<String, dynamic> json) => _$tipsDataFromJson(json);

  Map<String, dynamic> toJson() => _$tipsDataToJson(this);

}