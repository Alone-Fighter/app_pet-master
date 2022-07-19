import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class newsData {


  String title = '';
  String link = '';
  String image= '';



  newsData({

    required this.image,
    required this.link,
    required this.title,

  });

  factory newsData.fromJson(Map<String, dynamic> json) => _$newsDataFromJson(json);

  Map<String, dynamic> toJson() => _$newsDataToJson(this);

}