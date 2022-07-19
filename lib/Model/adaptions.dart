import 'package:json_annotation/json_annotation.dart';

part 'adaptions.g.dart';

@JsonSerializable()
class AdaptionsData {


  String name = '';
  String image = '';
  String link = '';
  String city = '';


  AdaptionsData({
    required this.name ,
    required this.image,
    required this.link ,
    required this.city,


  });

  factory AdaptionsData.fromJson(Map<String, dynamic> json) => _$AdaptionsDataFromJson(json);

  Map<String, dynamic> toJson() => _$AdaptionsDataToJson(this);

}