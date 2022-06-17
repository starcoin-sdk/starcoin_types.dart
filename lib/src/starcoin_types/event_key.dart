part of starcoin_types_types;

@immutable
class EventKey {
  const EventKey({
    required this.value,
  });

  EventKey.deserialize(BinaryDeserializer deserializer) :
    value = deserializer.deserializeBytes();

  static EventKey bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = EventKey.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final Bytes value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeBytes(value);
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

    return other is EventKey
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

    return fullString ?? 'EventKey';
  }
}
