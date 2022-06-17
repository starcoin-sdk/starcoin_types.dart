part of starcoin_types_types;

@immutable
class ChainId {
  const ChainId({
    required this.id,
  });

  ChainId.deserialize(BinaryDeserializer deserializer) :
    id = deserializer.deserializeUint8();

  static ChainId bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = ChainId.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final int id;


  void serialize(BinarySerializer serializer) {
    serializer.serializeUint8(id);
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

    return other is ChainId
    &&  id == other.id
    ;}

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'id: $id'
        ')';
      return true;
    }());

    return fullString ?? 'ChainId';
  }
}
