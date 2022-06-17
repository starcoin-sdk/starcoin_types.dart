part of starcoin_types_types;

@immutable
class ScriptFunctionABI {
  const ScriptFunctionABI({
    required this.name,
    required this.moduleName,
    required this.doc,
    required this.tyArgs,
    required this.args,
  });

  ScriptFunctionABI.deserialize(BinaryDeserializer deserializer) :
    name = deserializer.deserializeString(),
    moduleName = ModuleId.deserialize(deserializer),
    doc = deserializer.deserializeString(),
    tyArgs = TraitHelpers.deserializeVectorTypeArgumentAbi(deserializer),
    args = TraitHelpers.deserializeVectorArgumentAbi(deserializer);

  static ScriptFunctionABI bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = ScriptFunctionABI.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final String name;
  final ModuleId moduleName;
  final String doc;
  final List<TypeArgumentABI> tyArgs;
  final List<ArgumentABI> args;


  void serialize(BinarySerializer serializer) {
    serializer.serializeString(name);
    moduleName.serialize(serializer);
    serializer.serializeString(doc);
    TraitHelpers.serializeVectorTypeArgumentAbi(tyArgs, serializer);
    TraitHelpers.serializeVectorArgumentAbi(args, serializer);
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

    return other is ScriptFunctionABI
    &&  name == other.name
    &&  moduleName == other.moduleName
    &&  doc == other.doc
    &&  listEquals(tyArgs, other.tyArgs)
    &&  listEquals(args, other.args)
    ;}

  @override
  int get hashCode => Object.hash(
        name,
        moduleName,
        doc,
        tyArgs,
        args,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'name: $name, '
        'moduleName: $moduleName, '
        'doc: $doc, '
        'tyArgs: $tyArgs, '
        'args: $args'
        ')';
      return true;
    }());

    return fullString ?? 'ScriptFunctionABI';
  }
}
