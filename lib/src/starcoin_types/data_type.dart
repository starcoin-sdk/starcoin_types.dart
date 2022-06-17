part of starcoin_types_types;

abstract class DataType {
  const DataType();

  void serialize(BinarySerializer serializer);

  static DataType deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserializeVariantIndex();
    switch (index) {
      case 0: return DataTypeCODEItem.load(deserializer);
      case 1: return DataTypeRESOURCEItem.load(deserializer);
      default: throw Exception("Unknown variant index for DataType: " + index.toString());
    }
  }

  Uint8List bcsSerialize() {
      final serializer = BcsSerializer();
      serialize(serializer);
      return serializer.bytes;
  }

  static DataType bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = DataType.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }
}


@immutable
class DataTypeCODEItem extends DataType {
  const DataTypeCODEItem(
  ) : super();

  DataTypeCODEItem.load(BinaryDeserializer deserializer);

  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(0);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is DataTypeCODEItem
    ;}

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        ')';
      return true;
    }());

    return fullString ?? 'DataTypeCODEItem';
  }
}

@immutable
class DataTypeRESOURCEItem extends DataType {
  const DataTypeRESOURCEItem(
  ) : super();

  DataTypeRESOURCEItem.load(BinaryDeserializer deserializer);

  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(1);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is DataTypeRESOURCEItem
    ;}

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        ')';
      return true;
    }());

    return fullString ?? 'DataTypeRESOURCEItem';
  }
}
