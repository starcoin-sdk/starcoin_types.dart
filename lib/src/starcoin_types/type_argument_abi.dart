part of starcoin_types_types;

@immutable
class TypeArgumentABI {
  const TypeArgumentABI({
    required this.name,
  });

  TypeArgumentABI.deserialize(BinaryDeserializer deserializer) :
    name = deserializer.deserializeString();

  static TypeArgumentABI bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = TypeArgumentABI.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final String name;


  void serialize(BinarySerializer serializer) {
    serializer.serializeString(name);
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

    return other is TypeArgumentABI
    &&  name == other.name
    ;}

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'name: $name'
        ')';
      return true;
    }());

    return fullString ?? 'TypeArgumentABI';
  }
}
