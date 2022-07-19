import 'package:json_annotation/json_annotation.dart';

part 'banner.g.dart';

@JsonSerializable()
class BannerData {

  String image= '';



  BannerData({

    required this.image,


  });

  factory BannerData.fromJson(Map<String, dynamic> json) => _$BannerDataFromJson(json);

  Map<String, dynamic> toJson() => _$BannerDataToJson(this);

}