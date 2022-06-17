part of starcoin_types_types;

@immutable
class Script {
  const Script({
    required this.code,
    required this.tyArgs,
    required this.args,
  });

  Script.deserialize(BinaryDeserializer deserializer) :
    code = deserializer.deserializeBytes(),
    tyArgs = TraitHelpers.deserializeVectorTypeTag(deserializer),
    args = TraitHelpers.deserializeVectorBytes(deserializer);

  static Script bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = Script.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final Bytes code;
  final List<TypeTag> tyArgs;
  final List<Bytes> args;


  void serialize(BinarySerializer serializer) {
    serializer.serializeBytes(code);
    TraitHelpers.serializeVectorTypeTag(tyArgs, serializer);
    TraitHelpers.serializeVectorBytes(args, serializer);
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

    return other is Script
    &&  code == other.code
    &&  listEquals(tyArgs, other.tyArgs)
    &&  listEquals(args, other.args)
    ;}

  @override
  int get hashCode => Object.hash(
        code,
        tyArgs,
        args,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'code: $code, '
        'tyArgs: $tyArgs, '
        'args: $args'
        ')';
      return true;
    }());

    return fullString ?? 'Script';
  }
}
