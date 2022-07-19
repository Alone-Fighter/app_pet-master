import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'des_m.g.dart';

@JsonSerializable()
class Des {



  String year1 = '';
  String month1 = '';
  String day ='';
  String year2 = '';
  String month2 = '';
  String day2 ='';
  Timestamp time1 ;
  Timestamp time2;
  String intern ='';
  String extern ;




  Des({



    required this.year1,
    required this.month1,
    required this.day,
    required this.year2,
    required this.month2,
    required this.day2,
    required this.time1,
    required this.time2,
    required this.extern,
    required this.intern,


  });

  factory Des.fromJson(Map<String, dynamic> json) => _$DesFromJson(json);

  Map<String, dynamic> toJson() => _$DesToJson(this);

}