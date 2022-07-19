import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class ProductData {


  String name = '';
  String image = '';
  String category='';
  String link='';




  ProductData({
    required this.name ,
    required this.image,
    required this.category,
    required this.link,


  });

  factory ProductData.fromJson(Map<String, dynamic> json) => _$ProductDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDataToJson(this);

}