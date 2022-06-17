part of starcoin_types_types;

@immutable
class WriteSet {
  const WriteSet({
    required this.value,
  });

  WriteSet.deserialize(BinaryDeserializer deserializer) :
    value = WriteSetMut.deserialize(deserializer);

  static WriteSet bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = WriteSet.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final WriteSetMut value;


  void serialize(BinarySerializer serializer) {
    value.serialize(serializer);
  }

  Uint8List bcsSerialize() {
      final serializer = BcsSerializer();
      serialize(serializer);
      return serializer.bytes;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is WriteSet
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

    return fullString ?? 'WriteSet';
  }
}
