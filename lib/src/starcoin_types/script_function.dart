part of starcoin_types_types;

@immutable
class ScriptFunction {
  const ScriptFunction({
    required this.module,
    required this.function,
    required this.tyArgs,
    required this.args,
  });

  ScriptFunction.deserialize(BinaryDeserializer deserializer) :
    module = ModuleId.deserialize(deserializer),
    function = Identifier.deserialize(deserializer),
    tyArgs = TraitHelpers.deserializeVectorTypeTag(deserializer),
    args = TraitHelpers.deserializeVectorBytes(deserializer);

  static ScriptFunction bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = ScriptFunction.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final ModuleId module;
  final Identifier function;
  final List<TypeTag> tyArgs;
  final List<Bytes> args;


  void serialize(BinarySerializer serializer) {
    module.serialize(serializer);
    function.serialize(serializer);
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

    return other is ScriptFunction
    &&  module == other.module
    &&  function == other.function
    &&  listEquals(tyArgs, other.tyArgs)
    &&  listEquals(args, other.args)
    ;}

  @override
  int get hashCode => Object.hash(
        module,
        function,
        tyArgs,
        args,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'module: $module, '
        'function: $function, '
        'tyArgs: $tyArgs, '
        'args: $args'
        ')';
      return true;
    }());

    return fullString ?? 'ScriptFunction';
  }
}
