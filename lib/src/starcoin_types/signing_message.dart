part of starcoin_types_types;

@immutable
class SigningMessage {
  const SigningMessage({
    required this.value,
  });

  SigningMessage.deserialize(BinaryDeserializer deserializer) :
    value = TraitHelpers.deserializeVectorU8(deserializer);

  static SigningMessage bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = SigningMessage.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final List<int> value;


  void serialize(BinarySerializer serializer) {
    TraitHelpers.serializeVectorU8(value, serializer);
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

    return other is SigningMessage
    &&  listEquals(value, other.value)
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

    return fullString ?? 'SigningMessage';
  }
}
