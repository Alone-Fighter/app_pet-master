import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hfoto.g.dart';

@JsonSerializable()
class Hfotos {



  String address = '';
  Timestamp time ;




  Hfotos({



    required this.address,
    required this.time,

  });

  factory Hfotos.fromJson(Map<String, dynamic> json) => _$HfotosFromJson(json);

  Map<String, dynamic> toJson() => _$HfotosToJson(this);

}