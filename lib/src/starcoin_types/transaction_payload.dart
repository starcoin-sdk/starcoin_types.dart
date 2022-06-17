part of starcoin_types_types;

abstract class TransactionPayload {
  const TransactionPayload();

  void serialize(BinarySerializer serializer);

  static TransactionPayload deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserializeVariantIndex();
    switch (index) {
      case 0: return TransactionPayloadScriptItem.load(deserializer);
      case 1: return TransactionPayloadPackageItem.load(deserializer);
      case 2: return TransactionPayloadScriptFunctionItem.load(deserializer);
      default: throw Exception("Unknown variant index for TransactionPayload: " + index.toString());
    }
  }

  Uint8List bcsSerialize() {
      final serializer = BcsSerializer();
      serialize(serializer);
      return serializer.bytes;
  }

  static TransactionPayload bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = TransactionPayload.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }
}


@immutable
class TransactionPayloadScriptItem extends TransactionPayload {
  const TransactionPayloadScriptItem({
    required this.value,
  }) : super();

  TransactionPayloadScriptItem.load(BinaryDeserializer deserializer) :
    value = Script.deserialize(deserializer);

  final Script value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(0);
    value.serialize(serializer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TransactionPayloadScriptItem
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

    return fullString ?? 'TransactionPayloadScriptItem';
  }
}

@immutable
class TransactionPayloadPackageItem extends TransactionPayload {
  const TransactionPayloadPackageItem({
    required this.value,
  }) : super();

  TransactionPayloadPackageItem.load(BinaryDeserializer deserializer) :
    value = Package.deserialize(deserializer);

  final Package value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(1);
    value.serialize(serializer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TransactionPayloadPackageItem
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

    return fullString ?? 'TransactionPayloadPackageItem';
  }
}

@immutable
class TransactionPayloadScriptFunctionItem extends TransactionPayload {
  const TransactionPayloadScriptFunctionItem({
    required this.value,
  }) : super();

  TransactionPayloadScriptFunctionItem.load(BinaryDeserializer deserializer) :
    value = ScriptFunction.deserialize(deserializer);

  final ScriptFunction value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(2);
    value.serialize(serializer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TransactionPayloadScriptFunctionItem
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

    return fullString ?? 'TransactionPayloadScriptFunctionItem';
  }
}
