// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'previsao.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrevisaoAdapter extends TypeAdapter<Previsao> {
  @override
  final int typeId = 2;

  @override
  Previsao read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Previsao(
      valor: fields[0] as double,
      data: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Previsao obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.valor)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrevisaoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
