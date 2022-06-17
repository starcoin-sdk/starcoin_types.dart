part of starcoin_types_types;

@immutable
class EventHandle {
  const EventHandle({
    required this.count,
    required this.key,
  });

  EventHandle.deserialize(BinaryDeserializer deserializer) :
    count = deserializer.deserializeUint64(),
    key = EventKey.deserialize(deserializer);

  static EventHandle bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = EventHandle.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final Uint64 count;
  final EventKey key;


  void serialize(BinarySerializer serializer) {
    serializer.serializeUint64(count);
    key.serialize(serializer);
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

    return other is EventHandle
    &&  count == other.count
    &&  key == other.key
    ;}

  @override
  int get hashCode => Object.hash(
        count,
        key,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'count: $count, '
        'key: $key'
        ')';
      return true;
    }());

    return fullString ?? 'EventHandle';
  }
}
