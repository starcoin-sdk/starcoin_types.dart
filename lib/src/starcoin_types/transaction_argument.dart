part of starcoin_types_types;

abstract class TransactionArgument {
  const TransactionArgument();

  void serialize(BinarySerializer serializer);

  static TransactionArgument deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserializeVariantIndex();
    switch (index) {
      case 0: return TransactionArgumentU8Item.load(deserializer);
      case 1: return TransactionArgumentU64Item.load(deserializer);
      case 2: return TransactionArgumentU128Item.load(deserializer);
      case 3: return TransactionArgumentAddressItem.load(deserializer);
      case 4: return TransactionArgumentU8VectorItem.load(deserializer);
      case 5: return TransactionArgumentBoolItem.load(deserializer);
      default: throw Exception("Unknown variant index for TransactionArgument: " + index.toString());
    }
  }

  Uint8List bcsSerialize() {
      final serializer = BcsSerializer();
      serialize(serializer);
      return serializer.bytes;
  }

  static TransactionArgument bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = TransactionArgument.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }
}


@immutable
class TransactionArgumentU8Item extends TransactionArgument {
  const TransactionArgumentU8Item({
    required this.value,
  }) : super();

  TransactionArgumentU8Item.load(BinaryDeserializer deserializer) :
    value = deserializer.deserializeUint8();

  final int value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(0);
    serializer.serializeUint8(value);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TransactionArgumentU8Item
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

    return fullString ?? 'TransactionArgumentU8Item';
  }
}

@immutable
class TransactionArgumentU64Item extends TransactionArgument {
  const TransactionArgumentU64Item({
    required this.value,
  }) : super();

  TransactionArgumentU64Item.load(BinaryDeserializer deserializer) :
    value = deserializer.deserializeUint64();

  final Uint64 value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(1);
    serializer.serializeUint64(value);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TransactionArgumentU64Item
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

    return fullString ?? 'TransactionArgumentU64Item';
  }
}

@immutable
class TransactionArgumentU128Item extends TransactionArgument {
  const TransactionArgumentU128Item({
    required this.value,
  }) : super();

  TransactionArgumentU128Item.load(BinaryDeserializer deserializer) :
    value = deserializer.deserializeUint128();

  final Uint128 value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(2);
    serializer.serializeUint128(value);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TransactionArgumentU128Item
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

    return fullString ?? 'TransactionArgumentU128Item';
  }
}

@immutable
class TransactionArgumentAddressItem extends TransactionArgument {
  const TransactionArgumentAddressItem({
    required this.value,
  }) : super();

  TransactionArgumentAddressItem.load(BinaryDeserializer deserializer) :
    value = AccountAddress.deserialize(deserializer);

  final AccountAddress value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(3);
    value.serialize(serializer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TransactionArgumentAddressItem
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

    return fullString ?? 'TransactionArgumentAddressItem';
  }
}

@immutable
class TransactionArgumentU8VectorItem extends TransactionArgument {
  const TransactionArgumentU8VectorItem({
    required this.value,
  }) : super();

  TransactionArgumentU8VectorItem.load(BinaryDeserializer deserializer) :
    value = deserializer.deserializeBytes();

  final Bytes value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(4);
    serializer.serializeBytes(value);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TransactionArgumentU8VectorItem
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

    return fullString ?? 'TransactionArgumentU8VectorItem';
  }
}

@immutable
class TransactionArgumentBoolItem extends TransactionArgument {
  const TransactionArgumentBoolItem({
    required this.value,
  }) : super();

  TransactionArgumentBoolItem.load(BinaryDeserializer deserializer) :
    value = deserializer.deserializeBool();

  final bool value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(5);
    serializer.serializeBool(value);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TransactionArgumentBoolItem
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

    return fullString ?? 'TransactionArgumentBoolItem';
  }
}
