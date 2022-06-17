part of starcoin_types_types;

abstract class Transaction {
  const Transaction();

  void serialize(BinarySerializer serializer);

  static Transaction deserialize(BinaryDeserializer deserializer) {
    int index = deserializer.deserializeVariantIndex();
    switch (index) {
      case 0: return TransactionUserTransactionItem.load(deserializer);
      case 1: return TransactionBlockMetadataItem.load(deserializer);
      default: throw Exception("Unknown variant index for Transaction: " + index.toString());
    }
  }

  Uint8List bcsSerialize() {
      final serializer = BcsSerializer();
      serialize(serializer);
      return serializer.bytes;
  }

  static Transaction bcsDeserialize(Uint8List input) {
    final deserializer = BcsDeserializer(input);
    final value = Transaction.deserialize(deserializer);
    if (deserializer.offset < input.length) {
      throw Exception('Some input bytes were not read');
    }
    return value;
  }
}


@immutable
class TransactionUserTransactionItem extends Transaction {
  const TransactionUserTransactionItem({
    required this.value,
  }) : super();

  TransactionUserTransactionItem.load(BinaryDeserializer deserializer) :
    value = SignedUserTransaction.deserialize(deserializer);

  final SignedUserTransaction value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(0);
    value.serialize(serializer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TransactionUserTransactionItem
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

    return fullString ?? 'TransactionUserTransactionItem';
  }
}

@immutable
class TransactionBlockMetadataItem extends Transaction {
  const TransactionBlockMetadataItem({
    required this.value,
  }) : super();

  TransactionBlockMetadataItem.load(BinaryDeserializer deserializer) :
    value = BlockMetadata.deserialize(deserializer);

  final BlockMetadata value;


  void serialize(BinarySerializer serializer) {
    serializer.serializeVariantIndex(1);
    value.serialize(serializer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is TransactionBlockMetadataItem
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

    return fullString ?? 'TransactionBlockMetadataItem';
  }
}
