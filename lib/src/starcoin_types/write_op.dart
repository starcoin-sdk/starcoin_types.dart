part of starcoin_types_types;

abstract class WriteOp {
  const WriteOp();

  void serialize(BinarySerializer serializer);

  static WriteOp deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserializeVariantIndex();
    switch (index) {
      case 0: return WriteOpDeletionItem.load(deserializer);
      case 1: return WriteOpValueItem.load(deserializer);
      default: throw Exception("Unknown variant index for WriteOp: " + index.toString());
    }
  }

  Uint8List bcsSerialize() {
      final serializer = BcsSerializer();
      serialize(serializer);
      return serializer.bytes;
  }

  static WriteOp bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = WriteOp.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }
}


@immutable
class WriteOpDeletionItem extends WriteOp {
  const WriteOpDeletionItem(
  ) : super();

  WriteOpDeletionItem.load(BinaryDeserializer deserializer);

  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(0);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is WriteOpDeletionItem
    ;}

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        ')';
      return true;
    }());

    return fullString ?? 'WriteOpDeletionItem';
  }
}

@immutable
class WriteOpValueItem extends WriteOp {
  const WriteOpValueItem({
    required this.value,
  }) : super();

  WriteOpValueItem.load(BinaryDeserializer deserializer) :
    value = deserializer.deserializeBytes();

  final Bytes value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(1);
    serializer.serializeBytes(value);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is WriteOpValueItem
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

    return fullString ?? 'WriteOpValueItem';
  }
}
