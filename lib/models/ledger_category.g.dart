// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LedgerCategoryAdapter extends TypeAdapter<LedgerCategory> {
  @override
  final int typeId = 2;

  @override
  LedgerCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LedgerCategory(
      name: fields[0] as String,
      position: fields[1] as int,
      iconKey: fields[2] as String,
      colorArgb: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LedgerCategory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.position)
      ..writeByte(2)
      ..write(obj.iconKey)
      ..writeByte(3)
      ..write(obj.colorArgb);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LedgerCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
