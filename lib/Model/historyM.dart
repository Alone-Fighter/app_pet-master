import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'historyM.g.dart';

@JsonSerializable()
class historyData {


  String comment = '';
  String record = '';
  String address = '';
  String year = '';
  String month = '';
  String day ='';
  Timestamp time ;




  historyData({


    required this.comment,
    required this.year,
    required this.month,
    required this.day,
    required this.time,
    required this.address,
    required this.record,

  });

  factory historyData.fromJson(Map<String, dynamic> json) => _$historyDataFromJson(json);

  Map<String, dynamic> toJson() => _$historyDataToJson(this);

}