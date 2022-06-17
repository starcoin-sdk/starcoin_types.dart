part of starcoin_types_types;

@immutable
class MultiEd25519Signature {
  const MultiEd25519Signature({
    required this.value,
  });

  MultiEd25519Signature.deserialize(BinaryDeserializer deserializer) :
    value = deserializer.deserializeBytes();

  static MultiEd25519Signature bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = MultiEd25519Signature.deserialize(deserializer);
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

    return other is MultiEd25519Signature
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

    return fullString ?? 'MultiEd25519Signature';
  }
}
