import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medical_history.g.dart';

@JsonSerializable()
class MedicalHistory {


  String comment = '';
  String record = '';
  String address = '';
  Timestamp time ;




  MedicalHistory({


    required this.comment,
    required this.time,
    required this.address,
    required this.record,

  });

  factory MedicalHistory.fromJson(Map<String, dynamic> json) => _$MedicalHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalHistoryToJson(this);

}