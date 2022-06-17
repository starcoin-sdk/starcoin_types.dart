part of starcoin_types_types;

abstract class ScriptABI {
  const ScriptABI();

  void serialize(BinarySerializer serializer);

  static ScriptABI deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserializeVariantIndex();
    switch (index) {
      case 0: return ScriptAbiTransactionScriptItem.load(deserializer);
      case 1: return ScriptAbiScriptFunctionItem.load(deserializer);
      default: throw Exception("Unknown variant index for ScriptABI: " + index.toString());
    }
  }

  Uint8List bcsSerialize() {
      final serializer = BcsSerializer();
      serialize(serializer);
      return serializer.bytes;
  }

  static ScriptABI bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = ScriptABI.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }
}


@immutable
class ScriptABITransactionScriptItem extends ScriptABI {
  const ScriptABITransactionScriptItem({
    required this.value,
  }) : super();

  ScriptABITransactionScriptItem.load(BinaryDeserializer deserializer) :
    value = TransactionScriptABI.deserialize(deserializer);

  final TransactionScriptABI value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(0);
    value.serialize(serializer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is ScriptABITransactionScriptItem
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

    return fullString ?? 'ScriptABITransactionScriptItem';
  }
}

@immutable
class ScriptABIScriptFunctionItem extends ScriptABI {
  const ScriptABIScriptFunctionItem({
    required this.value,
  }) : super();

  ScriptABIScriptFunctionItem.load(BinaryDeserializer deserializer) :
    value = ScriptFunctionABI.deserialize(deserializer);

  final ScriptFunctionABI value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(1);
    value.serialize(serializer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is ScriptABIScriptFunctionItem
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

    return fullString ?? 'ScriptABIScriptFunctionItem';
  }
}
