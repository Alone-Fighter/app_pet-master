import 'package:json_annotation/json_annotation.dart';

part 'vet_esp.g.dart';

@JsonSerializable()
class VetEsp {

  String expertise= '';
  String city= '';
  String number= '';
  String name= '';



  VetEsp({

    required this.expertise,
    required this.city,
    required this.number,
    required this.name,


  });

  factory VetEsp.fromJson(Map<String, dynamic> json) => _$VetEspFromJson(json);

  Map<String, dynamic> toJson() => _$VetEspToJson(this);

}