part of starcoin_types_types;

@immutable
class Module {
  const Module({
    required this.code,
  });

  Module.deserialize(BinaryDeserializer deserializer) :
    code = deserializer.deserializeBytes();

  static Module bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = Module.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final Bytes code;


  void serialize(BinarySerializer serializer) {
    serializer.serializeBytes(code);
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

    return other is Module
    &&  code == other.code
    ;}

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'code: $code'
        ')';
      return true;
    }());

    return fullString ?? 'Module';
  }
}
