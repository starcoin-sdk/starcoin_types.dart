part of starcoin_types_types;

abstract class DataPath {
  const DataPath();

  void serialize(BinarySerializer serializer);

  static DataPath deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserializeVariantIndex();
    switch (index) {
      case 0: return DataPathCodeItem.load(deserializer);
      case 1: return DataPathResourceItem.load(deserializer);
      default: throw Exception("Unknown variant index for DataPath: " + index.toString());
    }
  }

  Uint8List bcsSerialize() {
      final serializer = BcsSerializer();
      serialize(serializer);
      return serializer.bytes;
  }

  static DataPath bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = DataPath.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }
}


@immutable
class DataPathCodeItem extends DataPath {
  const DataPathCodeItem({
    required this.value,
  }) : super();

  DataPathCodeItem.load(BinaryDeserializer deserializer) :
    value = Identifier.deserialize(deserializer);

  final Identifier value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(0);
    value.serialize(serializer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is DataPathCodeItem
    &&  value == other.value
    ;}

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'value: $value'
        ')';
      return true;
    }());

    return fullString ?? 'DataPathCodeItem';
  }
}

@immutable
class DataPathResourceItem extends DataPath {
  const DataPathResourceItem({
    required this.value,
  }) : super();

  DataPathResourceItem.load(BinaryDeserializer deserializer) :
    value = StructTag.deserialize(deserializer);

  final StructTag value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(1);
    value.serialize(serializer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is DataPathResourceItem
    &&  value == other.value
    ;}

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'value: $value'
        ')';
      return true;
    }());

    return fullString ?? 'DataPathResourceItem';
  }
}
