// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlarmInfoAdapter extends TypeAdapter<AlarmInfo> {
  @override
  final int typeId = 1;

  @override
  AlarmInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlarmInfo(
      active: fields[0] as bool,
      dateTime: fields[1] as DateTime,
      description: fields[2] as String,
      title: fields[3] as String,
      id: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AlarmInfo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.active)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
