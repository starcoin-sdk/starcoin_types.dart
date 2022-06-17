part of starcoin_types_types;

@immutable
class TransactionScriptABI {
  const TransactionScriptABI({
    required this.name,
    required this.doc,
    required this.code,
    required this.tyArgs,
    required this.args,
  });

  TransactionScriptABI.deserialize(BinaryDeserializer deserializer) :
    name = deserializer.deserializeString(),
    doc = deserializer.deserializeString(),
    code = deserializer.deserializeBytes(),
    tyArgs = TraitHelpers.deserializeVectorTypeArgumentAbi(deserializer),
    args = TraitHelpers.deserializeVectorArgumentAbi(deserializer);

  static TransactionScriptABI bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = TransactionScriptABI.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }

  final String name;
  final String doc;
  final Bytes code;
  final List<TypeArgumentABI> tyArgs;
  final List<ArgumentABI> args;


  void serialize(BinarySerializer serializer) {
    serializer.serializeString(name);
    serializer.serializeString(doc);
    serializer.serializeBytes(code);
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

    return other is TransactionScriptABI
    &&  name == other.name
    &&  doc == other.doc
    &&  code == other.code
    &&  listEquals(tyArgs, other.tyArgs)
    &&  listEquals(args, other.args)
    ;}

  @override
  int get hashCode => Object.hash(
        name,
        doc,
        code,
        tyArgs,
        args,
      );

  @override
  String toString() {
    String? fullString;

    assert(() {
      fullString = '$runtimeType('
        'name: $name, '
        'doc: $doc, '
        'code: $code, '
        'tyArgs: $tyArgs, '
        'args: $args'
        ')';
      return true;
    }());

    return fullString ?? 'TransactionScriptABI';
  }
}
