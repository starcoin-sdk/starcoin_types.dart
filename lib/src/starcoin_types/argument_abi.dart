part of starcoin_types_types;

@immutable
class ArgumentABI {
  const ArgumentABI({
    required this.name,
    required this.typeTag,
  });

  ArgumentABI.deserialize(BinaryDeserializer deserializer) :
    name = deserializer.deserializeString(),
    typeTag = TypeTag.deserialize(deserializer);

  static ArgumentABI bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = ArgumentABI.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final String name;
  final TypeTag typeTag;


  void serialize(BinarySerializer serializer) {
    serializer.serializeString(name);
    typeTag.serialize(serializer);
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

    return other is ArgumentABI
    &&  name == other.name
    &&  typeTag == other.typeTag
    ;}

  @override
  int get hashCode => Object.hash(
        name,
        typeTag,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'name: $name, '
        'typeTag: $typeTag'
        ')';
      return true;
    }());

    return fullString ?? 'ArgumentABI';
  }
}
